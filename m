From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] omap3: Enable SmartReflex calculations for 720MHz
Date: Mon, 10 Jan 2011 18:02:18 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024829B6FE@dbde02.ent.ti.com>
References: <1294421217-18730-1-git-send-email-premi@ti.com>
 <4D276F99.1080007@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024829AF66@dbde02.ent.ti.com>
 <4D287AF5.3070300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33908 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197Ab1AJMc1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 07:32:27 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0ACWOMJ002768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 06:32:27 -0600
In-Reply-To: <4D287AF5.3070300@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com] 
> Sent: Saturday, January 08, 2011 8:26 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC] omap3: Enable SmartReflex calculations for 720MHz
> 
> Premi, Sanjeev wrote, on 01/08/2011 06:29 AM:

[snip]...[snip]

> >>
> >> Magic numbers - do they scale from 3430 to 3630?
> >
> > [sp] The patch is meant for 720MHz - which is applicable 
> for 3430 only.
> >       So, these values are meant for 3430.
> Right - and since sr_device is common for omap3, omap4 etc.. 
> does'nt it 
> make sense to isolate code properly out?

[sp] The code is already being protected with:
	if (cpu_is_omap34xx() && omap3_has_720mhz()) {...}

     So, it won't even run for either 36XX OR 44XX as neither
     will return success for this condition.

     What more isolation do you want?

[snip]...[snip]

> >>> +static u32 swcalc_opp6_nvalue(u32 opp5_nvalue)
> >> so what does this actually do?
> >
> > [sp] Returns a nvalue which corresponds to opp6 based on input which
> >       is nvalue of opp5. Elementary?
> yes Sherlock :). I apologize that I was'nt clear. But I was wondering 
> about the following:
> what does the algo actually do - does it add a specific 
> voltage delta or some %v to previous nTarget?
> 
> It takes an input and does some magic - what does that magic 
> algo do to produce output?
> 
> it is possible that it is self evident to you, but it is not to me - 
> probably because I dont have the mentioned doc to refer to.

[sp] ?? ?? ?? ?? Is this supposed to mean something?

> what is the overall objective of this code?
> we have start nTarget from OPP5 and we are trying to put in a new one 
> for OPP6 out of the previous one.

[sp] "Maxima enim... patientia virtus" - Piers Plowman (1377).

     You are obviously driven by compulsion to just write something;
     couldn't wait for the referenced document to be made available.

     Your response was approx 6 hours ahead of me updating the link.

> things that pop in my mind are:
> a) if this was the case, I just need OPP1 value, I could 
> generate values for all other OPPs.

[sp] Having a hammer in your hand doesn't mean you can bang it
     everywhere.

     The patch clearly indicates the purpose and relationship
     between OPP5 and OPP6 established by HW folks. You can
     spend time "imagine"ering and extrapolating to your whims;
     but that is only you.

     The algo used (and referenced) here is pretty clear in its
     purpose and application.

> b) if the algo itself was generic enough, we could use it in 
> OMAP3430, 3630, OMAP4 etc..

[sp] Read this condition once more:
	if (cpu_is_omap34xx() && omap3_has_720mhz()) {...}

> - as far as I have confirmed from h/w team in the last 
> couple of years multiple times, ntarget generation algo for 
> OMAP34,36,4x series is not algo based, but production floor
> operation based (making it unique and not really an algo based
> mechanism of nTarget programming).

[sp] Why is is that you have always confirmed something and it
     is never official?
     
     The TRM is an official document and certain process is
     followed before information finds its way into TRM. Errors
     possible, but until they need to be investigated, verified
     and officially recognized.
     
     If you have found any issue, work with HW team to validate
     it and fix/update the TRM.

     Until then, refrain from spreading rumors.
>
> >
> >>> +{
> >
> > [snip]...[snip]
> >
> >>> +       opp6_nvalue = (opp6_senPgain<<  0x14) |
> >> (opp6_senNgain<  0x10) |
> >>> +                       (opp6_senPRN<<  0x8) | opp6_senNRN;
> >>> +
> >>> +       return opp6_nvalue;
> >
> > [sp] Elementary, if you preferred to read the code. Rather 
> that glossing
> >       over in hurry to respond compulsively.
> I had hoped you could help my time a little (I do other things other 
> than review as well ;)) by documenting the algo in the 
> function header?

[sp] If you can say something in code or say something in comments,
     then say it in code. - Dan Saks (C++ Programming Style, 1996)

     "static u32 swcalc_opp6_nvalue(u32 opp5_nvalue)"

     Algo is referenced from TRM and that's best it can be documented.

> 
> >
> >>> +}
> >
> > [snip]...[snip]
> >
> >> Sorry, Dumb question:
> >> a) You are using OPP5's nTarget to use in OPP6's nTarget?
> >> is'nt it fused
> >> in for OPP6 offset?
> >
> > [sp] Again, in hurry to respond, you missed the description 
> for the patch
> >       [quote]
> >       The eFuse registers do not contain the nValue to be used
> >       with 720MHz (OPP6). This patch implements procedure to
> >       calculate the nValue(OPP6) based on the nValue(OPP5).
> >       [/quote]
> 
> Right - how does it calculate the value for OPP6 from OPP5?

[sp] Read either the code/ the referenced document.

> 
> >
> >> b) you are using OMAP343X_CONTROL_FUSE_OPP5_VDD1 itself
> >
> > [sp] Quoting the description:
> >       [quote]
> >       The eFuse registers do not contain the nValue to be used
> >       with 720MHz (OPP6). This patch implements procedure to
> >       calculate the nValue(OPP6) based on the nValue(OPP5).
> >       [/quote]
> >
> >       Repeating again, just in case you missed: nvalues for OPP6 are
> >       calculated based on the nvalues for OPP5. So, i need to use
> >       OMAP343X_CONTROL_FUSE_OPP5_VDD1.
> why not define CONTROL_FUSE_OPP6_VDD1 with the same offset?

[sp] And let someone trying to understand the code, few months down,
     believe that there is in fact placeholder for OPP6 in the eFuse?

     I'd rather him be questioning why offset to OPP5 value is being
     used in OPP6? And follow thru to find right information.

> 
> >
> >> c) these should be __init functions.
> >
> > [sp] They will be when i post formal patch.
> >
> >> d) how would you allow this code to work with 3440?
> >
> > [sp] Does 3440 have same behavior? If so, it is quite easy by
> >       updating this check.
> >       [quote]
> >       +	if (cpu_is_omap34xx()&&  omap3_has_720mhz()) {
> >       +		nvalue_table[count-1].nvalue = 
> swcalc_opp6_nvalue(
> >       +					
> nvalue_table[count-2].nvalue);
> >       +	}
> >       [/quote]
> >
> >       However, i am not conversant with 3440. This will have to be
> >       covered by a separate patch.
> Right - could you help start a TI internal conversation and 
> alignment to ensure 3440 is not broken by this change?

[sp] Where are you trying to arrive with 3440 argument each time?

     Support for 720MHz didn't exist in the kernel so far. There was
     not entry in either the OPP table or the SR table containing EFUSE
     offsets. How does this change impact 3440?
     
     Even if, hypothetically, 3440 breaks after the patch is accepted;
     rebase, fix and post the patch!

> 
> >
> >> e) next time could you please try STOP using CaMELCASInG in your
> >> variables and functions?
> >
> > [sp] Did you ever notice any camelcase in any of my formal patch
> >       submissions earlier. 10 brownie points for catching it here!
> why do you waste reviewer time by posting CamelCasing anyways? your 
> responses make me wonder why did I even care to spend time to review 
> your code? could have waited for your formal patch and NAKed 
> it :). ok.. 
> no more discussions from me anymore untill your formal patch arrives

[sp] Thanks! saves lot of time!!

     I have better prospect of getting back to original problem;
     for which the RFC was posted.

     [problem]
	/*
	 * FIXME: This is a temporary hack. Need to identify better
	 *        mechanism to find nvalues corresponding to an OPP.
	 */
	if (cpu_is_omap34xx() && omap3_has_720mhz()) {
		nvalue_table[count-1].nvalue = swcalc_opp6_nvalue(
					nvalue_table[count-2].nvalue);
	}
        
        We either need an API or set of macros to return the nvalue
        corresponding to each OPP.

        We could also go with an assumption that array index is OPPN-1.
        but rather than hack above, it could be curtained by a better
        macro/ inline function.
     [/problem]

~sanjeev
