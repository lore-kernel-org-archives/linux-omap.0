From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
Date: Fri, 11 Dec 2009 00:06:25 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9DE54DA68@dnce01.ent.ti.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com>
 <1259211517-12713-2-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.0911300141440.17083@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA90250A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0912010904590.13408@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41314 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933090AbZLJXG1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 18:06:27 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.0912010904590.13408@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "ext-ari.kauppi@nokia.com" <ext-ari.kauppi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Menon, Nishanth" <nm@ti.com>

Paul,

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Paul Walmsley
>Sent: Thursday, December 10, 2009 10:24 PM
>
>Hi Vishwanath,
>
>On Tue, 1 Dec 2009, Sripathy, Vishwanath wrote:
>
>> >
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

>> > From: Paul Walmsley [mailto:paul@pwsan.com]
>> > Sent: Monday, November 30, 2009 3:00 PM
>> > To: Sripathy, Vishwanath
>> > Cc: ext-ari.kauppi@nokia.com; linux-omap@vger.kernel.org; Woodruff,
>Richard;
>> > Menon, Nishanth
>> > Subject: Re: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
>> >
>> > Hello Vishwanath,
>> >
>> > a few comments:
>> >
>> > On Thu, 26 Nov 2009, Vishwanath BS wrote:
>> >
>> > > From: Richard Woodruff <r-woodruff2@ti.com>
>> > >
>> > > DPLL4 for 3630 introduces a changed block requiring special divisor
>bits and
>> > > additional reg fields. To allow for silicons to use this, this is
>introduced
>> > > as a omap3_has_jtype_dpll4() and is enabled for 3630 silicon
>> > >
>> > > Tested with 3630 ZOOM3
>> >
>> > Could you please consider Ari Kauppi's suggestions that he posted on
>> > 30 and 31 October?  They look good to me.  Here is a link:
>> >
>> Regarding comments from Ari Kauppi on addition of dco_sel_mask and
>> sd_div_mask, yes I had a look at them. However I feel, it's better to
>> have these masks in the structure variable. Reason being this approach
>> will help us to support when dpll types for other dplls get changed in
>> future. For example, if dpll3 block is changed, then having new mask
>> will help us to support it.
>
>Is there a product coming out that will add more j-type DPLLs with
>different dco_sel_masks and sd_div_masks?  If not, then let's go with
>Ari's suggested changes, since we don't really know if any more of these
>j-type DPLLs will be used.  We can always add the fields back in when we
>need them.  But if you know for sure that there is a chip variant coming
>out soon that will use more j-type DPLLs, let's talk about it.


OMAP4 is using the same J-type for the DPLL_USB. The programming model is
"almost" the same...
sd_div is a the same location, but dco_sel is not there anymore because that DPLL will always be locked at 960MHz and thus will not require the mode
for frequency > 1GHz.
At the DCO location, we have the bypass_clksel, so the code will have to take care of that.

31:24 DPLL_SD_DIV
23    DPLL_BYP_CLKSEL
19:8  DPLL_MULT
7:0   DPLL_DIV


Regards,
Benoit


>> > - One thing that is confusing is that the 3630 Rev A TRM (SWPU176A)
>> > conflicts with the 34xx-36xx Delta TRM (SWPU204).  For example, the
>delta
>> > TRM claims that the FREQSEL bits are all removed, but the 3630 TRM
>claims
>> > that they are still present.  Could you find out which one is correct?
>If
>> > no FREQSEL bits are present, then the clock code shouldn't write to
>them.
>> >
>>
>> 3630 TRM (Rev A) shows that FREQSEL is no longer present for Per DPLL
>> (CM_CLKEN_PLL [23:20] is reserved). So we should not write freqsel for
>> PER dpll.
>
>Okay.  Could you please update the patch to that effect?
>
>Also, the other part of the question is that the delta TRM claims that
>none of the other DPLLs have FREQSEL bits either.  If that's true, then
>please update the patch to avoid programming FREQSEL bits for all DPLLs on
>3630.
>
>> > - Table 3-13 in the delta TRM claims that the DPLL4 multiplier bitfield
>> > can now go to 4096.  [This looks like an off-by-one error in the
>> > documentation, since only 12 bits are available, so the max is (2^12 -
>1)
>> > = 4095.]  But the important point for this patch is that the struct
>> > dpll_data.max_multiplier field for DPLL4 needs to be increased.
>>
>> I confirmed that DPLL4 Multiplier is 12 bits. So max value is 4095.
>
>OK.  I just realized that you put the 12 bit value in a different patch...
>
>
>- Paul
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

