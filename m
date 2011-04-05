From: "Fillinger, Michael" <m-fillinger@ti.com>
Subject: RE: [PATCH] arm: omap: introduce OMAP MCOP board file
Date: Tue, 5 Apr 2011 11:47:58 +0200
Message-ID: <E8606C3FD412994585953171ED63A9340218270ED4@dnce01.ent.ti.com>
References: <1301995970-23699-1-git-send-email-balbi@ti.com>
 <20110405093656.GS2176@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33985 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab1DEJsV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 05:48:21 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110405093656.GS2176@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>



On Tue, Apr 05, 2011 at 11:37 AM +0300, Felipe Balbi wrote:
> On Tue, Apr 05, 2011 at 12:32:50PM +0300, Felipe Balbi wrote:
> > From: Michael Fillinger <m-fillinger@ti.com>
> >
> > MCOP is an FPGA-based Silicon Validation platform
> > which is used to test particular IPs inside OMAP
> > before we have a real ASIC.
> >
> > Signed-off-by: Michael Fillinger <m-fillinger@ti.com>
> >
> > [ balbi@ti.com : few cleanups here an there and also
> >     removal of some unnecessary code. ]
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>
> I should have RFCed this one, but bear with me for a minute.
>
> This is just the bare minimum board-file for MCOP, there's still a bunch
> of changes needed to get it actually booting. The attached diff shows
> many of them.
>
> Now, we don't want to send that patch upstream for obvious reasons and
> we also don't want to add ifdefs to clock data files as that would break
> multi-omap. What do you guys suggest ? How should we handle detection of
> MCOP so that we choose correct HWMODs and clock data files for it ?
>
> I don't think Linus will like if we add yet another hwmod + clk data
> file just for MCOP, so we need to re-use what's in tree.
>
> --
> Balbi

What you need to know about the MCOP system, based on OMAP2420, is that there is no PRCM and no complex clock trees, or power management. There is just 1 main driver clock. As such the "clock tree" can be extremely simplified.

Michael


Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



