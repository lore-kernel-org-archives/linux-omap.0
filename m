From: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/1] omap usb host platform_data cleanup
Date: Thu, 14 Mar 2013 12:41:12 +0200
Message-ID: <1363257673-24136-1-git-send-email-ruslan.bilovol@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello guys,

This is v2 of my patch https://patchwork.kernel.org/patch/1232871/
rebased on v3.9-rc2. Removes deprecated flags and structures
and saves few bytes of memory.

Regards,
Ruslan

Ruslan Bilovol (1):
  omap: usb: host: remove deprecated flags and structures

 include/linux/platform_data/usb-omap.h |   20 --------------------
 1 file changed, 20 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
