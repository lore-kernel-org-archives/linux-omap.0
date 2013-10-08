From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: omap3-beagle: use 3630 definitions
Date: Tue, 8 Oct 2013 13:01:26 -0500
Message-ID: <52544876.8000904@ti.com>
References: <523C9D8B.2000701@ti.com> <1381164584-4008-1-git-send-email-nm@ti.com> <1381164584-4008-3-git-send-email-nm@ti.com> <20131007192009.GA8949@atomide.com> <20131008174721.GH13128@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46207 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab3JHSBt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 14:01:49 -0400
In-Reply-To: <20131008174721.GH13128@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Tony Lindgren <tony@atomide.com>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/08/2013 12:47 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Oct 07, 2013 at 12:20:09PM -0700, Tony Lindgren wrote:
>> * Nishanth Menon <nm@ti.com> [131007 09:57]:
>>> beagle-xm currently would matchup with ti,omap3 which invokes
>>> omap3430_init_early instead of omap3630_init_early. So add
>>> compatiblity for 3630 to allow match
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>  arch/arm/boot/dts/omap3-beagle-xm.dts |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
>>> index 0f7cfc5..2079e22 100644
>>> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
>>> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
>>> @@ -11,7 +11,7 @@
>>>  
>>>  / {
>>>  	model = "TI OMAP3 BeagleBoard xM";
>>> -	compatible = "ti,omap3-beagle-xm", "ti,omap3-beagle", "ti,omap3";
>>> +	compatible = "ti,omap3-beagle-xm", "ti,omap363x", "ti,omap3-beagle", "ti,omap3";
>>>  
>>>  	cpus {
>>>  		cpu@0 {
>>
>> This compatible string looks hacky.. How about just make it
>>
>> "ti,omap3-beagle-xm", "ti,omap363x", "ti,omap3";
>>
>> How about just leave out "ti,omap3-beagle" here?
> 
> ti,omap3-beagle was already part of the original file, we can definitely
> remove but I'd expect us to maintain support for that string
> indefinitely should anybody continue to use older dtbs.
> 
it already is supported (we still have a beagleboard) - the current
patch rev does nothing to break existing code or bindings.

-- 
Regards,
Nishanth Menon
