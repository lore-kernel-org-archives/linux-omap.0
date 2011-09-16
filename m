From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 04/11] omap4: SDP: Pass regulator_init_data from DT
Date: Fri, 16 Sep 2011 14:56:24 +0530
Message-ID: <4E731640.2080304@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com> <1316085727-15023-2-git-send-email-rnayak@ti.com> <1316085727-15023-3-git-send-email-rnayak@ti.com> <1316085727-15023-4-git-send-email-rnayak@ti.com> <1316085727-15023-5-git-send-email-rnayak@ti.com> <20110915134618.GK7988@opensource.wolfsonmicro.com> <4E72F7F1.9060703@ti.com> <20110916090026.GD22062@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38555 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751719Ab1IPJ0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 05:26:31 -0400
Received: by mail-gy0-f176.google.com with SMTP id 15so3404058gyc.7
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 02:26:30 -0700 (PDT)
In-Reply-To: <20110916090026.GD22062@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Friday 16 September 2011 02:30 PM, Mark Brown wrote:
> On Fri, Sep 16, 2011 at 12:47:05PM +0530, Rajendra Nayak wrote:
>> On Thursday 15 September 2011 07:16 PM, Mark Brown wrote:
>>> On Thu, Sep 15, 2011 at 04:52:00PM +0530, Rajendra Nayak wrote:
>
>>>> +Required properties:
>>>> +- compatible: Must be "regulator","ti,twl-reg";
>
>>> I'd expect listings for the specific chips too.
>
>> I just did'nt do that because we have just one driver for
>> all twl chips (twl4030/twl6030/twl6025) and there seems to be
>> no real need to identify specific chips while we could
>> do knowing just the chip family.
>
> The driver can bind to as many names as it likes.

makes sense, I'll add one per chip variant.

>
>>>> +	xyz-regulator: regulator@0 {
>>>> +		compatible = "regulator","ti,twl-reg";
>>>> +		ti,reg-id =<37>; /* TWL6030_REG_VAUX1_6030 */
>
>>> These magic numbers are *very* Linux specific, we should have a better
>>> way of specifying regulators - I'd off the top of my head expect that
>>> the compatible property would identify the regulator.
>
>> The driver seems to use a per-regulator table, and it uses the above
>> id to indexed into it. I could probably do it with the compatible
>
> I know what the driver is doing, the problem is that it's very much
> specific to Linux (and Linux may change the numbers at some point).
>
>> property, but that would mean I have a compatible for *each* regulator
>> instance, like "ti,twl-reg-vaux1", "ti,twl-reg-vmmc" etc.
>> Does that sound reasonable?
>
> Yes.

