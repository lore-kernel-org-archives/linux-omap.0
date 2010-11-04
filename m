From: "Nilofer, Samreen" <samreen@ti.com>
Subject: RE: [PATCH] OMAP3630: DSS2: Enable Pre-Multiplied Alpha Support
Date: Thu, 4 Nov 2010 10:55:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034BE1ECC6@dbde02.ent.ti.com>
References: <1288174567-24734-1-git-send-email-samreen@ti.com>
	 <1288709767.5614.138.camel@tubuntu>
	 <FCCFB4CDC6E5564B9182F639FC356087034BE1E990@dbde02.ent.ti.com>
 <1288776073.5614.183.camel@tubuntu>
 <FCCFB4CDC6E5564B9182F639FC356087034BE1EACA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33624 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109Ab0KDFZl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 01:25:41 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BE1EACA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajkumar N <rajkumar.nagarajan@ti.com>, Sudeep Basavaraj <sudeep.basavaraj@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

Taneja, Archit wrote:
> Hi,
> 
> Tomi Valkeinen wrote:
>> On Wed, 2010-11-03 at 08:57 +0100, ext Taneja, Archit wrote:
>>> Hi,
>>> 
>>> linux-omap-owner@vger.kernel.org wrote:
>>>> Alpha Support
>>>> 
>>> 
>>> [snip]
>>> 
>>>>> 
>>>>> +static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool
>>>>> +enable) { +	if (!dss_has_feature(FEAT_PREMUL_ALPHA)) +		return;
>>>>> +
>>>>> +	BUG_ON(!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
>>>>> +		plane == OMAP_DSS_VIDEO1);
>>>> 
>>>> What is the rationale for having the function return, if
>>>> FEAT_PREMUL_ALPHA is not supported, but BUG if plane is video1 and
>>>> GLOBAL_ALPHA_VID1 is not supported?
>>> 
>>> Premultiplied alpha is available on omap36xx and above, but on 36xx
>>> since global alpha itself isn't supported for video1 then writing to
>>> the pre multiplied alpha bit is incorrect.
>>> 
>>> It could have been possible to make a new feature like
>>> FEAT_PRE_MULT_VID1 but I think its redundant as
>>> FEAT_GLOBAL_ALPHA_VID1 is enough to determine if we should set the
>>> pre multiplied
>> alpha bit for video1 plane or not.
>> 
>> I was referring to the first check using return, and the second using
>> BUG(). If nobody is supposed to call that function when
>> 
>> !dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) && plane == OMAP_DSS_VIDEO1)
>> 
>> then why is it ok to call that function when
>> 
>> !dss_has_feature(FEAT_PREMUL_ALPHA)
>> 
>> Shouldn't they both be either returns or BUGs?
>> 
> 
> If you see the current code, _dispc_setup_global_alpha() does
> the same thing, and in the call to it in _dispc_setup_plane() is:
> 
> ...
> ...
> 	if (plane != OMAP_DSS_VIDEO1)
> 		_dispc_setup_global_alpha(plane, global_alpha); ... ...
> 
> So, I guess this BUG_ON is probably not required for both
> setup_global_alpha and setup_pre_multiplied_alpha if you take
> care while calling these functions from _dispc_setup_plane().
> 
> But this is the same with _dispc_set_scaling(),
> _dispc_set_vid_size() etc where we have a BUG_ON(plane ==
> OMAP_DSS_GFX) even when we take care of not calling it for
> the GFX pipe.
> 
> Archit

[Samreen]
     If this clarification is aligned, should I go ahead and post the patch
with the remaining review comments

Regards,
Samreen