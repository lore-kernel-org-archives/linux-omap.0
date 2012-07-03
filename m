From: "Matcovschi, Oleg" <oleg.matcovschi@ti.com>
Subject: RE: [PATCH v3 2/5] usb: musb: twl: use mailbox API to send VBUS or
 ID events
Date: Tue, 3 Jul 2012 17:39:31 +0000
Message-ID: <E0D6B3D7803B1A49AC7CEA9958379F630375BD5A@DFLE36.ent.ti.com>
References: <1340367055-19835-1-git-send-email-kishon@ti.com>,<1340367055-19835-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340367055-19835-3-git-send-email-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

>From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] on behalf of ABRAHAM, KISHON VIJAY
>Sent: Friday, June 22, 2012 5:10 AM
>To: gregkh@linuxfoundation.org; ABRAHAM, KISHON VIJAY; linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org; Balbi, Felipe
>Subject: [PATCH v3 2/5] usb: musb: twl: use mailbox API to send VBUS or ID events

>The atomic notifier from twl4030/twl6030 to notifiy VBUS and ID events,
>is replaced by a direct call to omap musb blue.

>Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>---
> drivers/usb/musb/omap2430.c   |   94 +++++++++++++++++++++++++---------------
> drivers/usb/otg/twl4030-usb.c |   46 ++++++++++----------
> drivers/usb/otg/twl6030-usb.c |   47 +++++++++-----------
> include/linux/usb/musb-omap.h |   30 +++++++++++++
> 4 files changed, 133 insertions(+), 84 deletions(-)
> create mode 100644 include/linux/usb/musb-omap.h
.....
+enum omap_musb_vbus_id_status {
+       OMAP_MUSB_UNKNOWN = 0,
+       OMAP_MUSB_ID_GROUND,
+       OMAP_MUSB_ID_FLOAT,
+       OMAP_MUSB_VBUS_VALID,
+       OMAP_MUSB_VBUS_OFF,
+};
+

Why did you choose to introduce OMAP_MUSB specific VBUS, ID events?
IMHO, it makes more sense to introduce mailbox functionality only without extra translation layer.
Same mailbox glue layer could be used for other PHY drivers, not just twl.

thanks,
 Oleg
