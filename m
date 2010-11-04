From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH] OMAP3630: DSS2: Enable Pre-Multiplied Alpha Support
Date: Thu, 04 Nov 2010 11:25:13 +0200
Message-ID: <1288862713.5614.224.camel@tubuntu>
References: <1288174567-24734-1-git-send-email-samreen@ti.com>
	 <1288709767.5614.138.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087034BE1E990@dbde02.ent.ti.com>
	 <1288776073.5614.183.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087034BE1EACA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63909 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab0KDJYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 05:24:41 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BE1EACA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "Nilofer, Samreen" <samreen@ti.com>, "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linufbdev@vger.kernel.org" <linufbdev@vger.kernel.org>, Rajkumar N <rajkumar.nagarajan@ti.com>, Sudeep Basavaraj <sudeep.basavaraj@ti.com>

On Wed, 2010-11-03 at 12:57 +0100, ext Taneja, Archit wrote:
> Hi,
> 
> Tomi Valkeinen wrote:
> > On Wed, 2010-11-03 at 08:57 +0100, ext Taneja, Archit wrote:
> >> Hi,
> >> 
> >> linux-omap-owner@vger.kernel.org wrote:
> >>> Alpha Support
> >>> 
> >> 
> >> [snip]
> >> 
> >>>> 
> >>>> +static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool
> >>>> +enable) { +	if (!dss_has_feature(FEAT_PREMUL_ALPHA))
> >>>> +		return;
> >>>> +
> >>>> +	BUG_ON(!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
> >>>> +		plane == OMAP_DSS_VIDEO1);
> >>> 
> >>> What is the rationale for having the function return, if
> >>> FEAT_PREMUL_ALPHA is not supported, but BUG if plane is video1 and
> >>> GLOBAL_ALPHA_VID1 is not supported?
> >> 
> >> Premultiplied alpha is available on omap36xx and above, but on 36xx
> >> since global alpha itself isn't supported for video1 then writing to
> >> the pre multiplied alpha bit is incorrect.
> >> 
> >> It could have been possible to make a new feature like
> >> FEAT_PRE_MULT_VID1 but I think its redundant as FEAT_GLOBAL_ALPHA_VID1
> >> is enough to determine if we should set the pre multiplied
> > alpha bit for video1 plane or not.
> > 
> > I was referring to the first check using return, and the
> > second using BUG(). If nobody is supposed to call that function when
> > 
> > !dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) && plane == OMAP_DSS_VIDEO1)
> > 
> > then why is it ok to call that function when
> > 
> > !dss_has_feature(FEAT_PREMUL_ALPHA)
> > 
> > Shouldn't they both be either returns or BUGs?
> > 
> 
> If you see the current code, _dispc_setup_global_alpha() does the same thing,
> and in the call to it in _dispc_setup_plane() is:
> 
> ...
> ...
> 	if (plane != OMAP_DSS_VIDEO1)
> 		_dispc_setup_global_alpha(plane, global_alpha);
> ...
> ...
> 
> So, I guess this BUG_ON is probably not required for both setup_global_alpha
> and setup_pre_multiplied_alpha if you take care while calling these functions
> from _dispc_setup_plane().

BUGs should be used exactly in those cases, where you are sure you're
always calling the function with right parameters. BUGs are never meant
to trigger, so they should be used as a safeguard against broken
changes.

> But this is the same with _dispc_set_scaling(), _dispc_set_vid_size() etc where
> we have a BUG_ON(plane == OMAP_DSS_GFX) even when we take care of not calling it
> for the GFX pipe.

Yes, I'm sure there are functions that are not perfect =).

So to summarize: if _dispc_set_pre_mult_alpha() is only called from
inside DSS, and it will never be called with a wrong plane argument,
then it should only use BUGs, not return.

Now, the question is, is it better to do the argument checking in the
caller or in the callee? In the case of DSS internal functions it's
perhaps easier if the callee does the checking. So:

_dispc_setup_plane() should always call _dispc_setup_global_alpha(), as
future OMAP versions may support global alpha on any overlay, and I
don't think it's _dispc_setup_plane's job to do that check as the checks
may be lenghty. 

_dispc_setup_global_alpha() would do the check if global_alpha is
supported on that plane, and do nothing if not (or, return an error,
which _dispc_setup_plane() would ignore, but I don't think that's
needed).

And similarly for premult alpha. And I'm not saying all these have to be
changed now, but as general thoughts about the matter.

 Tomi


