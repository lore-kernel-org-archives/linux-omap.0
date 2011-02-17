From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [RESEND][PATCH v2] OMAP: DSS: Adding two APIs for panel-taal:
 check_timings and set_timings
Date: Thu, 17 Feb 2011 14:20:38 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033C768AE7@dbde02.ent.ti.com>
References: <1297864482-16903-1-git-send-email-mayur@ti.com>
 <1297864658.988.21.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60967 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab1BQIuo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 03:50:44 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1H8of3q013000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 02:50:43 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1H8oeFs011602
	for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 14:20:40 +0530 (IST)
In-Reply-To: <1297864658.988.21.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tomi,

> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Wednesday, February 16, 2011 7:28 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RESEND][PATCH v2] OMAP: DSS: Adding two APIs for panel-taal:
> check_timings and set_timings
> 
> Hi,
> 
> On Wed, 2011-02-16 at 07:54 -0600, Janorkar, Mayuresh wrote:
> > check_timings and set_timings APIS are not present for panel-taal.
> >
> > OMAPFB provides a bootarg omapfb.mode for setting mode parameters which
> include display,
> > resolution, bits-per-pixel.
> >
> > OMAPFB expects panel driver to have check_timings and set_timings APIs.
> > These are checked by omapfb in case we wish to set default mode through
> bootargs.
> > e.g.: omapfb.mode="lcd:864x480-16" (display device:width X height - bits
> per pixel)
> >
> > omapfb_set_def_mode function in omapfb-main.c essentially needs these
> functions
> > otherwise it would return -EINVAL and default mode sent through bootargs
> > would be ignored.
> 
> I don't like this patch. You cannot change the timings for Taal, so
> those added functions look quite hacky.
> 
> The reason for this patch isn't clear from the description (it should).
> If I guess correctly, the point of the patch is to be able to change the
> default color format via boot arguments when using taal panel?

The intent of this patch was ability to change bits-per-pixel of framebuffer through bootargs.

> 
> If so, I think the change should be in the omapfb driver. Perhaps the
> omapfb driver should:
> 
> 1. check if check_timings & set_timings exist
> 2. if they do exist, do the same thing as the code does now
> 3. if they don't, use get_timings to verify that the given resolution is
> correct

But that would lead to a situation in which you would set the bits-per-pixel without checking if panel supports it.

> That wouldn't be perfect either, but I guess it should do the job. But
> this is again something where FB framework and OMAP HW do not quite
> match, and we end up with hacky solution, no matter what we do. But we
> can try to keep the hacks in the omapfb driver =).


OMAPFB depends a on the attached panel for configuring FB parameters.
panel-generic-dpi.c it has an API dpi_check_timings which checks whether timings are supported or not.
How about adding a similar API for dsi_check_timings? We would call it from panel-taal.
(I do understand that timings required by taal are only xres and yres much less compared to dpi)

> 
>  Tomi
> 

