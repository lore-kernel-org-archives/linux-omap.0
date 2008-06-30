From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Question] MUSB: why not clear DMA interrupt in musbhsdma.c?
Date: Mon, 30 Jun 2008 19:53:52 +0800
Message-ID: <386072610806300453u3e0a1699kcf7084b0a947fba4@mail.gmail.com>
References: <386072610806022015t654e46g92d184d949ad60ad@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022B9C81C1@dbde02.ent.ti.com>
	 <386072610806022132m2d515537wadd23c102aec2bf0@mail.gmail.com>
	 <200806292123.57383.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200806292123.57383.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 30, 2008 at 12:23 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Monday 02 June 2008, Bryan Wu wrote:
>> > The DMA interrupt register is cleared on a read. I don't think you need
>> > to explicitly clear it.
>>
>> Maybe there some difference between Blackfin and OMAP implementation.
>> From the Datatsheet of BF54x, it said that:
>> ---
>> ... When the status has been
>> read by the processor core, the corresponding bit should have a 1 written
>> to it by the software in order to clear the status.
>> ---
>>
>> And without the clearing operation, the DMA irq handler will be called endless.
>
> Is there any problem having the IRQ and/or DMA glue
> for the Blackfin implementation handle this difference?
>
> Things were set up so that platform-specific IRQ and DMA
> modules could be plugged in ... perhaps not as easily as
> one might like (there's still a mess there), but it should
> be within the realm of possibility to make that behave.
>
> Having a comment in the code to highlight that particular
> difference will be the easy part.  Is that due to different
> revisions of the IP?  I'm told that Mentor went through a
> few iterations, going so far as to completely yank the DMA
> support from some versions.  :(
>

Actually, I don't have any detail information about the IP from mentor
of Blackfin.
I just found the instruction from the Blackfin manual. We need to
clear DMA IRQ flag
manually on Blackfin, although it is not true on Davinci.

>
>> > > But when I tried to write large file to the U-DISK
>> > > (such as 10Mbyte or 100Mbyte), speed is very slow and mush
>> > > slower than PIO mode, IMO.
>
> I've certainly seen that "little" problem.  I couldn't tell
> if the root cause was from Mentor's DMA support or from the
> kind of USB-antagonistic DMA engine on DaVinci, but when the
> DMA logic has to generate an IRQ for each packet (to get sane
> semantics), it's hopeless getting good throughput unless it's
> dirt cheap to set up and complete DMA transfers.  (It isn't.)
>
> As has been seen elsewhere:  when the cost of DMA integration
> exceeds the cost to stuff the FIFO by hand, DMA is not a win.
> That's an issue with the drivers/dma framework sometimes too,
> though in that case the issue is purely software.
>

I did lots of test to compare the DMA and PIO such as a) dd large file
to a USB flash disk, b) use bonnie++ to do performance test.
The result is that no throughput improvement on DMA and CPU
consumption is the same as PIO.

We hope to see the CPU usage of DMA mode is less than PIO mode, but
didn't got the expectation.

-Bryan Wu
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
