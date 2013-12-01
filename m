From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH v2 1/3] power_supply: Add power_supply notifier
Date: Sun, 1 Dec 2013 14:23:30 -0800
Message-ID: <20131201222330.GB6271@lizard>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:63741 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab3LAW2h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Dec 2013 17:28:37 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so16788915pdj.37
        for <linux-omap@vger.kernel.org>; Sun, 01 Dec 2013 14:28:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1384856285-19593-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz, Jenny TC <jenny.tc@intel.com>

On Tue, Nov 19, 2013 at 11:18:03AM +0100, Pali Roh=C3=A1r wrote:
> This patch adds a notifier chain to the power_supply.
> This notifier helps drivers in other subsystem to listen to
> changes in power supply subsystem. This would help to take some
> actions in those drivers on changing the power supply properties.
> One such scenario is to increase/decrease system performance based
> on the battery capacity/voltage. Another scenario is to adjust the
> h/w peak current detection voltage/current thresholds based on batter=
y
> voltage/capacity. The notifier helps drivers to listen to changes
> in power_suppy susbystem without polling the power_supply properties
>=20
> Signed-off-by: Jenny TC <jenny.tc@intel.com>
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
=2E..
> +enum power_supply_notifier_events {
> +	PSY_EVENT_NONE,

This one is not needed.

> +	PSY_EVENT_PROP_CHANGED,
> +	PSY_EVENT_BATTERY,
> +	PSY_EVENT_CABLE,
> +};

The only event that is currently used in your patch series is
EVENT_PROP_CHANGED... So, I applied the patch with the following change=
s:

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.=
h
index c6f52c0..0c2a260 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/notifier.h>
 #include <linux/err.h>
 #include <linux/power_supply.h>
 #include <linux/thermal.h>
@@ -159,10 +159,7 @@ enum power_supply_type {
 };
=20
 enum power_supply_notifier_events {
-	PSY_EVENT_NONE,
 	PSY_EVENT_PROP_CHANGED,
-	PSY_EVENT_BATTERY,
-	PSY_EVENT_CABLE,
 };
=20
 union power_supply_propval {
@@ -242,7 +239,7 @@ struct power_supply_info {
 	int use_for_apm;
 };
=20
-extern struct atomic_notifier_head    power_supply_notifier;
+extern struct atomic_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
 extern struct power_supply *power_supply_get_by_name(const char *name)=
;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
