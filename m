From: "Nathan Monson" <nmonson@gmail.com>
Subject: Re: [patch 2.6.27-rc7-omap1-git 1/2] twl4030-core: move to drivers/mfd
Date: Fri, 3 Oct 2008 13:12:19 -0700
Message-ID: <e5e6ade50810031312o4cd37f4fhc5f2204f31af8dbb@mail.gmail.com>
References: <200810011947.55057.david-b@pacbell.net>
	 <20081002090757.GJ7412@gandalf.research.nokia.com>
	 <200810020752.35738.david-b@pacbell.net>
	 <20081002145349.GB14419@gandalf.research.nokia.com>
	 <20081003133704.GB6251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:44055 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbYJCUMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 16:12:20 -0400
Received: by yx-out-2324.google.com with SMTP id 8so295529yxm.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Oct 2008 13:12:19 -0700 (PDT)
In-Reply-To: <20081003133704.GB6251@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, ext David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

On Fri, Oct 3, 2008 at 6:37 AM, Tony Lindgren <tony@atomide.com> wrote:
> Pushed.

After pulling this one (twl4030-core: move to drivers/mfd), TWL4030
doesn't initialize the same way on my BeagleBoard.

Before (708244b3f3d5dad958059729c384a068ecd46161):
  twl4030_usb twl4030_usb: Initialized TWL4030 USB module
  input: triton2-pwrbutton as /class/input/input0
  triton2 power button driver initialized

After (56d33dd99b13c4f18df838e766c595299f7e1e0f):
  can't get IRQ 378, err -22
  twl4030_usb: probe of twl4030_usb failed with error -22
  Unable to allocate IRQ for power button

This is a stock linux-omap with no patches.

- Nathan
