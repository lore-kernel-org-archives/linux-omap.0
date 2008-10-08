From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: omapfb: help from userspace
Date: Wed, 8 Oct 2008 11:36:48 -0700
Message-ID: <e5e6ade50810081136n2067600csf3c77195da0ef110@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:38840 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbYJHSgt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 14:36:49 -0400
Received: by qw-out-2122.google.com with SMTP id 3so976549qwe.37
        for <linux-omap@vger.kernel.org>; Wed, 08 Oct 2008 11:36:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

"Felipe Contreras" <felipe.contreras@gmail.com> writes:
> Now I'm getting a bunch of these errors apparently when shuffling
> memory too fast:
> irq -33, desc: c0335cf8, depth: 0, count: 0, unhandled: 0
> ->handle_irq():  c00744e0, handle_bad_irq+0x0/0x22c
> ->chip(): 00000000, 0x0
> ->action(): 00000000

I've had this problem regularly while using linux-omap .26 and .27 on
the BeagleBoard.  I turned off framebuffer support after seeing your
message and it seemed to help.  (Hard to tell since it is random.)

Now I'm using DSP Bridge and the problem is back.  In fact, the
problem occurs within a minute or two of running code on the DSP.

On the BeagleBoard list, Pratheesh Gangadhar said that mapping I/O
regions as Strongly Ordered suppresses this problem:
http://groups.google.com/group/beagleboard/browse_thread/thread/23e1c95b4bfb09b5/70d12dca569ca503?show_docid=70d12dca569ca503

> This proves that these spurious interrupts are side effect of using posted
> writes to acknowledge/clear the interrupt status in the peripheral.

Is there anyone who knows their way around mmu.c that could create a
quick and dirty patch to use Strongly Ordered I/O on OMAP3?  I'd like
to test it with the DSP.

- Nathan
