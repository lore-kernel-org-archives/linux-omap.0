From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH] OMAP3630: DSS2: Enable Pre-Multiplied Alpha Support
Date: Wed, 03 Nov 2010 11:21:13 +0200
Message-ID: <1288776073.5614.183.camel@tubuntu>
References: <1288174567-24734-1-git-send-email-samreen@ti.com>
	 <1288709767.5614.138.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087034BE1E990@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41187 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab0KCJU5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Nov 2010 05:20:57 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BE1E990@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "Nilofer, Samreen" <samreen@ti.com>, "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linufbdev@vger.kernel.org" <linufbdev@vger.kernel.org>, Rajkumar N <rajkumar.nagarajan@ti.com>, Sudeep Basavaraj <sudeep.basavaraj@ti.com>

On Wed, 2010-11-03 at 08:57 +0100, ext Taneja, Archit wrote:
> Hi,
> 
> linux-omap-owner@vger.kernel.org wrote:
> > Alpha Support
> > 
> 
> [snip]
> 
> >> 
> >> +static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool +enable) {
> >> +	if (!dss_has_feature(FEAT_PREMUL_ALPHA))
> >> +		return;
> >> +
> >> +	BUG_ON(!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
> >> +		plane == OMAP_DSS_VIDEO1);
> > 
> > What is the rationale for having the function return, if
> > FEAT_PREMUL_ALPHA is not supported, but BUG if plane is video1 and
> > GLOBAL_ALPHA_VID1 is not supported?
> 
> Premultiplied alpha is available on omap36xx and above, but on 36xx
> since global alpha itself isn't supported for video1 then writing to
> the pre multiplied alpha bit is incorrect.
> 
> It could have been possible to make a new feature like FEAT_PRE_MULT_VID1
> but I think its redundant as FEAT_GLOBAL_ALPHA_VID1 is enough to determine
> if we should set the pre multiplied alpha bit for video1 plane or not.

I was referring to the first check using return, and the second using
BUG(). If nobody is supposed to call that function when

!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) && plane == OMAP_DSS_VIDEO1)

then why is it ok to call that function when 

!dss_has_feature(FEAT_PREMUL_ALPHA)

Shouldn't they both be either returns or BUGs?

  Tomi


