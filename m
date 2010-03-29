From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV2] OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under
 DVFS+SR operation
Date: Mon, 29 Mar 2010 10:39:37 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703047FFD56@dbde02.ent.ti.com>
References: <1268313365-18495-1-git-send-email-vishwanath.bs@ti.com>
 <87pr32q12r.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52712 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621Ab0C2FJq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Mar 2010 01:09:46 -0400
In-Reply-To: <87pr32q12r.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, March 17, 2010 11:32 PM
> To: Sripathy, Vishwanath
> Cc: linux-omap@vger.kernel.org; Gulati, Shweta
> Subject: Re: [PATCHV2] OMAP3 PM: Fix for DSP Crash at OPP 1 and 2 under
> DVFS+SR operation
> 
> Vishwanath BS <vishwanath.bs@ti.com> writes:
> 
> > From: Shweta Gulati <shweta.gulati@ti.com>
> >
> > DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM UCs
> > running DSP codec was earlier restricted as DSP crashed.
> > The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
> > The solution is to make sure DPLL1/DPLL2 bypass clock is always less than
> > maximum supported frequency for the specific OPP
> >
> > Tested on 3630 ZOOM3.
> >
> > changes in V2 : Rebased to new OPP implementation
> >
> > Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > ---
> 
> This should be broken up into two parts.  One that applies to mainline
> (or l-o master), and another that fixes SRF that can be applied to PM
> branch.  The first will be targted for mainline, but the SRF change
> will be only in PM branch, as SRF is deprecated and will be replaced.
ack
> 
> That being said, the approach in this patch is not the right approach.
> It appears to completely ignore the min/max dividers that are already
> managed by the clock/DPLL code.
> 
> Please add this support by modifying/extending the existing clock/DPLL
> management code instead of manually writing registers.
> 
Min/max dividers in clock framework are for dpll lock frequency, where as in the patch, we configure dpll bypass frequency. Shall I add a new API in dpll.c to configure bypass clock dividers?

Vishwa
> Kevin
