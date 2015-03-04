From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 06/21] drm/omap: check CRTC color format earlier
Date: Thu, 05 Mar 2015 01:41:52 +0200
Message-ID: <4801838.aaTqeHiXe3@avalon>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com> <20150227120757.GW24485@phenom.ffwll.local> <54F433A4.5050303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:60025 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbbCDXlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2015 18:41:50 -0500
In-Reply-To: <54F433A4.5050303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

Hi Tomi,

On Monday 02 March 2015 11:55:48 Tomi Valkeinen wrote:
> On 27/02/15 14:07, Daniel Vetter wrote:
> > On Thu, Feb 26, 2015 at 03:20:14PM +0200, Tomi Valkeinen wrote:
> >> When setting a color format to a DRM plane, the DRM core checks whether
> >> the format is supported by the HW. However, it seems that when setting
> >> the color format of a CRTC (i.e. a root plane), there's no checking
> >> done. This causes omapdrm to configure omapdss with the bad color
> >> format, which omapdss then rejects.
> >> 
> >> While the above is ok, the error message is a bit confusing, and the
> >> configuring of omapdss happens asynchronously from the ioctl that does
> >> the color format change.
> >> 
> >> This patch adds a color format check to omap_plane_mode_set() which
> >> causes the ioctl to return an error for invalid color format. This means
> >> that the userspace will get to know of the wrong setting, instead of the
> >> current behavior where the error is not seen by the userspace.
> >> 
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >> ---
> >> 
> >>  drivers/gpu/drm/omapdrm/omap_plane.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >> 
> >> diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c
> >> b/drivers/gpu/drm/omapdrm/omap_plane.c index 1f4f2b866379..bedd6f7af0f1
> >> 100644
> >> --- a/drivers/gpu/drm/omapdrm/omap_plane.c
> >> +++ b/drivers/gpu/drm/omapdrm/omap_plane.c
> >> @@ -207,6 +207,24 @@ int omap_plane_mode_set(struct drm_plane *plane,
> >> 
> >>  {
> >>  
> >>  	struct omap_plane *omap_plane = to_omap_plane(plane);
> >>  	struct omap_drm_window *win = &omap_plane->win;
> >> 
> >> +	int i;
> >> +
> >> +	/*
> >> +	 * Check whether this plane supports the fb pixel format.
> >> +	 * I don't think this should really be needed, but it looks like the
> >> +	 * drm core only checks the format for planes, not for the crtc. So
> >> +	 * when setting the format for crtc, without this check we would
> >> +	 * get an error later when trying to program the color format into
> >> the
> >> +	 * HW.
> >> +	 */
> > 
> > I think we should add a format check to the setcrtc ioctl if crtc->primary
> > is set. Atm the code is in __setplane_internal but could easily be shared
> > - there's already a copy in drm_atomi.c.
> > 
> > Omapdrm wouldn't benefit from this yet since it doesn't support universal
> > planes. But adding universal planes should be on your todo anyway ;-)
> 
> Laurent is working on universal planes and atomic modesetting for
> omapdrm. In fact, I think universal planes is already done in his WIP
> branch.
> 
> So, if this check is already done with universal planes (if I understood
> correctly), I'm fine with dropping this patch.

Yes, I've implemented universal plane support. I'm currently rebasing your 
patches on top of my bug fixes (excluding the more intrusive atomic update 
rework). I'll push the resulting branch shortly and will send the patches for 
review.

-- 
Regards,

Laurent Pinchart

