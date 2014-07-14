From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v4 05/11] Documentation: dt: add ti,am3353_wkup_m3 bindings
Date: Mon, 14 Jul 2014 12:45:43 -0500
Message-ID: <53C41747.2020006@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com> <1405047349-15101-6-git-send-email-d-gerlach@ti.com> <53C3EC18.70506@ti.com> <53C40651.6030401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50640 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbaGNRqF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jul 2014 13:46:05 -0400
In-Reply-To: <53C40651.6030401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Daniel Mack <daniel@zonque.org>, Benoit Cousson <bcousson@baylibre.com>, Ohad Ben-Cohen <ohad@wizery.com>

Santosh, Suman,

On 07/14/2014 11:33 AM, Suman Anna wrote:
> Hi Dave,
>
> On 07/14/2014 09:41 AM, Santosh Shilimkar wrote:
>> On Thursday 10 July 2014 10:55 PM, Dave Gerlach wrote:
>>> Add the device tree bindings document for am3353 wkup_m3.
>>>
>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>> CC: Ohad Ben-Cohen <ohad@wizery.com>
>>> CC: Benoit Cousson <bcousson@baylibre.com>
>>> ---
>> Looks like you missed to copy device tree list and maintainers.
>> As Tony suggested, split up the series and send the wkup_m3 related
>> patches separately along with bindings and mark the DT folks on email.

Yes I did, I will fix this when I resend the split up series. Thanks.

>>
>>>   .../bindings/remoteproc/wkup_m3_rproc.txt          | 46 ++++++++++++++++++++++
>>>   1 file changed, 46 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt b/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
>>> new file mode 100644
>>> index 0000000..e9dd909
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
>>> @@ -0,0 +1,46 @@
>>> +Wakeup M3 Remote Proc Driver
>>> +=====================
>>> +
>>> +TI AMx3 Family devices use a Cortex M3 co-processor to help with various
>>> +low power tasks that cannot be controlled from the MPU. The CM3 requires
>>> +a firmware binary to accomplish this and communicates with the MPU through
>>> +IPC registers present in the SoCs control module. The wkup_m3 remoteproc
>>> +driver handles the loading of the firmware and exposes an API to
>>> +communicate with the wkup_m3 through the use of the IPC registers and a
>>> +mailbox.
>>> +
>>> +Wkup M3 Device Node:
>>> +====================
>>> +A wkup_m3 device node is used to represent a wakeup M3 IP instance within
>>> +a SoC. The sub-mailboxes are represented as child node of this parent node.
>>> +
>>> +Required properties:
>>> +--------------------
>>> +- compatible:		Should be "ti,am3353-wkup-m3" for AM33xx SoCs
>>> +- reg:			Contains the wkup_m3 register address ranges for
>>> +			umem, dmem, and ipc-regs.
>>> +- reg-names:		Names for reg addresses given above
>
> You should explicitly state the names here. Giving any different names
> will cause the driver to fail.

Alright I will move the names from the item above and add some details.

>
>>> +- interrupts:		Contains the interrupt information for the wkup_m3
>>> +			interrupt that signals the MPU.
>>> +- ti,hwmods:		Name of the hwmod associated with the mailbox
>
> hwmod is not associated with mailbox here, please fix the cut-copy-paste
> error.

Yep that's my bad, sorry about that.

Regards,
Dave

>
> regards
> Suman
>
>
>>> +- ti,no-reset-on-init:	Reset is handled after fw has been loaded, not at
>>> +			init of hwmod.
>>> +- mbox-names:		Name of the mbox channel for the IPC framework
>>> +- mbox:			Phandle used by IPC framework to get correct mbox
>>> +			channel for communication.
>>> +
>>> +Example:
>>> +--------
>>> +/* AM33xx */
>>> +wkup_m3: wkup_m3@44d00000 {
>>> +	compatible = "ti,am3353-wkup-m3";
>>> +	reg = <0x44d00000 0x4000
>>> +	       0x44d80000 0x2000
>>> +	       0x44e11324 0x0024>;
>>> +	reg-names = "m3_umem", "m3_dmem", "ipc_regs";
>>> +	interrupts = <78>;
>>> +	ti,hwmods = "wkup_m3";
>>> +	ti,no-reset-on-init;
>>> +	mbox-names = "wkup_m3";
>>> +	mbox = <&mailbox &mbox_wkupm3>;
>>> +};
>>>
>>
>

