From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: omap5-uevm: Add USB Host support
Date: Fri, 7 Jun 2013 11:38:00 +0530
Message-ID: <51B178C0.1040901@ti.com>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com> <1370414770-1485-3-git-send-email-r.sricharan@ti.com> <20130605135739.GA11193@kahuna> <51B0CC15.6010809@ti.com> <20130606184617.GA25579@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41243 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab3FGGI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 02:08:28 -0400
In-Reply-To: <20130606184617.GA25579@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Roger Quadros <rogerq@ti.com>

On Friday 07 June 2013 12:16 AM, Nishanth Menon wrote:
> On 23:21-20130606, Sricharan R wrote:
>> Hi,
>> On Wednesday 05 June 2013 07:27 PM, Nishanth Menon wrote:
>>> On 12:16-20130605, Sricharan R wrote:
>>>> From: Roger Quadros <rogerq@ti.com>
>>> [...]
>>>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>>>> index 843a001..cf862df 100644
>>>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>>>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>>> <snip>
>>>> +	/* hsusb2_phy is clocked by FREF_CLK1 i.e. auxclk1 */
>>>> +	clock_alias {
>>>> +		clock-name = "auxclk1_ck";
>>>> +		clock-alias = "main_clk";
>>> is'nt this better to use with clock node?
>> Roger was suggesting to remove this for now. Postedhen 
>> V2 following that.
>> Are you suggesting to go with your clock-binding patch ?
> you cannot. Mike has already rejected that approach and I have dropped
> that series and wont be following up.
> See discussion https://patchwork.kernel.org/patch/2541331/
>
> instead the new approach being discussed
> https://patchwork.kernel.org/patch/2657351/ and related discussions is
> the way to go.
>
> That said, it practically blocks introduction of all code that depend on
> dts nodes :(, no matter how I dont like being blocked and my many series
> delayed, I believe Mike, Tero, Rajendra are doing the right architecture
> and we should wait for it's upstream introduction.
>
> That is just my 2 cents.
>
 Thanks for the details. So dropping the alias for now, should be fine.
 
Regards,
 Sricharan

