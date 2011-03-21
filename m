From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [RFC 2/3] OMAP3: hwmod: Add support to associate an initiator
 with a hwmod
Date: Mon, 21 Mar 2011 18:38:15 +0530
Message-ID: <03a02588593f269848ca723790e0319a@mail.gmail.com>
References: <1300705823-12784-1-git-send-email-rnayak@ti.com>
 <1300705823-12784-2-git-send-email-rnayak@ti.com> <1300705823-12784-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:43091 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753334Ab1CUNIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 09:08:35 -0400
Received: by mail-yx0-f169.google.com with SMTP id 33so2580106yxt.28
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 06:08:34 -0700 (PDT)
In-Reply-To: <1300705823-12784-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>

Rajendra,

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Rajendra Nayak
>Sent: Monday, March 21, 2011 4:40 PM
>To: linux-omap@vger.kernel.org
>Cc: paul@pwsan.com; b-cousson@ti.com; Rajendra Nayak
>Subject: [RFC 2/3] OMAP3: hwmod: Add support to associate an
>initiator with a hwmod
>
>Add hwmod api's to add and delete an initiator
>association with an hwmod.
>
>Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>---
> arch/arm/mach-omap2/omap_hwmod.c             |   33
>++++++++++++++++++++++++++
> arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
> 2 files changed, 35 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>b/arch/arm/mach-omap2/omap_hwmod.c
>index e034294..d4826be 100644
>--- a/arch/arm/mach-omap2/omap_hwmod.c
>+++ b/arch/arm/mach-omap2/omap_hwmod.c
>@@ -2369,3 +2369,36 @@ int omap_hwmod_no_setup_reset(struct
>omap_hwmod *oh)
>
> 	return 0;
> }
>+
>+int omap_hwmod_add_initiator_user(struct omap_hwmod *oh, u8 init_id)
>+{
>+	if (oh->_state != _HWMOD_STATE_ENABLED)
>+		return -EINVAL;
>+
>+	if (cpu_is_omap34xx()) {
>+		return omap2_prm_module_enable_initiator_wakeup(
>+						
>oh->prcm.omap2.module_offs,
>+						
>oh->prcm.omap2.idlest_reg_id,
>+						
>oh->prcm.omap2.idlest_idle_bit,
>+						init_id);
>+	}
>+
>+	return -EINVAL;

Why are you returning error when it not a omap34xx?
Is it not that this API will be called for only omap34xx?

>+}
>+
>+int omap_hwmod_del_initiator_user(struct omap_hwmod *oh, u8 init_id)
>+{
>+	if (oh->_state == _HWMOD_STATE_ENABLED)
>+		return -EINVAL;
>+
>+	if (cpu_is_omap34xx()) {
>+		return omap2_prm_module_disable_initiator_wakeup(
>+						
>oh->prcm.omap2.module_offs,
>+						
>oh->prcm.omap2.idlest_reg_id,
>+						
>oh->prcm.omap2.idlest_idle_bit,
>+						init_id);
>+	}
>+
>+	return -EINVAL;

Ditto...

>+
>+}
>diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>index 4bd7354..fe47448 100644
>--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>@@ -590,6 +590,8 @@ int omap_hwmod_add_initiator_dep(struct
>omap_hwmod *oh,
> 				 struct omap_hwmod *init_oh);
> int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
> 				 struct omap_hwmod *init_oh);
>+int omap_hwmod_add_initiator_user(struct omap_hwmod *oh, u8 init_id);
>+int omap_hwmod_del_initiator_user(struct omap_hwmod *oh, u8 init_id);
>
> int omap_hwmod_set_clockact_both(struct omap_hwmod *oh);
> int omap_hwmod_set_clockact_main(struct omap_hwmod *oh);
>--


Regards,
Hema

>1.7.0.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
