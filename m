From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: OMAP3515 vs 3525 inversion
Date: Tue, 17 Nov 2009 19:09:53 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE563E29@dbde02.ent.ti.com>
References: <48239d390911160228y61e3c3dbk11b7a819f266b4bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37363 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbZKQNjw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 08:39:52 -0500
In-Reply-To: <48239d390911160228y61e3c3dbk11b7a819f266b4bd@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Sergey Lapin
> Sent: Monday, November 16, 2009 3:59 PM
> To: linux-omap@vger.kernel.org
> Subject: OMAP3515 vs 3525 inversion
> 
> Hi, all!
> I think I found a bug in processor detection code.
> as I see,
> > > +	/* OMAP3430 and OMAP3530 are assumed to be same.
> > > +	 *
> > > +	 * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
> > > +	 * on available features. Upon detection, update the CPU id
> > > +	 * and CPU class bits.
> > > +	 */
> > > +	if (omap3_has_iva() && omap3_has_sgx()) {
> > > +		strcpy(cpu_name, "3430/3530");
> > > +	}
> > > +	else if (omap3_has_sgx()) {
> > > +		omap_revision = OMAP3525_REV (rev);
> > > +		strcpy(cpu_name, "3525");
> > > +	}
> > > +	else if (omap3_has_iva()) {
> > > +		omap_revision = OMAP3515_REV (rev);
> > > +		strcpy(cpu_name, "3515");
> > > +	}
> > > +	else {
> > > +		omap_revision = OMAP3503_REV (rev);
> > > +		strcpy(cpu_name, "3503");
> > > +	}
> 
> But, actually, 3515 has no DSP, but has PowerVR,
> and 3525 has no PowerVR but has DSP. In-tree code inverses 
> this detection.

This error seems to have crept in while reworking the patch. I
believe the patch can be minimized to:

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 1c15112..e5a0747 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -270,11 +270,11 @@ void __init omap3_cpuinfo(void)
                strcpy(cpu_name, "3630");
        else if (omap3_has_iva() && omap3_has_sgx())
                strcpy(cpu_name, "3430/3530");
-       else if (omap3_has_sgx()) {
+       else if (omap3_has_iva()) {
                omap_revision = OMAP3525_REV(rev);
                strcpy(cpu_name, "3525");
        }
-       else if (omap3_has_iva()) {
+       else if (omap3_has_sgx()) {
                omap_revision = OMAP3515_REV(rev);
                strcpy(cpu_name, "3515");
        }

I can submit this on your behalf.

Best regards,
Sanjeev

> 
> Please consider applying attached patch. (sorry, no git-send-email
> available here).
> 