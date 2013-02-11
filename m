From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 07/14] USB: ohci-omap3: Add device tree support and
 binding information
Date: Mon, 11 Feb 2013 17:22:15 +0200
Message-ID: <51190CA7.7010705@ti.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com> <1360252974-7912-8-git-send-email-rogerq@ti.com> <20130211114611.GB2726@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130211114611.GB2726@e106331-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "balbi@ti.com" <balbi@ti.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "kishon@ti.com" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 02/11/2013 01:46 PM, Mark Rutland wrote:
> On Thu, Feb 07, 2013 at 04:02:47PM +0000, Roger Quadros wrote:
>> Allows the OHCI controller found in OMAP3 and later chips to
>> be specified via device tree.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> ---
>>  .../devicetree/bindings/usb/omap3-ohci.txt         |   17 +++++++++++++++++
>>  drivers/usb/host/ohci-omap3.c                      |   19 +++++++++++++++++++
>>  2 files changed, 36 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/omap3-ohci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/omap3-ohci.txt b/Documentation/devicetree/bindings/usb/omap3-ohci.txt
>> new file mode 100644
>> index 0000000..ad2ace0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/omap3-ohci.txt
>> @@ -0,0 +1,17 @@
>> +OMAP HS USB OHCI controller (OMAP3 and later)
>> +
>> +Required properties:
>> +
>> +- compatible: should be "ti,ohci-omap3"
>> +- reg: should contain one register range i.e. start and length
>> +- interrupt-parent: phandle to the interrupt controller
> 
> I'm not sure that needs to be documented as a required property. It's a
> standard property, and if it's defined for the parent node, you won't need it
> here.

The last time I tried without 'interrupt-parent' it complained. Doesn't do it anymore.
Maybe I did something wrong the last time. I'll remove it.

> 
> Otherwise, this looks fine to me.

Thanks. I'll add your reviewed-by tag after addressing the above comment.

cheers,
-roger
