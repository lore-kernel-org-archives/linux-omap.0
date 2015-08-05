From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] usb: musb: omap2430: use *syscon* framework API to write
 to mailbox register
Date: Wed, 5 Aug 2015 19:20:03 +0530
Message-ID: <55C2148B.4020707@ti.com>
References: <1438697169-32359-1-git-send-email-kishon@ti.com> <20150804155803.GF23659@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150804155803.GF23659@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 04 August 2015 09:28 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Aug 04, 2015 at 07:36:09PM +0530, Kishon Vijay Abraham I wrote:
>> Deprecate using phy-omap-control driver to write to the mailbox register
>> and start using *syscon* framework to do the same.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/usb/omap-usb.txt |    7 +-
>>  drivers/usb/musb/omap2430.c                        |  115 ++++++++++++++++----
>>  2 files changed, 99 insertions(+), 23 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
>> index 38d9bb8..c001306 100644
>> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
>> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
>> @@ -20,10 +20,15 @@ OMAP MUSB GLUE
>>   - phy-names : the names of the PHY corresponding to the PHYs present in the
>>     *phy* phandle.
>>  
>> -Optional properties:
>> +Optional Properties:
>> +Deprecated properties:
>>   - ctrl-module : phandle of the control module this glue uses to write to
>>     mailbox
>>  
>> +Recommended properies:
>> + - syscon-otghs : phandle/offset pair. Phandle to the system control module and the
>> +   register offset of the mailbox.
>> +
>>  SOC specific device node entry
>>  usb_otg_hs: usb_otg_hs@4a0ab000 {
>>  	compatible = "ti,omap4-musb";
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>> index 70f2b8a..a03cf1e 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -39,16 +39,27 @@
>>  #include <linux/usb/musb-omap.h>
>>  #include <linux/phy/omap_control_phy.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>>  
>>  #include "musb_core.h"
>>  #include "omap2430.h"
>>  
>> +#define OMAP2430_MUSB_MODE_MASK	0x1f
>> +#define OMAP2430_MUSB_AVALID	BIT(0)
>> +#define OMAP2430_MUSB_BVALID	BIT(1)
>> +#define OMAP2430_MUSB_VBUSVALID	BIT(2)
>> +#define OMAP2430_MUSB_SESSEND	BIT(3)
>> +#define OMAP2430_MUSB_IDDIG	BIT(4)
>> +
>>  struct omap2430_glue {
>>  	struct device		*dev;
>>  	struct platform_device	*musb;
>>  	enum omap_musb_vbus_id_status status;
>>  	struct work_struct	omap_musb_mailbox_work;
>>  	struct device		*control_otghs;
>> +	struct regmap		*syscon_otghs; /* ctrl. reg. acces */
>> +	unsigned int            otghs_reg; /* otghs reg. index within syscon */
>>  };
>>  #define glue_to_musb(g)		platform_get_drvdata(g->musb)
>>  
>> @@ -253,6 +264,44 @@ void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
>>  }
>>  EXPORT_SYMBOL_GPL(omap_musb_mailbox);
>>  
>> +static void omap2430_musb_set_usbmode(struct omap2430_glue *glue,
>> +				      enum omap_control_usb_mode mode)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
> 
> 	if (!glue->syscon_otghs) {
> 		omap_control_usb_set_mode(glue->control_otghs, mode);
> 		return;
> 	}
> 
> 	switch (mode) {
> 	case USB_MODE_HOST:
> 		val = OMAP2430_MUSB_AVALID | OMAP2430_MUSB_VBUSVALID;
> 		break;
> 	case USB_MODE_DEVICE:
> 		val = OMAP2430_MUSB_IDDIG | OMAP2430_MUSB_AVALID |
> 			OMAP2430_MUSB_VBUSVALID;
> 		break;
> 	case USB_MODE_DISCONNECT:
> 		val = OMAP2430_MUSB_IDDIG | OMAP2430_MUSB_SESSEND;
> 		break;
> 	default:
> 		dev_dbg(glue->dev, "Invalid mode\n");
> 		dev_err(glue->dev, "Failed to set mode to %d\n", mode);

Don't we have to return here? Maybe we should set IDDIG and SESSEND (the same
value as USB_MODE_DISCONNECT). That seems to be the reset value as well.
> 	}
> 
> 	ret = regmap_update_bits(glue->syscon_otghs,
> 				 glue->otghs_reg,
> 				 OMAP2430_MUSB_MODE_MASK, val);
> 	if (ret < 0)
> 		dev_err(glue->dev, "Failed to update regmap\n");

Thanks
Kishon
