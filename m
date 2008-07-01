From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [Question] MUSB: why not clear DMA interrupt in musbhsdma.c?
Date: Tue, 1 Jul 2008 18:25:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022BF6C991@dbde02.ent.ti.com>
References: <386072610806022015t654e46g92d184d949ad60ad@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB022B9C81C1@dbde02.ent.ti.com>
	 <386072610806022132m2d515537wadd23c102aec2bf0@mail.gmail.com>
	 <200806292123.57383.david-b@pacbell.net>
 <386072610806300453u3e0a1699kcf7084b0a947fba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52719 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758525AbYGAM4h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 08:56:37 -0400
In-Reply-To: <386072610806300453u3e0a1699kcf7084b0a947fba4@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>, David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <me@felipebalbi.com>

<snip>

> Actually, I don't have any detail information about the IP from mentor of Blackfin.
> I just found the instruction from the Blackfin manual. We need to clear DMA IRQ flag
> manually on Blackfin, although it is not true on Davinci.
>
> >
> >> > > But when I tried to write large file to the U-DISK
> >> > > (such as 10Mbyte or 100Mbyte), speed is very slow and mush
> >> > > slower than PIO mode, IMO.
> >
> > I've certainly seen that "little" problem.  I couldn't tell
> > if the root cause was from Mentor's DMA support or from the
> > kind of USB-antagonistic DMA engine on DaVinci, but when the
> > DMA logic has to generate an IRQ for each packet (to get sane
> > semantics), it's hopeless getting good throughput unless it's
> > dirt cheap to set up and complete DMA transfers.  (It isn't.)
> >
> > As has been seen elsewhere:  when the cost of DMA integration
> > exceeds the cost to stuff the FIFO by hand, DMA is not a win.
> > That's an issue with the drivers/dma framework sometimes too,
> > though in that case the issue is purely software.
> >
>
> I did lots of test to compare the DMA and PIO such as a) dd large file
> to a USB flash disk, b) use bonnie++ to do performance test.
> The result is that no throughput improvement on DMA and CPU
> consumption is the same as PIO.
>
> We hope to see the CPU usage of DMA mode is less than PIO mode, but
> didn't got the expectation.

Approximately how much is the performance you see with PIO mode (given that you also see the same with DMA mode)?

Any chance you have dynamic tick suppression enabled (CONFIG_NO_HZ)?
If so, could you try with nohz=off in your bootargs?

- Anand
