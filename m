From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/3] ARM: dts: EMIF and LPDDR2 device tree data for OMAP5
 boards
Date: Thu, 11 Oct 2012 13:45:00 +0530
Message-ID: <50768004.80503@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com> <1349870716-25511-4-git-send-email-lokeshvutla@ti.com> <50758DC7.3070408@ti.com> <5076644A.10504@ti.com> <50767F42.9000807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49161 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab2JKIPO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 04:15:14 -0400
In-Reply-To: <50767F42.9000807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Thursday 11 October 2012 01:41 PM, Benoit Cousson wrote:
> Hi Lokesh,
>
> On 10/11/2012 08:16 AM, Lokesh Vutla wrote:
>> + devicetree-discuss
>>
>> Hi Benoit,
>>
>> On Wednesday 10 October 2012 08:31 PM, Benoit Cousson wrote:
>>> On 10/10/2012 02:05 PM, Lokesh Vutla wrote:
>>>> Device tree data for the EMIF sdram controllers in OMAP5
>>>> and LPDDR2 memory devices attached to OMAP5 boards.
>>>
>>> Nit: Could you make a sentence with a verb to explain what you are doing
>>> in this patch.
>> I am really sorry about this.
>> I ll make sure that all patch descriptions will be clear in V2 of this
>> patch series.
>>
>> In this patch I am adding device tree data for LPDDR2 memory devices
>> attached to omap5-sevm and also adding device tree data for EMIF sdram
>> controllers in OMAP5.
>>>
>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>> ---
>>>>    arch/arm/boot/dts/lpddr2_data.dtsi |   64
>>>> +++++++++++++++++++++++++++++++++++-
>>>>    arch/arm/boot/dts/omap5-evm.dts    |   11 +++++++
>>>>    arch/arm/boot/dts/omap5.dtsi       |   18 ++++++++++
>>>>    3 files changed, 92 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/lpddr2_data.dtsi
>>>> b/arch/arm/boot/dts/lpddr2_data.dtsi
>>>> index f97f70f..8e8c1bc 100644
>>>> --- a/arch/arm/boot/dts/lpddr2_data.dtsi
>>>> +++ b/arch/arm/boot/dts/lpddr2_data.dtsi
>>>> @@ -3,7 +3,7 @@
>>>>     */
>>>>
>>>>    / {
>>>> -    elpida_ECB240ABACN: lpddr2 {
>>>> +    elpida_ECB240ABACN: lpddr2@0 {
>>>>            compatible    = "Elpida,ECB240ABACN","jedec,lpddr2-s4";
>>>>            density        = <2048>;
>>>>            io-width    = <32>;
>>>> @@ -64,4 +64,66 @@
>>>>                tDQSCK-max-derated = <6000>;
>>>>            };
>>>>        };
>>>> +
>>>> +    samsung_K3PE0E000B: lpddr2@1 {
>>>
>>> I'm confused now, why are you reusing the same lpddr2_data.dtsi file?
>>> You should create a file per memory. That will make the reuse much
>>> easier.
>>>
>>> If the goal of your first patch was to do that, it is then the wrong
>>> approach.
>> Yes, I wanted to group data for all lppdr2 devices in a single file than
>> creating separate file for each device.
>> May be a dumb question, Why can't we group data for all the lpddr2
>> devices in a single file?
>
> Well, why should we do that? What will be the advantage?
>
> That will increase the size of the DTS/DTB with data nobody will care if
> only one type of memory is used on a given platform.
>
> Going in the same direction you can consider adding every OMAP
> description into a single DTS... Does that really make sense?
>
> So clearly there is no point doing that, it will cluttered the OMAP4 DTB
> with useless Samsung memory data. And the same issue for OMAP5 board
> that will contain Elpida memory information. And it will get worst each
> time someone will want to add a new memory in this file.
>
> You should just include the data you need for a given board.
>
I agree with Benoit. Keeping the memory data files separate will be
better and also if some non-omap boards is using the memory parts,
the separate files can be re-used.

Regards
Santosh



