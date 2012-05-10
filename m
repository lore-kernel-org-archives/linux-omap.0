From: Hein Tibosch <hein_tibosch@yahoo.es>
Subject: Re: omapfb-main.c: check result of simple_strtoul
Date: Thu, 10 May 2012 18:51:45 +0800
Message-ID: <4FAB9DC1.6000908@yahoo.es>
References: <4FAA838A.3040106@yahoo.es> <1336638194.5182.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bosmailout10.eigbox.net ([66.96.188.10]:49987 "EHLO
	bosmailout10.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758869Ab2EJLgn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 07:36:43 -0400
Received: from bosmailscan14.eigbox.net ([10.20.15.14])
	by bosmailout10.eigbox.net with esmtp (Exim)
	id 1SSR03-0005zX-9I
	for linux-omap@vger.kernel.org; Thu, 10 May 2012 06:53:35 -0400
In-Reply-To: <1336638194.5182.28.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On 5/10/2012 4:23 PM, Tomi Valkeinen wrote:
> On Wed, 2012-05-09 at 22:47 +0800, Hein Tibosch wrote:
>>   		fbnum = simple_strtoul(p, &p, 10);
>> -		if (p == param)
>> +		if (p == start)
>>
>> correct?
> Yes, looks like a correct fix. I'll cook up a patch.
>
> How did you encounter the bug? What was the outcome?
I was reading the source, adding some printk's to get more debugging.

It would fail to detect a syntax error like:

     "omapfb.vram=0:2M,:5M"


If I may ask: why aren't "mode" and "modes" filled in:

    /sys/devices/platform/omapfb/graphics/fb0 ?

Only "modes" will get an entry when a new mode becomes active.

I thought of adding something like this in hdmi.c:

+static void omap_to_fbmode (struct fb_videomode *fb_mode, const struct hdmi_config *cfg)
+{
+	char name[64];
+	unsigned hsync;
+	unsigned vsync;
+	unsigned refresh;
+	snprintf (name, sizeof name, "%d_%s_%d.%d",
+		cfg->cm.code,
+		cfg->cm.mode == HDMI_HDMI ? "hdmi" : "dvi",
+		cfg->timings.x_res,
+		cfg->timings.y_res);
+
+	hsync = cfg->timings.hfp + cfg->timings.hsw + cfg->timings.hbp + cfg->timings.x_res;
+	vsync = cfg->timings.vfp + cfg->timings.vsw + cfg->timings.vbp + cfg->timings.y_res;
+	refresh = (unsigned) ((1000U * cfg->timings.pixel_clock + (hsync * vsync-1) ) / (hsync * vsync));
+	
+	fb_mode->name = kstrdup(name, GFP_KERNEL);	/* optional */
+	fb_mode->refresh = refresh;		/* optional */
+	fb_mode->xres = cfg->timings.x_res;
+	fb_mode->yres = cfg->timings.y_res;
+	fb_mode->pixclock = DIV_ROUND_UP (1000000000UL, cfg->timings.pixel_clock);
+	fb_mode->left_margin = cfg->timings.hfp;
+	fb_mode->right_margin = cfg->timings.hbp;
+	fb_mode->upper_margin = cfg->timings.vfp;
+	fb_mode->lower_margin = cfg->timings.vbp;
+	fb_mode->hsync_len = cfg->timings.hsw;
+	fb_mode->vsync_len = cfg->timings.vsw;
+	fb_mode->sync =
+		(cfg->timings.vsync_pol ? FB_SYNC_VERT_HIGH_ACT : 0) |
+		(cfg->timings.hsync_pol ? FB_SYNC_HOR_HIGH_ACT : 0);
+	fb_mode->vmode = 0;
+	fb_mode->flag = 0;
+}
+
+int omap2_add_video_modes (struct fb_info *fbi)
+{
+	struct fb_videomode fb_mode;
+	int i;
+	int count = 0;
+
+	INIT_LIST_HEAD(&fbi->modelist);
+
+	for (i = 0; i < ARRAY_SIZE(cea_timings); i++) {
+		omap_to_fbmode (&fb_mode, &cea_timings[i]);
+		fb_add_videomode(&fb_mode, &fbi->modelist);
+		count++;
+	}
+	for (i = 0; i < ARRAY_SIZE(vesa_timings); i++) {
+		omap_to_fbmode (&fb_mode, &vesa_timings[i]);
+		fb_add_videomode(&fb_mode, &fbi->modelist);
+		count++;
+	}
+	return count;
+}


and call it from omapfb-main.c:

static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
{
	...
 		clear_fb_info(fbi);

 		fbdev->fbs[i] = fbi;
+		omap2_add_video_modes (fbi);

With this patch I get 34 working entries from "cat modes":

U:1024x768p-59
U:1280x800p-67
U:1680x1050p-59
U:1400x1050p-59
U:1280x768p-59
U:1920x1080p-60
U:1366x768p-59
...

which makes testing a bit easier.

But maybe I'm reinventing some wheel?


Hein
