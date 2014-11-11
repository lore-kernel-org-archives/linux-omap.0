From: Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [RFCv2 1/8] [media] si4713: switch to devm regulator API
Date: Tue, 11 Nov 2014 09:07:10 -0200
Message-ID: <20141111090710.7a60a846@recife.lan>
References: <1413904027-16767-1-git-send-email-sre@kernel.org>
	<1413904027-16767-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413904027-16767-2-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Em Tue, 21 Oct 2014 17:07:00 +0200
Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> escreveu:

> This switches back to the normal regulator API (but use
> managed variant) in preparation for device tree support.

This patch broke compilation. Please be sure that none of the patches in
the series would break it, as otherwise git bisect would be broken.

Thanks,
Mauro

drivers/media/radio/si4713/si4713.c: In function 'si4713_powerup':
drivers/media/radio/si4713/si4713.c:369:10: error: 'struct si4713_device' has no member named 'supplies'
 
          ^
drivers/media/radio/si4713/si4713.c:370:35: error: 'struct si4713_device' has no member named 'supplies'
  if (sdev->vdd) {
                                   ^
drivers/media/radio/si4713/si4713.c:370:51: error: 'struct si4713_device' has no member named 'supply_data'
  if (sdev->vdd) {
                                                   ^
drivers/media/radio/si4713/si4713.c:402:10: error: 'struct si4713_device' has no member named 'supplies'
   v4l2_dbg(1, debug, &sdev->sd, "Device in power up mode\n");
          ^
drivers/media/radio/si4713/si4713.c:403:36: error: 'struct si4713_device' has no member named 'supplies'
   sdev->power_state = POWER_ON;
                                    ^
drivers/media/radio/si4713/si4713.c:403:52: error: 'struct si4713_device' has no member named 'supply_data'
   sdev->power_state = POWER_ON;
                                                    ^
drivers/media/radio/si4713/si4713.c: In function 'si4713_powerdown':
drivers/media/radio/si4713/si4713.c:435:11: error: 'struct si4713_device' has no member named 'supplies'
  int err;
           ^
drivers/media/radio/si4713/si4713.c:436:37: error: 'struct si4713_device' has no member named 'supplies'
  u8 resp[SI4713_PWDN_NRESP];
                                     ^
drivers/media/radio/si4713/si4713.c:437:16: error: 'struct si4713_device' has no member named 'supply_data'
 
                ^
drivers/media/radio/si4713/si4713.c: In function 'si4713_probe':
drivers/media/radio/si4713/si4713.c:1444:7: error: 'struct si4713_device' has no member named 'supplies'
 /* si4713_probe - probe for the device */
       ^
drivers/media/radio/si4713/si4713.c:1447:22: error: 'struct si4713_device' has no member named 'supplies'
 {
                      ^
drivers/media/radio/si4713/si4713.c:1448:7: error: 'struct si4713_device' has no member named 'supply_data'
  struct si4713_device *sdev;
       ^
drivers/media/radio/si4713/si4713.c:1450:46: error: 'struct si4713_device' has no member named 'supplies'
  struct v4l2_ctrl_handler *hdl;
                                              ^
drivers/media/radio/si4713/si4713.c:1451:11: error: 'struct si4713_device' has no member named 'supply_data'
  int rval, i;
           ^
drivers/media/radio/si4713/si4713.c:1583:26: error: 'struct si4713_device' has no member named 'supplies'
 
                          ^
drivers/media/radio/si4713/si4713.c:1583:42: error: 'struct si4713_device' has no member named 'supply_data'
 
                                          ^
drivers/media/radio/si4713/si4713.c: In function 'si4713_remove':
drivers/media/radio/si4713/si4713.c:1607:26: error: 'struct si4713_device' has no member named 'supplies'
   goto free_irq;
                          ^
drivers/media/radio/si4713/si4713.c:1607:42: error: 'struct si4713_device' has no member named 'supply_data'
   goto free_irq;
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
