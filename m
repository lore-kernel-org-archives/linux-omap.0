From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 07/12] System Control Module context save/restore
Date: Thu, 11 Sep 2008 12:22:27 +0530
Message-ID: <016301c913da$f568bc90$LocalHost@wipultra1382>
References: <48C8ADC7.9020109@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58419 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbYIKGwk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 02:52:40 -0400
In-Reply-To: <48C8ADC7.9020109@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org


> >>>  #define OMAP3430_PRM_RSTST \
> >>>  		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, RM_RSTST)
> >>> +static struct omap3_control_module_regs control_ctx;
> >>> +
> >> I'm not sure what this patch was generated against, but it doesn't
> >> apply against linux-omap.  The PRM_RSTST definition above is not in
> >> linux-omap code.
> >>
> >> Kevin
> > 
> > There is no reference to PRM_RSTST in this patch. It uses 
> RM_RSTST which
> > can be found in arch/arm/mach-omap2/prm.h.
> 
> You can see in the above quoted text that your 7/12 patch 
> adds some code
> immediately after a line which defines OMAP3430_PRM_RSTST.   
> Since this 
> existing code is not in linux-omap, and I couldn't find it in 
> previous 
> patches, it's not clear what this patch was generated against.
> 
> Kevin

Yes, those lines are not present in linux-omap and are added by patch [PATCH 03/06] scratchpad populate
posted by me on 08/26/2008. It is part of the patch set [PATCH 00/06] OMAP3 CPUidle patches - supports C0-C5
posted the same day.

To summarise I have posted 2 patch sets as discussed earlier for CPUIdle
1) [PATCH 00/06] OMAP3 CPUidle patches - supports C0-C5 - posted on 08/26/2008
2) [PATCH 00/12] OMAP3 CPUidle context save/restore patches -      supports C6 - posted on 09/01/2008

Apart from these the following patch set posted by Jouni is needed for these patches to apply
1) [PATCH 0/4] Refreshed PM workaround patches 2. - posted on 07/15/2008
NOTE: Patch 1/4 from this set is already pushed in l-o mainline.

So if you apply the patches in the following order on top of commit 81c893795c2e1fbe0bf5f638e.. I am 
hoping they should work.
1) [PATCH 0/4] Refreshed PM workaround patches 2.
2) [PATCH 00/06] OMAP3 CPUidle patches - supports C0-C5
3) [PATCH 00/12] OMAP3 CPUidle context save/restore patches

