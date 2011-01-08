From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] omap3: Enable SmartReflex calculations for 720MHz
Date: Sat, 8 Jan 2011 17:59:27 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024829AF66@dbde02.ent.ti.com>
References: <1294421217-18730-1-git-send-email-premi@ti.com>
 <4D276F99.1080007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52488 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697Ab1AHM3k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jan 2011 07:29:40 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p08CTao0003939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 8 Jan 2011 06:29:38 -0600
In-Reply-To: <4D276F99.1080007@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com] 
> Sent: Saturday, January 08, 2011 1:25 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC] omap3: Enable SmartReflex calculations for 720MHz
> 
> Sanjeev Premi had written, on 01/07/2011 11:26 AM, the following:
> > The eFuse registers do not contain the nValue to be used
> > with 720MHz (OPP6). This patch implements procedure to
> > calculate the nValue(OPP6) based on the nValue(OPP5).
> > 
> >   [1] SPRUFF1D-June 2009 section 1.5.2.1.1
> Where is this doc?
> http://focus-webapps.ti.com/general/docs/sitesearch/searchsite
> .tsp;jsessionid=TKKPEXXTMNJCPQC1JAWBVQQ?selectedTopic=16532603
> 27&numRecords=25&searchTerm=SPRUFF1D&statusCode=null
> 
> Google seems to point to:
> http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
> but ti.com responds with document not found.
> 

[sp] Thanks for pointing out. It is not accessible for some reasons.
     It can be...  and is being looked into as i write this message.

[snip]...[snip]

> > +#define SWCALC_OPP6_DELTA_NNT	379
> > +#define SWCALC_OPP6_DELTA_PNT	227
> > +#define GAIN_MAXLIMIT		16
> 
> Magic numbers - do they scale from 3430 to 3630?

[sp] The patch is meant for 720MHz - which is applicable for 3430 only.
     So, these values are meant for 3430.

[snip]...[snip]

> 
> > +
> > +static u32 swcalc_opp6_nvalue(u32 opp5_nvalue)
> so what does this actually do?

[sp] Returns a nvalue which corresponds to opp6 based on input which
     is nvalue of opp5. Elementary?

     I don't think it is as bad as: u32 process (u32 n)

> > +{

[snip]...[snip]

> > +       opp6_nvalue = (opp6_senPgain << 0x14) | 
> (opp6_senNgain < 0x10) |
> > +                       (opp6_senPRN << 0x8) | opp6_senNRN;
> > +
> > +       return opp6_nvalue;

[sp] Elementary, if you preferred to read the code. Rather that glossing
     over in hurry to respond compulsively. 

> > +}

[snip]...[snip]

> Sorry, Dumb question:
> a) You are using OPP5's nTarget to use in OPP6's nTarget? 
> is'nt it fused 
> in for OPP6 offset?

[sp] Again, in hurry to respond, you missed the description for the patch
     [quote]
     The eFuse registers do not contain the nValue to be used
     with 720MHz (OPP6). This patch implements procedure to
     calculate the nValue(OPP6) based on the nValue(OPP5).
     [/quote]

> b) you are using OMAP343X_CONTROL_FUSE_OPP5_VDD1 itself

[sp] Quoting the description:
     [quote]
     The eFuse registers do not contain the nValue to be used
     with 720MHz (OPP6). This patch implements procedure to
     calculate the nValue(OPP6) based on the nValue(OPP5).
     [/quote]

     Repeating again, just in case you missed: nvalues for OPP6 are
     calculated based on the nvalues for OPP5. So, i need to use
     OMAP343X_CONTROL_FUSE_OPP5_VDD1.

> c) these should be __init functions.

[sp] They will be when i post formal patch.

> d) how would you allow this code to work with 3440?

[sp] Does 3440 have same behavior? If so, it is quite easy by
     updating this check.
     [quote]
     +	if (cpu_is_omap34xx() && omap3_has_720mhz()) {
     +		nvalue_table[count-1].nvalue = swcalc_opp6_nvalue(
     +					nvalue_table[count-2].nvalue);
     +	}
     [/quote]

     However, i am not conversant with 3440. This will have to be
     covered by a separate patch.

> e) next time could you please try STOP using CaMELCASInG in your 
> variables and functions?

[sp] Did you ever notice any camelcase in any of my formal patch
     submissions earlier. 10 brownie points for catching it here!

> f) please add sufficient documentation in kernel-doc style to 
> allow us 
> to understand the story below?
[sp] Is there anything more to "story" than mentioned in the patch
     description and the SPRU referenced.
     
     It is not accessible for some reasons - may be re-indexing
     done last week. But that can be... and is being looked into
     as i write this message.

     If something isn't clear, can you be more specific? I'd rather
     write code than stories!

> g) dont use magic numbers

[sp] Some magin numbers here cannot be avoided. Specifically in shift
     operations as they are (possibly) optimization for costly multiple
     and divide operations.

> h) please take care of ROUND_DOWN and ROUND_UP and truncation errors

[sp] Where?

> i) is this equation ONLY valid for opp5 ntarget modification on 
> OMAP3530? or valid for 3440 as well? or valid for any OPP ntarget 
> modification?

[sp] Repeating the patch description here would have helped you;
     but may not be convenient for other reviewers. Can you browse
     to top of this mail again and read the description again?

> 
> >  	sr_data->nvalue_table = nvalue_table;
> >  	sr_data->nvalue_count = count;
> >  }
> > diff --git a/arch/arm/mach-omap2/voltage.c 
> b/arch/arm/mach-omap2/voltage.c
> > index ed6079c..f23b6d7 100644
> > --- a/arch/arm/mach-omap2/voltage.c
> > +++ b/arch/arm/mach-omap2/voltage.c
> > @@ -258,6 +258,7 @@ static struct omap_volt_data 
> omap34xx_vddmpu_volt_data[] = {
> >  	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP3_UV, 
> OMAP343X_CONTROL_FUSE_OPP3_VDD1, 0xf9, 0x18),
> >  	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP4_UV, 
> OMAP343X_CONTROL_FUSE_OPP4_VDD1, 0xf9, 0x18),
> >  	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP5_UV, 
> OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
> > +	VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP6_UV, 
> OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
> you might as well use OPP6_VDD1 for CONTROL_FUSE?

[sp] Risking repetition once more. There is not EFUSE register for OPP6.
     Defining it - with obviously the same values at OPP5_VDD1 - would
     only mislead the person reading the code.

~sanjeev
