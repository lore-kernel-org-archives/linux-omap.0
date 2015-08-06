From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 14:51:29 +0100
Message-ID: <20150806135129.GJ7576@n2100.arm.linux.org.uk>
References: <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806102225.GI7576@n2100.arm.linux.org.uk>
 <55C35233.2000105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C35233.2000105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Michal Suchanek <hramrach@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 06, 2015 at 05:55:23PM +0530, Vignesh R wrote:
> On the whole following are my requirements:
> 1. to be able to communicate with non -flash SPI devices via config port
> ( this functionality is supported by current driver, I dont want to
> break it). Or pump any spi_message on to SPI bus directly.
> 2. take advantage of memory mapped port in order to increase read
> throughput( and use dma in future) when the slave is a m25p80 type flash.
> 3. handle m25p80 as well as other slave on multiple chipselects.
> 
> I just need to know whether the user that requested the transfer is
> m25p80 driver. If yes, ti-qspi driver can take advantage of memory
> mapped interface, else just use config port to access SPI bus directly.

The problem with this approach is that it's an abomination.  It's adding
a SPI-user specific hack which is detected by a specific driver.  That's
really not sane - what happens when we have lots of these kinds of "I'm
an X SPI-user" with drivers detecting that?  It's not maintainable in the
long term.

Yes, your requirements _today_ seem simple and easy, but you're only
thinking about today, not tomorrow when you've moved on and someone else
has to maintain the mess left behind (or delete it from mainline because
they're sick of dealing with a hack.)

> The spi_message that is received in transfer_one_message() is too
> generic to imply the slave device that is on the other side of the wire.
> IMO, the read command does not imply that the slave is m25p80 flash
> (besides the read opcodes vary across vendors of m25p80 and across modes).

I can see both sides of the argument.

Mark is saying: if the SPI driver detects that the message to be transmitted
is a read command followed by the appropriate number of dummy bytes, and
then the data being read _and_ it's using quad-mode access, and the hardware
generates _exactly_ that in hardware using the memory mapped mode, there is
no reason _not_ to use the hardware to achieve that SPI transaction.  The
bus activity will be identical to what happens when the SPI controller is
used manually to achieve that bus sequence.

You're saying: but the documentation says you can't use it for anything
except m25p80.  If you look at 24.5.4.1.2, it tells you what the SFI
generates on the bus, which is:

1. CS active
2. Read command byte sent
3. 1-4 address bytes sent
4. 0-3 dummy bytes sent
5. data bytes read from bus
6. CS inactive

So, Mark's point is "if we can detect a transaction which fits _that_
bus activity, there's no reason not to use this acceleration for the
transaction."

What you're failing to counter with is: we don't have enough information
in the SPI driver to know how many dummy bytes there are between the
address bytes and the data read from the bus.

The M25P80 driver just appends additional bytes to the message to
achieve this:

        struct m25p *flash = nor->priv;
        unsigned int dummy = nor->read_dummy;

        /* convert the dummy cycles to the number of bytes */
        dummy /= 8;

        flash->command[0] = nor->read_opcode;
        m25p_addr2cmd(nor, from, flash->command);

        t[0].tx_buf = flash->command;
        t[0].len = m25p_cmdsz(nor) + dummy;
        spi_message_add_tail(&t[0], &m);

The reason that the number of dummy bytes can't be detected is because
it's all hidden in the first transaction as the total number of bytes to
be transmitted - and the dummy bytes are uninitialised, so you can't
make any assumptions what value they are.  There is no way for the SPI
driver to know whether these dummy bytes are dummy bytes or whether they
have an effect on the targetted device.

I think that comprehensively rules out Mark's idea with the SPI core as
it stands today: there is no way for the SPI driver to reliably detect
a message like a SFI read command by parsing the SPI transmitted message
prior to sending it as we can never be sure whether there are dummy bytes
to be transmitted.

What may make more sense from the SPI point of view is to communicate to
all SPI drivers how many dummy bytes are to be transferred.  I'm not fully
up on SPI, but maybe something like this:

	t[0].tx_buf = flash->command;
	t[0].len = m25p_cmdsz(nor);
	spi_message_add_tail(&t[0], &m);
	t[1].tx_buf = dummy_buffer;
	t[1].len = dummy;
	t[1].dummy = 1;
	spi_message_add_tail(&t[1], &m);

This way, we're describing the transfer to the SPI core, and explicitly
indicating that there are some dummy bytes.  The SPI driver can then
tell that these are dummy bytes, and if the SPI message consists of:

- transmit 2 to 5 bytes where the first byte is a recognised read command
- transmit 0 to 3 dummy bytes
- read some bytes

then it can make use of the SFI mode to accelerate the operation.

This would not be a hack to the SPI code: we're describing to the SPI
code what we want to achieve in terms of the activity on the bus, and
providing that level of description then allows the SPI driver to make
informed decisions on whether it can handle the transfer using some
non-standard feature.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
