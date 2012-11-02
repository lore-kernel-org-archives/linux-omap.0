From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/5] usb: musb: dsps: reduce musb instance to one
Date: Fri, 2 Nov 2012 22:02:35 +0530
Message-ID: <808fe9b3f94a29c704f9d3365d7bc63ec35e94a7.1351870620.git.afzal@ti.com>
References: <cover.1351870620.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1351870620.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Santhapuri Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Currently multiple phy's of the same type are not supported, hence
reduce musb instances to one. This helps in supporting at least one
instance of musb, rather than having none. Even without this, it was
observed that both instances were working (by luck), but this holds
good iff wrapper is part of Image. And it is not correct for both
controller's to be associated with same phy, here it was working
because phy is a nop one. And having wrapper as a module and
rmmod'ing would crash.

This can be reverted once multi phy support for same type is available
and driver is enhanced to make use of it.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 2396bcd..524c003 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -677,7 +677,7 @@ static const struct dsps_musb_wrapper ti81xx_driver_data __devinitconst = {
 	.rxep_bitmap		= (0xfffe << 16),
 	.musb_core_offset	= 0x400,
 	.poll_seconds		= 2,
-	.instances		= 2,
+	.instances		= 1,
 };
 
 static const struct platform_device_id musb_dsps_id_table[] __devinitconst = {
-- 
1.7.12

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
