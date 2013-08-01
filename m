From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv7 1/2] drivers: spi: Add qspi flash controller
Date: Thu, 1 Aug 2013 09:45:17 +0530
Message-ID: <51F9E0D5.4050707@ti.com>
References: <1375249673-2585-1-git-send-email-sourav.poddar@ti.com>	<1375249673-2585-2-git-send-email-sourav.poddar@ti.com>
	<CA+7tXijn2V7LMCKuOKxcda6r6a=JFBeSFNqGqNtYZuTF=irF1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA+7tXijn2V7LMCKuOKxcda6r6a=JFBeSFNqGqNtYZuTF=irF1g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rnayak-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 01 August 2013 12:09 AM, Trent Piepho wrote:
> On Tue, Jul 30, 2013 at 10:47 PM, Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>  wrote:
>> Test details:
>> -------------
>> Tested this on dra7 board.
>> Test1: Ran mtd_stesstest for 40000 iterations.
>>     - All iterations went through without failure.
>> Test2: Use mtd utilities:
>>    - flash_erase to erase the flash device
>>    - nanddump to read data back.
>>    - nandwrite to write to the data flash.
>>   diff between the write and read data shows zero.
> You've obviously never tested word lengths other than 8, because...
>
>> +static inline void ti_qspi_read_data(struct ti_qspi *qspi,
>> +               unsigned long reg, int wlen, u8 **rxbuf)
>> +{
>> +       switch (wlen) {
>> +       case 8:
>> +               **rxbuf = readb(qspi->base + reg);
>> +               dev_vdbg(qspi->dev, "rx done, read %02x\n", *(*rxbuf));
>> +               *rxbuf += 1;
>> +               break;
>> +       case 16:
>> +               **rxbuf = readw(qspi->base + reg);
> *rxbuf is a u8*.  This means when you assign to **rxbuf the type of
> the lvalue is u8.  8 bits.  It does not matter what type the rvalue
> is, u8, u16, or u32, the result will always be truncated to 8 bits.
>
May be, I can typecast the lvalue correspondingly before assigning.
> IMHO, I toss the design of ti_qspi_read/write_data().  They look like
> a function to read a generic register, yet it only makes sense with
> QSPI_SPI_DATA_REG.  Passing the pointer by address so it can be
> incremented is ugly.  And doesn't work at all, since the type of the
> pointer isn't going to be the same for different word lengths.  The
> case statement inside the inner loop is inefficient.  Each case is
> largely duplicated code.
Yes, type of word length is not going to be the same. Hence, I kept it
as u8, then increment the pointer accordingly according to the case to
which it belongs.
Due to the different kind of variants used(read(b/w/l), each case has to
be replicated.

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
