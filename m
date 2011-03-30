From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Wed, 30 Mar 2011 14:12:17 +0200
Message-ID: <4D931E21.8090305@ti.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com> <1301483027.4045.16.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58752 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634Ab1C3MM2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 08:12:28 -0400
In-Reply-To: <1301483027.4045.16.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 3/30/2011 1:03 PM, Valkeinen, Tomi wrote:
> On Wed, 2011-03-30 at 11:32 +0200, Cousson, Benoit wrote:
>> Hi Tomi,
>>
>> On 3/30/2011 8:48 AM, Valkeinen, Tomi wrote:
>>> Hi Benoit, Paul,
>>>
>>> I've been discussing with Sumit and Archit to understand how the DSS
>>> clocks are set up on OMAP4. I think I now have some idea how things
>>> work, but I'm still at loss why things are the way they are.
>>>
>>> So, if I look at OMAP4 TRM, Figure 10-4 DSS Clock Tree, there are two
>>> clocks in PRCM block that are relevant to this discussion: DSS_L3_ICLK
>>> and DSS_FCLK. To my understanding DSS_L3_ICLK is not really
>>> controllable, but it is affected by MODULEMODE bit.
>>>
>>> Then we have two relevant clocks defined in clock44xx_data.c: dss_fck
>>> and dss_dss_clk. dss_fck controls the MODULEMODE bit, and dss_dss_clk is
>>> the TRM's DSS_FCLK.
>>>
>>> Was that correct?
>>
>> Yes. For the moment, but this is not the final state.
>>
>>> If so, from DSS driver's perspective, the dss_fck sounds very much like
>>> an interface clock (it's always needed when DSS is used) and dss_dss_clk
>>> sounds very much like functional clock (it's always needed, except if
>>> DSI PLL is used for DSS functional clock).

dss_dss_fck is one of the possible functional clocks, hence the optional 
attribute. You can run the DSS only for sys_clk is you want.
That's why the hwmod fmwk cannot choose for you which one you will need 
depending of your panel. It is up to the driver to select the correct one.

>>> If "dss_fck" would control DSS_FCLK and "dss_ick" would control
>>> MODULEMODE, they would be about the same as the clocks in OMAP2 and 3,
>>> and we wouldn't need any omap4 spesific trickery in the DSS driver.
>>> ("dss_dss_clk" wouldn't be needed).
>>
>> You cannot play with iclk, because this clock is supposed to be handled
>> automatically by the HW. This was the case on OMAP2&  3 as well BTW.
>
> Right.
>
> But now we have 1) dss_fck, which isn't the DSS_FCLK in TRM, and in fact
> not fck at all, or even clock at all 2) dss_dss_clk, a new clock whose
> name doesn't match to anything in TRM, and is in fact the DSS_FCLK.
>
> So they both sound like they are confusingly named.

The naming convention is simple: opt clock are using the module name + 
the original clock name: "dss_XXX", whereas the modulemode is using the 
module name + fck, because it is for the moment similar to the fclk we 
have on simpler module. iclk_en is not exposed at all on OMAP4.

optional clocks:

static struct clk dss_sys_clk = {
	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
	.enable_bit	= OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT,

static struct clk dss_tv_clk = {
	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
	.enable_bit	= OMAP4430_OPTFCLKEN_TV_CLK_SHIFT,

static struct clk dss_dss_clk = {
	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
	.enable_bit	= OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,

static struct clk dss_48mhz_clk = {
	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
	.enable_bit	= OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT,


MODULEMODE:

static struct clk dss_fck = {
	.enable_reg	= OMAP4430_CM_DSS_DSS_CLKCTRL,
	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,

> If we had dss_fck matching to DSS_FCLK and dss_ick for MODULEMODE, they
> would, in my opinion, be much more understandable and in many ways
> relate to the way things are in the HW. Additionally this would match
> the way clocks are on OMAP2/3 and things would just work.

No, because you should not have to play with iclk at all.
BTW, for my point of view you have such issue because your are still not 
using the pm_runtime API.
As soon as you will switch to pm_runtime, iclk_en and fclk_en (OMAP2&3 
name) or MODULEMODE will be handle by the fmwk. The driver will just 
have to handle the optional clock.

> So while I understand that neither the current way and my suggestion
> exactly match the HW, and also that things are not ready yet and the
> clocks will change, I don't understand why such a strange method to name
> the clocks was used, when there's a simpler and backward compatible way.

The point is that this automated method works for every IPs in the OMAP 
except the DSS that is not managing its clocks like other modules.
Moreover, since the clock fmwk is creating aliases for these clock 
nodes, you should never see at all that dss_dss_clk node that seems to 
bother you.

> And if this current way to handle OMAP4 DSS clocks is for some reason
> better and can't be changed, could the OMAP2/3 clocks also be changed to
> keep things consistent between OMAPs? Because the inconsistency between
> platforms is the biggest problem for me.

As I said previsously, pm_runtime should fix these issues.

Benoit

