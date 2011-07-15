From: Jan Weitzel <J.Weitzel@phytec.de>
Subject: Re: [PATCH] ARM: OMAP4: PCM049: remove vusim regulator
Date: Fri, 15 Jul 2011 11:47:54 +0200
Message-ID: <1310723274.26087.38.camel@lws-weitzel>
References: <1310554738.18446.12.camel@lws-weitzel>
	 <1310554762-10743-1-git-send-email-j.weitzel@phytec.de>
	 <4E1D8BCD.5060901@ru.mvista.com> <1310561772.18446.14.camel@lws-weitzel>
	 <20110714073445.GL5783@atomide.com> <1310632792.4008.3.camel@lws-weitzel>
	 <20110715075024.GO5783@atomide.com>
Reply-To: J.Weitzel@phytec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.x-arc.co.uk ([217.6.246.34]:54432 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965262Ab1GOJsB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 05:48:01 -0400
In-Reply-To: <20110715075024.GO5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sshtylyov@mvista.com>

Am Freitag, den 15.07.2011, 00:50 -0700 schrieb Tony Lindgren:
> Well we can add it even before device tree support if it makes
> sense from code coalescing point of view. In this case it would
> mean creating board-panda-common.c or similar so the code can
> be shared amongst the panda variants.
> 
> It seems that some GPIO pins are different and there are some
> difference in devices connected, but big parts of the code can be
> shared.
> 
> Adding the pending boards without combining code would be adding code
> that will be going away for most part with the device tree support.
> 
> And most likely the beagle and panda based boards will be the first
> ones to work with device tree. So anything we can do to have common
> board init code will also help with this effort.
> 
> Regards,
> 
> Tony
pcm049 and panda board have some more different devices.
I am working on patches to add NAND support and using tlv320aic3x audio
codec which need regulators in platformcode. I need a hack to controll
usb otg by gpio (controlling a external power circuit). The patches are
not mainline ready by now. 
If using machine_is_xxxx() in board-omap4panda.c then also is good way,
I could provide our board as patches on top of board-omap4panda.c.
When will pandaboard use device tree to boot?

Kind Regards,
Jan


