From: David Brownell <david-b@pacbell.net>
Subject: Re: [Question] MUSB: why not clear DMA interrupt in musbhsdma.c?
Date: Sun, 29 Jun 2008 21:23:57 -0700
Message-ID: <200806292123.57383.david-b@pacbell.net>
References: <386072610806022015t654e46g92d184d949ad60ad@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022B9C81C1@dbde02.ent.ti.com> <386072610806022132m2d515537wadd23c102aec2bf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:40251 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750884AbYF3EX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2008 00:23:59 -0400
In-Reply-To: <386072610806022132m2d515537wadd23c102aec2bf0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <me@felipebalbi.com>

On Monday 02 June 2008, Bryan Wu wrote:
> > The DMA interrupt register is cleared on a read. I don't think you need
> > to explicitly clear it.
> 
> Maybe there some difference between Blackfin and OMAP implementation.
> From the Datatsheet of BF54x, it said that:
> ---
> ... When the status has been
> read by the processor core, the corresponding bit should have a 1 written
> to it by the software in order to clear the status.
> ---
> 
> And without the clearing operation, the DMA irq handler will be called endless.

Is there any problem having the IRQ and/or DMA glue
for the Blackfin implementation handle this difference?

Things were set up so that platform-specific IRQ and DMA
modules could be plugged in ... perhaps not as easily as
one might like (there's still a mess there), but it should
be within the realm of possibility to make that behave.

Having a comment in the code to highlight that particular
difference will be the easy part.  Is that due to different
revisions of the IP?  I'm told that Mentor went through a
few iterations, going so far as to completely yank the DMA
support from some versions.  :(


> > > But when I tried to write large file to the U-DISK
> > > (such as 10Mbyte or 100Mbyte), speed is very slow and mush 
> > > slower than PIO mode, IMO.

I've certainly seen that "little" problem.  I couldn't tell
if the root cause was from Mentor's DMA support or from the
kind of USB-antagonistic DMA engine on DaVinci, but when the
DMA logic has to generate an IRQ for each packet (to get sane
semantics), it's hopeless getting good throughput unless it's
dirt cheap to set up and complete DMA transfers.  (It isn't.)

As has been seen elsewhere:  when the cost of DMA integration
exceeds the cost to stuff the FIFO by hand, DMA is not a win.
That's an issue with the drivers/dma framework sometimes too,
though in that case the issue is purely software.

- Dave

