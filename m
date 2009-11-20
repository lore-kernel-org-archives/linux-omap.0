From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: FEATURES - is it good enough
Date: Sat, 21 Nov 2009 01:11:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE620@dbde02.ent.ti.com>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
	<1258732956-18799-2-git-send-email-vikram.pandita@ti.com>
	<4B06BF4D.2090201@ti.com>
	<A24693684029E5489D1D202277BE89444DA61E77@dlee02.ent.ti.com>
	<4B06C0F0.7070007@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BBC43A27@dbde02.ent.ti.com>
 <87eint3uys.fsf@deeprootsystems.com> <4B06ECDD.2030100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38947 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbZKTTlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 14:41:37 -0500
In-Reply-To: <4B06ECDD.2030100@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Saturday, November 21, 2009 12:54 AM
> To: Kevin Hilman
> Cc: Shilimkar, Santosh; Aguirre, Sergio; Pandita, Vikram; 
> linux-omap@vger.kernel.org
> Subject: Re: FEATURES - is it good enough
> 
> Kevin Hilman had written, on 11/20/2009 12:35 PM, the following:
> > "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> > 
> > [...]
> > 
> >>>> Probably not something ot be attached in this patch, but...
> >>>>
> >>>> I'm a bit curious about something:
> >>>>
> >>>> Why touching omap3_features in OMAP4?
> >>>>
> >>>> Isn't there a omap4_features?
> >>>>
> >>>> Or even better, an omap_features?
> >> This "is_feature" suppose to take care of Errata's also, is it?
> > 
> > "It's not a bug it's a feature." :)
> Bug. Santosh pointed out internally to h/w discussion which clearly 
> shows this as a h/w limitation. (thanks santosh)
> 
> > 
> >> This is errata more than a feature..... We better differentiate in
> >> this regard
> > 
> > I agree, I have a hard time calling this empty fifo read fault a
> > "feature."  We need a similar thing for errata.
> Agreed. This is a classic example why we need a common errata 
> handling 
> mechanism scalable across silicon variants on an IP basis. 
> two problems 
> in front of us:
> a) what do we want to do with 8250 workaround needed for omap3630 and 
> omap4? can we go ahead with features marking it clearly as a 
> "misuse of 
> features for the time being"
> b) a common silicon errata handling mechanism: Does anyone have 
> proposals for this? I can see it help in numerous places in our code 
> today and will help readability of the code instead of 
> getting the risk 
> of "feature not a bug" misread.. ;)..

Can we define omap3_errata on lines of omap3_features?

To the original question of why resue omap3_xyz name for omap4?
I guess very valid - unlike features, erratas may not be reused.
So it may make sense to have another omap4_errata as well. Any
duplications due to IP reuse can be handled on the omap3_errata
list (original IP where errata applies).

Deciding whether errata is feature or vice versa?
...ahem, pass.

Best regards,
Sanjeev

> 
> -- 
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 