From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 1/2] drm: support for rotated scanout
Date: Mon, 17 Sep 2012 20:33:33 +0300
Message-ID: <20120917173333.GK19732@intel.com>
References: <1346776556-13098-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62215 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab2IQRdi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Sep 2012 13:33:38 -0400
Content-Disposition: inline
In-Reply-To: <1346776556-13098-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

On Tue, Sep 04, 2012 at 11:35:56AM -0500, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
>=20
> For drivers that can support rotated scanout, the extra parameter
> checking in drm-core, while nice, tends to get confused.  To solve
> this drivers can set the crtc or plane invert_dimensions field so
> that the dimension checking takes into account the rotation that
> the driver is performing.
>=20
> v1: original
> v2: remove invert_dimensions from plane, at Ville's suggestion.
>     Userspace can give rotated src coordinates, so invert_dimensions
>     is not required for planes.
>=20
> Signed-off-by: Rob Clark <rob@ti.com>

Sorry for the delay Rob, I somehow missed this. In any case, the patch
looks OK to me.

Reviewed-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>

--=20
Ville Syrj=E4l=E4
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
