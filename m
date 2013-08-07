From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 2/8] mailbox/omap: add support for parsing dt devices
Date: Wed, 7 Aug 2013 15:08:07 -0500
Message-ID: <5202A927.4030708@ti.com>
References: <1375825216-18119-1-git-send-email-s-anna@ti.com>
 <BB39592C-0DAC-49A4-A782-583D7EB858AF@codeaurora.org>
 <52027CDC.8080205@ti.com>
 <FF52B913-A5AB-4516-BDA6-ED0BCFFBD4D1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <FF52B913-A5AB-4516-BDA6-ED0BCFFBD4D1@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Jassi Brar <jaswinder.singh@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/07/2013 12:41 PM, Kumar Gala wrote:
> 
> On Aug 7, 2013, at 11:59 AM, Suman Anna wrote:
> 
>> Kumar,
>>
>>>> Logic has been added to the OMAP2+ mailbox code to
>>>> parse the mailbox dt nodes and construct the different
>>>> mailboxes associated with the instance. The design is
>>>> based on gathering the same information that was being
>>>> passed previously through the platform data, except for
>>>> the interrupt type configuration information.
>>>>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> ---
>>>> .../devicetree/bindings/mailbox/omap-mailbox.txt   |  43 +++++++
>>>> drivers/mailbox/mailbox-omap2.c                    | 130 ++++++++++++++++++---
>>>> 2 files changed, 158 insertions(+), 15 deletions(-)
>>>> create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
>>>> new file mode 100644
>>>> index 0000000..8ffb08a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
>>>> @@ -0,0 +1,43 @@
>>>> +OMAP2+ Mailbox Driver
>>>> +
>>>> +Required properties:
>>>> +- compatible:		Should be one of the following,
>>>> +			    "ti,omap2-mailbox" for
>>>> +				OMAP2420, OMAP2430, OMAP3430, OMAP3630 SoCs
>>>> +			    "ti,omap4-mailbox" for
>>>> +				OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
>>>> +- reg:			Contains the mailbox register address range (base address
>>>> +			and length)
>>>> +- interrupts: 		Contains the interrupt information for the mailbox
>>>> +			device. The format is dependent on which interrupt
>>>> +			controller the OMAP device uses
>>>> +- ti,hwmods:		Name of the hwmod associated with the mailbox
>>>> +- ti,mbox-num-users:	Number of targets (processor devices) that the mailbox device
>>>> +			can interrupt
>>>> +- ti,mbox-num-fifos:	Number of h/w fifos within the mailbox device
>>>
>>> Isn't "ti,mbox-num-users", "ti,mbox-num-fifos" this SoC specific, why do we need to encode in the device tree.  Can we not have a more SoC specific compatiable and encode such info in the driver as part of the .data field in of_device_id ?
>>
>> They are IP design parameters for the number of h/w fifos and interrupts
>> coming out of the IP block, with the functionality identical. This
>> information could not be read from any registers. Until OMAP5, we always
>> had a single IP in the SoC and so these could been encoded in the
>> driver. But in DRA7xx, a new SoC, we have 13 mailboxes which have
>> differing number of these properties even though the functional IP block
>> is same.
> 
> Ah, I see.  Since you've got examples of the same IP with different design params in a given SoC than this makes sense.
> 
> Is that true of ti,mbox-num-users?

Yes, it is true of both "ti,mbox-num-users" and "ti,mbox-num-fifos".

regards
Suman

> 
>>>> +- ti,mbox-names:	Array of the names of the mailboxes
>>>> +- ti,mbox-data:		Mailbox descriptor data private to each mailbox. The 4
>>>> +			cells represent the following data,
>>>> +			  Cell #1 (tx_id) - mailbox fifo id used for
>>>> +						transmitting messages
>>>> +			  Cell #2 (rx_id) - mailbox fifo id on which messages
>>>> +						are received
>>>> +			  Cell #3 (irq_id) - irq identifier index number to use
>>>> +						from the interrupts data
>>>> +			  Cell #4 (usr_id) - mailbox user id for identifying the
>>>> +						interrupt into the MPU interrupt
>>>> +						controller.
>>>> +
>>>
>>> ti,mbox-data really seems like it should be encoded in the driver and not in the device tree.  Is it specific to the SoC?
>>
>> The mbox-data represents the assignment of h/w fifos between a pair of
>> processors on an SoC, so it is specific to a mailbox IP instance in an
>> SoC. Also, this assignment makes it flexible for anyone wishing to use
>> their own firmware/stack on the remote processor side if using different
>> h/w fifo combination.
>>
>> So, a single SoC-specific compatible string would not be enough to
>> identify either of the above data in the driver.
> 
> ok
> 
> - k
> 
>>
>> regards
>> Suman
>>
>>>
>>>> +Example:
>>>> +
>>>> +/* OMAP4 */
>>>> +mailbox: mailbox@4a0f4000 {
>>>> +	compatible = "ti,omap4-mailbox";
>>>> +	reg = <0x4a0f4000 0x200>;
>>>> +	interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>>>> +	ti,hwmods = "mailbox";
>>>> +	ti,mbox-num-users = <3>;
>>>> +	ti,mbox-num-fifos = <8>;
>>>> +	ti,mbox-names = "mbox-ipu", "mbox-dsp";
>>>> +	ti,mbox-data = <0 1 0 0>, <3 2 0 0>;
>>>> +};
>>>
>>> [snip]
>>>
>>> - k
>>>
>>> --
>>> Employee of Qualcomm Innovation Center, Inc.
>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>>>
>>
> 
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
