From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Thu, 12 May 2011 09:25:55 +0300
Message-ID: <20110512092555.17ebf795.jhnikula@gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>
	<4DCAD29A.5050408@gmail.com>
	<4DCB0042.8040202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64042 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1ELGZC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 02:25:02 -0400
Received: by ewy4 with SMTP id 4so328758ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 11 May 2011 23:25:00 -0700 (PDT)
In-Reply-To: <4DCB0042.8040202@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>

On Wed, 11 May 2011 14:31:46 -0700
Steve Calfee <stevecalfee@gmail.com> wrote:

> On 05/11/11 11:16, Steve Calfee wrote:
> New title, more appropriate to the topic.
> 
> I was replying to the fix posted by Sanjeev fixing
> a/sound/soc/omap/omap-mcbsp.c
> 
> I am pretty near the cutting edge kernel, trying to use the latest alsa
> changes. I cannot get bbxm to talk to an external codec via mcbsp1.
> 
> Has anyone been able to use mcbsp1 on a recent linux-next.
> 
This sounds like that those expansion connector pins are not muxed to
mcbsp1 but e.g. to gpio by the bootloader. Are you able to see clock
activity on CLKX if you enable CONFIG_OMAP_MUX=y and add following
lines to board_mux table in arch/arm/mach-omap2/board-omap3beagle.c?

Of course for this you need to use omap as a master and codec as a
slave. One example for this is sound/soc/omap/omap3pandora.c.

 static struct omap_board_mux board_mux[] __initdata = {
+	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },

-- 
Jarkko
