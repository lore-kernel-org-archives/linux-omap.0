From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Wed, 14 May 2014 19:44:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405141939030.21921@utopia.booyaka.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1405080432570.23579@utopia.booyaka.com> <536B1A9C.7050006@ti.com> <alpine.DEB.2.02.1405081558570.23579@utopia.booyaka.com> <536C777C.8000600@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47396 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbaENTo1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 15:44:27 -0400
In-Reply-To: <536C777C.8000600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 9 May 2014, Tomi Valkeinen wrote:

> On 08/05/14 19:01, Paul Walmsley wrote:
> > Hi Archit,
> > 
> > On Thu, 8 May 2014, Archit Taneja wrote:
> > 
> >> Hi Paul,
> >>
> >> On Thursday 08 May 2014 10:07 AM, Paul Walmsley wrote:
> >>> Hi,
> >>>
> >>> On Wed, 12 Mar 2014, Tomi Valkeinen wrote:
> >>>
> >>>> This patch adds hwmod data for omap5 display subsystem. I have tested this
> >>>> on
> >>>> omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet,
> >>>> as the
> >>>> mainline is missing omap5 HDMI driver.
> >>>>
> >>>> I do see this when booting:
> >>>>
> >>>>    omap_hwmod: dss_dispc: cannot be enabled for reset (3)
> >>>>    omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
> >>>>    omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
> >>>>    omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
> >>>>    omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
> >>>>
> >>>> But at least DSI works just fine.
> >>>
> >>> Am looking at this for v3.16.  But I think someone needs to take a look at
> >>> those warnings and figure out why they are happening.
> >>
> >> We associate DSS clock domain's MODULEMODE bits only with the dss_core hwmod.
> >> The rest of the dss hwmods don't touch MODULEMODE.
> >>
> >> Therefore, these hwmods cannot be enabled independently, and reset.
> >>
> >> We don't face this issue in the omapdss driver since the platform devices
> >> corresponding to these hwmods have their parent as the platform device
> >> corresponding to 'dss_core'. This parent child-relation ensures that
> >> 'dss_core' is enabled when the a child calls a pm_runtime_get function.
> >>
> >> The problem is that we have multiple hwmods which use the same MODULEMODE bit.
> >> There is no use-counting done when it comes to enabling/disabling modulemode.
> >> If there was such a thing, we could have provided MODULEMODE flags even for
> >> the children hwmods.
> > 
> > Thanks for the summary.  This is indeed a long-overdue item for the hwmod 
> > core code.  Can you please patch the hwmod core code to add this?  I'd 
> > suggest making the use-counting functionality conditional on a hwmod flag 
> > that you can set for all of the DSS hwmods.  (Ideally, the core code would 
> > detect that several modules share the same MODULEMODE bits, and 
> > automatically set it for those cases, but that seems a bit too complex for 
> > a first cut.)
> 
> Can we still go forward with this patch as it is? As far as I
> understand, the warnings are harmless (more or less), but without this
> patch we won't have OMAP5 display support.

Generally speaking, we try to avoid queuing patches that add warnings, for 
a few different reasons:

1. end users don't know whether they are serious or not, and could waste 
time trying to determine whether those warnings are causing other, 
unrelated problems for them

2. once patches with warnings are merged, even if folks promise to fix 
them, usually people tend to deprioritize 'closing the loop' on the fixes 
- so they often never make it back upstream

3. some maintainers search for warnings in their test logs and push back 
on patches that generate them


All that said, you and Archit are pretty good in my experience about 
following up on issues.  And Archit has mentioned that he will be 
patching the hwmod core code to fix the underlying issue:

http://www.spinics.net/lists/arm-kernel/msg329614.html

So, at least speaking for myself, I'm willing to queue this patch for 
3.16, with the understanding that you all will be patching the hwmod core 
code to fix the root cause.


- Paul
