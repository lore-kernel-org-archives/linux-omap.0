From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 3/3] OMAP3: PM: Adding OMAP3630 support in smartreflex
 driver
Date: Tue, 9 Mar 2010 14:25:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB0A1@dbde02.ent.ti.com>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
 <1268068851-30022-2-git-send-email-thara@ti.com>
 <1268068851-30022-3-git-send-email-thara@ti.com>
 <1268068851-30022-4-git-send-email-thara@ti.com>
 <20100308181846.GC6630@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab0CIIzS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 03:55:18 -0500
In-Reply-To: <20100308181846.GC6630@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



>>-----Original Message-----
>>From: Felipe Balbi [mailto:me@felipebalbi.com]
>>Sent: Monday, March 08, 2010 11:49 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com; paul@pwsan.com; Menon, Nishanth;
>>Sripathy, Vishwanath; Sawant, Anand; Cousson, Benoit
>>Subject: Re: [PATCH 3/3] OMAP3: PM: Adding OMAP3630 support in smartreflex driver
>>
>>hi,
>>
>>On Mon, Mar 08, 2010 at 10:50:51PM +0530, Thara Gopinath wrote:
>>> @@ -289,32 +311,66 @@ static void __init vp_reg_configure(int vp_id)
>>>
>>>  		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
>>>  		if (vp_id == VP1) {
>>> -			/*
>>> -			 * OMAP3430 has error gain varying btw higher and
>>> -			 * lower opp's
>>> -			 */
>>> -			vp_reg[vp_id].vp_errorgain = (((get_vdd1_opp() > 2) ?
>>> -					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
>>> -					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
>>> +			u8 vlimitto_vddmin, vlimitto_vddmax;
>>> +
>>> +			if (cpu_is_omap3630()) {
>>> +				vlimitto_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
>>> +				vlimitto_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
>>> +				/*
>>> +				 * OMAP3630 has error gain varying btw
>>> +				 * all opp's
>>> +				 */
>>> +				vp_reg[vp_id].vp_errorgain =
>>> +					(omap_errorgain[get_vdd1_opp() - 1] <<
>>> +					OMAP3430_ERRORGAIN_SHIFT);
>>
>>this error gain hunk repeats itself over and over again. How about
>>adding an inline function for handling that ? Also, why not using
>>SR version you added instead of cpu_is_xxx() check ?
Hello Felipe 

I could try adding a separate inline function. But I cannot use SR version to check this. This is because the error gain values vary between OMAP3430 OMAP3630 and OMAP4 and is independent of the smartreflex ip in use.

Regards
Thara
