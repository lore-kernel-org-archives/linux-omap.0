From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 00/10] Add memory mapped support for ti qspi, m25p80
 serial flash.
Date: Wed, 11 Dec 2013 10:07:11 +0530
Message-ID: <52A7EBF7.4040601@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com> <201312101349.13564.marex@denx.de> <20131210161143.GK29268@sirena.org.uk> <201312101922.10618.marex@denx.de> <20131210182904.GG11468@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131210182904.GG11468-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,
On Tuesday 10 December 2013 11:59 PM, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 07:22:10PM +0100, Marek Vasut wrote:
>> On Tuesday, December 10, 2013 at 05:11:43 PM, Mark Brown wrote:
>>> There is some stuff that pushes up into the controller in that while the
>>> device is in memory mapped mode as far as I can tell it's not safe to do
>>> other accesses so if someone's put more than one device on the SPI bus
>>> we need to handle interactions there.
>> OK, so it's either-or . That seems OK, you might want to have two drivers for
>> this ip block, one to handle it as a SPI block and one to handle it as a SPI-NOR
>> block. ... that is of course, if these two modes can't work together.
> Or the client disables the memory map when it's not actively being used
> and the stops other transfers starting while the mapping is in place.
> I'd expect we'll have to cope with shared use at some point, hardware
> engineers will probably build such systems.
So, what I am doing here in my code is that whenever I desired to use a
mmap operations I do a

a. flash_lock()
b. wait till the previous erase/write is finished
c. 'get_buf' which in turn does
       - get_sync
       - enable memory mapped

d. memcpy
e. 'put_buf' which in turn does
            - disable memory mapped
            - put_sync


f. flash_unlock

Do you see any point missing here?

On your comment about disabling transfers while doing a mmap..
Are you suggesting on having a check in qspi transfer api something like 
this..

transfer_one_message {
  if (mmap)
      return -EINPROGRESS;
}

Where mmap can be set/unset in get_buf/put_buf respectively.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
