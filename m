From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [RFT/PATCH] serial: omap: prevent resume if device is not suspended.
Date: Tue, 25 Sep 2012 17:59:52 +0530
Message-ID: <CAJe_Zhc5jCBcfvTcs=Xi_QXLU+t_Erck-3pxV5co1xAsjj8kkA@mail.gmail.com>
References: <1347972050-3509-1-git-send-email-sourav.poddar@ti.com>
	<20120918140213.GA27463@arwen.pp.htv.fi>
	<CANOLnONC1oDN3yu=ipao2A6MfuSkZfROVPewWLLEM5fNTKipxQ@mail.gmail.com>
	<20120919115933.GJ3772@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42789 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab2IYM3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 08:29:53 -0400
Received: by vcbfo13 with SMTP id fo13so7526322vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 05:29:52 -0700 (PDT)
In-Reply-To: <20120919115933.GJ3772@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Grazvydas Ignotas <notasas@gmail.com>, Sourav Poddar <sourav.poddar@ti.com>, gregkh@linuxfoundation.org, alan@linux.intel.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, paul@pwsan.com

On 19 September 2012 17:29, Felipe Balbi <balbi@ti.com> wrote:

> this is what I mean, actually. If we remove pm_runtime_get_sync() in
> exchange for pm_runtime_set_active() before pm_runtime_enable(), it
> works on PandaBoard, but breaks BeagleBoard.
>
Perhaps it suggests that OMAP4 (PandaBoard) serial port is already
activated but OMAP3 (BeagleBoard) isn't. So we need to reflect that
either by doing pm_runtime_set_active() only on OMAP4 or by bringing
up the OMAP3 too before the pm_runtime_set_active() call.
BTW I understand get_sync(), set_active() and enable() are for
different purposes, they can't be traded for one another.
