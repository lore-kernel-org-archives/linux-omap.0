From: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/1] usb: musb: improve throughput in HOST mode
Date: Fri, 29 Mar 2013 19:15:20 +0200
Message-ID: <1364577321-1102-1-git-send-email-ruslan.bilovol@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi guys,

This is a resend (and v3) of my patch:
http://permalink.gmane.org/gmane.linux.usb.general/67238

At this moment it has been successfully tested and
used on top of 3.0 and 3.4 kernels on omap4 devices
so it would be great to have it in upstream too.

Regards,
Ruslan

v3: Implementation has been little bit changed
    to keep MUSB struct hc_driver as 'const' (as per
    Felipe's comments). Verified on top of 3.9-rc4. 


Ruslan Bilovol (1):
  usb: musb: implement (un)map_urb_for_dma hooks

 drivers/usb/musb/musb_host.c |  117 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
