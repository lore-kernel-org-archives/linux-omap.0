From: Maxim Podbereznyy <lisarden@gmail.com>
Subject: Problem to set fb timings for a new display
Date: Wed, 15 Jun 2011 20:05:34 +0400
Message-ID: <BANLkTi=nPWgTizMyL=EDitPF1NFV9L1www@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44679 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab1FOQFf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jun 2011 12:05:35 -0400
Received: by iwn34 with SMTP id 34so395713iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 09:05:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi!

I'm using Beagleboard clone with TFT display connected. The display is 3.5"
320x240.

I created a new driver for this display for the kernel 2.6.32 (beagleboard
BSP) obtained from the OE environment. When u-boot starts I set the
following variables:

> setenv defaultdisplay pt35
> setenv dvimode 320x240MR-16@60

All I need is to have timings specified in my driver:

static struct omap_video_timings pt35_timings = {
        .x_res = 320,
        .y_res = 240,

        .pixel_clock    = 8000,

        .hsw            = 30,
        .hfp            = 40,
        .hbp            = 0,

        .vsw            = 5,
        .vfp            = 13,
        .vbp            = 4,
};

But with dvimode set to 320x240MR-16@60 an image is rather good, but is
shifted a little. As I understand the timings is calculated by CVT and I
can't change them.
If I set dvimode to 320x240-16@60 then I get timings from
drivers/video/modedb.c:
}, {
        /* 320x240 @ 60 Hz, 31.5 kHz hsync, 4:3 aspect ratio */
        NULL, 60, 320, 240, 79440, 16, 16, 16, 5, 48, 1,
        0, FB_VMODE_DOUBLE
    }, {

I want to set margins (porches) for the image but don't know how. Please
advise!

best regards,
Max
