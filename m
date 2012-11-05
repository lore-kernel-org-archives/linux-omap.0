From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
Date: Mon, 5 Nov 2012 20:28:50 +0530
Message-ID: <5097D42A.1040207@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com> <50953E26.40906@ti.com> <B5906170F1614E41A8A28DE3B8D121433EBFFD0A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34804 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251Ab2KEO6z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 09:58:55 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBFFD0A@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Sunday 04 November 2012 08:56 PM, Bedia, Vaibhav wrote:
> On Sat, Nov 03, 2012 at 21:24:14, Shilimkar, Santosh wrote:
>> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>> ---
>>>    arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
>>>    1 files changed, 11 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>>> index bb31bff..e2cbf24 100644
>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>> @@ -210,5 +210,16 @@
>>>    			interrupt-parent = <&intc>;
>>>    			interrupts = <91>;
>>>    		};
>>> +
>>> +		ocmcram: ocmcram@40300000 {
>>> +			compatible = "ti,ocmcram";
>>> +			ti,hwmods = "ocmcram";
>>> +			ti,no_idle_on_suspend;
>>> +		};
>> Whats the intention behind adding OCMRAM ?
>> Sorry if I missed any comments from the cover letter ?
>>
>
> We need a mechanism to ensure that the clock to OCMC is kept running
> during boot and that it doesn't get disabled as part of the suspend
> sequence. Since the hwmod data for OCMC is already present and we have
> the no_idle_on_suspend flag for hwmod entries we get the desired behavior.
>
> This could also have been done via the clock tree but looks like we
> want to avoid adding leaf nodes in the clock data, hence the hwmod +
> DT approach.
>
OK. I was just comparing the OCMC RAM on OMAP which is always
clocked and hence didn't need any of the above.

Regards
Santosh

