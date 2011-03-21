From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [RFC 3/3] OMAP3: omap_device: Add support to associate a device
 with an initiator
Date: Mon, 21 Mar 2011 18:42:06 +0530
Message-ID: <87b33eb07d8878f33aabba63d6730548@mail.gmail.com>
References: <1300705823-12784-1-git-send-email-rnayak@ti.com>
 <1300705823-12784-2-git-send-email-rnayak@ti.com> <1300705823-12784-3-git-send-email-rnayak@ti.com>
 <1300705823-12784-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50364 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752550Ab1CUNML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 09:12:11 -0400
Received: by mail-gx0-f171.google.com with SMTP id 22so2481191gxk.30
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 06:12:10 -0700 (PDT)
In-Reply-To: <1300705823-12784-4-git-send-email-rnayak@ti.com>
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
>Subject: [RFC 3/3] OMAP3: omap_device: Add support to
>associate a device with an initiator
>
>These api's are meant to to used by drivers to
>associate/disassociate a device from a given initiator.
>
>Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>---
> arch/arm/plat-omap/omap_device.c |   54
>++++++++++++++++++++++++++++++++++++++
> 1 files changed, 54 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/plat-omap/omap_device.c
>b/arch/arm/plat-omap/omap_device.c
>index 9bbda9a..0cd05d2 100644
>--- a/arch/arm/plat-omap/omap_device.c
>+++ b/arch/arm/plat-omap/omap_device.c
>@@ -662,6 +662,60 @@ int omap_device_shutdown(struct
>platform_device *pdev)
> 	return ret;
> }
>
>+static int omap_device_add_initiator_user(struct
>platform_device *pdev,
>+					  u8 init_id)
>+{
>+	int i;
>+	struct omap_device *od;
>+
>+	od = _find_by_pdev(pdev);
>+
>+	if (od->_state != OMAP_DEVICE_STATE_ENABLED)
>+		return -EINVAL;
>+
>+	for (i = 0; i < od->hwmods_cnt; i++)
>+		omap_hwmod_add_initiator_user(od->hwmods[i], init_id);

Not checking for return value.

>+
>+	return 0;
>+}
>+
>+inline int omap_device_add_mpu_user(struct platform_device *pdev)
>+{
>+	return omap_device_add_initiator_user(pdev, OMAP_INIT_MPU);
>+}
>+
>+inline int omap_device_add_iva_user(struct platform_device *pdev)
>+{
>+	return omap_device_add_initiator_user(pdev, OMAP_INIT_IVA);

Ditto..

>+}
>+
>+static int omap_device_del_initiator_user(struct
>platform_device *pdev,
>+					  u8 init_id)
>+{
>+	int i;
>+	struct omap_device *od;
>+
>+	od = _find_by_pdev(pdev);
>+
>+	if (od->_state == OMAP_DEVICE_STATE_ENABLED)
>+		return -EINVAL;
>+
>+	for (i = 0; i < od->hwmods_cnt; i++)
>+		omap_hwmod_del_initiator_user(od->hwmods[i], init_id);
>+
>+	return 0;
>+}
>+
>+inline int omap_device_del_mpu_user(struct platform_device *pdev)
>+{
>+	return omap_device_del_initiator_user(pdev, OMAP_INIT_MPU);
>+}
>+
>+inline int omap_device_del_iva_user(struct platform_device *pdev)
>+{
>+	return omap_device_del_initiator_user(pdev, OMAP_INIT_IVA);
>+}
>+
> /**
>  * omap_device_align_pm_lat - activate/deactivate device to
>match wakeup lat lim
>  * @od: struct omap_device *
>--
>1.7.0.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
