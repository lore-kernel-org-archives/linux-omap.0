From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC] omap3: Enable SmartReflex calculations for 720MHz
Date: Sat, 8 Jan 2011 16:42:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024829AF5F@dbde02.ent.ti.com>
References: <1294421217-18730-1-git-send-email-premi@ti.com>
 <4D276F99.1080007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50621 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab1AHLMx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jan 2011 06:12:53 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p08BCoBO026868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 8 Jan 2011 05:12:52 -0600
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

[snip]...[snip]

> Sorry, Dumb question:
> a) You are using OPP5's nTarget to use in OPP6's nTarget? 
> is'nt it fused 
> in for OPP6 offset?
> b) you are using OMAP343X_CONTROL_FUSE_OPP5_VDD1 itself
> c) these should be __init functions.
> d) how would you allow this code to work with 3440?
> e) next time could you please try STOP using CaMELCASInG in your 
> variables and functions?
> f) please add sufficient documentation in kernel-doc style to 
> allow us 
> to understand the story below?
> g) dont use magic numbers
> h) please take care of ROUND_DOWN and ROUND_UP and truncation errors
> i) is this equation ONLY valid for opp5 ntarget modification on 
> OMAP3530? or valid for 3440 as well? or valid for any OPP ntarget 
> modification?
> 

Under garb of asking dumb questions, you seem to be exposing yourself as one!!
(Specifically since we exchanged multiple private emails on this topic yesterday)

You have completely missed the whole intent of this RFC:

1) Look for possible problems that might arise because adding additional entry
   in the omap34xx_vddmpu_volt_data[]

   I didn't thinks so, since the array is static data and currently this array
   size is related to the array holding nValues for each OPP.

2) Look for advice on (or work in procress if) any that may help fix the kludge
   in the code section marked FIXME where better mechanism is required to extract
   the nvalues corresponding to OPP5.

3) Use this weekend to esp the lead time available due to time difference to have
   something valuable to start working on the 

I would have loved to see coding and documentation related comments had this been
a formal patch.

I will respond to some of other 'valid' queries in separate mail.

Have tried to stop myself a lot before, but couldn't find a better way to
respond :)

~sanjeev

[snip]...[snip]