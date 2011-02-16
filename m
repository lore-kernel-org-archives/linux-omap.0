From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RESEND][PATCH v2] OMAP: DSS: Adding two APIs for panel-taal:
 check_timings and set_timings
Date: Wed, 16 Feb 2011 15:57:38 +0200
Message-ID: <1297864658.988.21.camel@deskari>
References: <1297864482-16903-1-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55409 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877Ab1BPN5l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 08:57:41 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1GDve95023976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 07:57:40 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1GDvdI9028229
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 07:57:39 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1GDvdNR016745
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 07:57:39 -0600 (CST)
In-Reply-To: <1297864482-16903-1-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2011-02-16 at 07:54 -0600, Janorkar, Mayuresh wrote:
> check_timings and set_timings APIS are not present for panel-taal.
> 
> OMAPFB provides a bootarg omapfb.mode for setting mode parameters which include display,
> resolution, bits-per-pixel.
> 
> OMAPFB expects panel driver to have check_timings and set_timings APIs.
> These are checked by omapfb in case we wish to set default mode through bootargs.
> e.g.: omapfb.mode="lcd:864x480-16" (display device:width X height - bits per pixel)
> 
> omapfb_set_def_mode function in omapfb-main.c essentially needs these functions
> otherwise it would return -EINVAL and default mode sent through bootargs
> would be ignored.

I don't like this patch. You cannot change the timings for Taal, so
those added functions look quite hacky.

The reason for this patch isn't clear from the description (it should).
If I guess correctly, the point of the patch is to be able to change the
default color format via boot arguments when using taal panel?

If so, I think the change should be in the omapfb driver. Perhaps the
omapfb driver should:

1. check if check_timings & set_timings exist
2. if they do exist, do the same thing as the code does now
3. if they don't, use get_timings to verify that the given resolution is
correct

That wouldn't be perfect either, but I guess it should do the job. But
this is again something where FB framework and OMAP HW do not quite
match, and we end up with hacky solution, no matter what we do. But we
can try to keep the hacks in the omapfb driver =).

 Tomi


