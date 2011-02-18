From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [RESEND][PATCH v2] OMAP: DSS: Adding two APIs for panel-taal:
 check_timings and set_timings
Date: Fri, 18 Feb 2011 13:50:31 +0200
Message-ID: <1298029831.24062.72.camel@deskari>
References: <1297864482-16903-1-git-send-email-mayur@ti.com>
	 <1297864658.988.21.camel@deskari>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033C768AE7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46494 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861Ab1BRLue (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 06:50:34 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1IBoXdN024531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:50:33 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1IBoXen023479
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:50:33 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1IBoXhu001852
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 05:50:33 -0600 (CST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB033C768AE7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-02-17 at 02:50 -0600, Janorkar, Mayuresh wrote:
> Tomi,
> 

<snip>

> > If so, I think the change should be in the omapfb driver. Perhaps the
> > omapfb driver should:
> > 
> > 1. check if check_timings & set_timings exist
> > 2. if they do exist, do the same thing as the code does now
> > 3. if they don't, use get_timings to verify that the given resolution is
> > correct
> 
> But that would lead to a situation in which you would set the bits-per-pixel without checking if panel supports it.

You are mixing up the panel's color depth and the framebuffer's color
depth. The panel has a certain color depth, and that is not changed.

The fb parameter sets up the framebuffer color depth. DISPC will convert
that input color depth to 24bpp internally, and then again convert it to
16/18/24 bpp when outputting it to the panel. So fb and panel color
depths are independent.

> > That wouldn't be perfect either, but I guess it should do the job. But
> > this is again something where FB framework and OMAP HW do not quite
> > match, and we end up with hacky solution, no matter what we do. But we
> > can try to keep the hacks in the omapfb driver =).
> 
> 
> OMAPFB depends a on the attached panel for configuring FB parameters.
> panel-generic-dpi.c it has an API dpi_check_timings which checks whether timings are supported or not.
> How about adding a similar API for dsi_check_timings? We would call it from panel-taal.
> (I do understand that timings required by taal are only xres and yres much less compared to dpi)

For command mode panels the xres and yres are hardcoded, you cannot
change them. I don't see a reason to have a set or check function for
that. Omapfb should not try to change the values, if they cannot be
changed.

I think in this case omapfb should just check if the given xres/yres is
correct, and use the given bpp for the framebuffer.

 Tomi


