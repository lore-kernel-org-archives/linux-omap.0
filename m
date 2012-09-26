From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] usb: phy: omap-usb2: enable 960Mhz clock for omap5
Date: Wed, 26 Sep 2012 11:10:48 +0530
Message-ID: <CAAe_U6Kr8t1=T7MGMjAe+1n6S-NncypnPkXYqA2_FtVK=uxULA@mail.gmail.com>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-5-git-send-email-kishon@ti.com>
 <20120919115647.GI3772@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120919115647.GI3772-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 19, 2012 at 5:26 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Wed, Sep 19, 2012 at 05:00:29PM +0530, Kishon Vijay Abraham I wrote:
>> "usb_otg_ss_refclk960m" is needed by usb2 phy present in omap5. For
>> omap4, the clk_get of this clock will fail since it does not have this
>> clock.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/usb/usb-phy.txt |    3 +++
>>  drivers/usb/phy/omap-usb2.c                       |   28 ++++++++++++++++++++-
>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/usb/usb-phy.txt
>> index 7c5fd89..d5626de 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-phy.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-phy.txt
>> @@ -24,6 +24,9 @@ Required properties:
>>  add the address of control module phy power register until a driver for
>>  control module is added
>>
>> +Optional properties:
>> + - has960mhzclk: should be added if the phy needs 960mhz clock
>> +
>>  This is usually a subnode of ocp2scp to which it is connected.
>>
>>  usb3phy@4a084400 {
>> diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
>> index d36c282..d6612ba 100644
>> --- a/drivers/usb/phy/omap-usb2.c
>> +++ b/drivers/usb/phy/omap-usb2.c
>> @@ -146,6 +146,7 @@ static int __devinit omap_usb2_probe(struct platform_device *pdev)
>>       struct omap_usb                 *phy;
>>       struct usb_otg                  *otg;
>>       struct resource                 *res;
>> +     struct device_node              *np = pdev->dev.of_node;
>>
>>       phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
>>       if (!phy) {
>> @@ -190,6 +191,15 @@ static int __devinit omap_usb2_probe(struct platform_device *pdev)
>>       }
>>       clk_prepare(phy->wkupclk);
>>
>> +     if (of_property_read_bool(np, "has960mhzclk")) {
>> +             phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
>> +             if (IS_ERR(phy->optclk)) {
>> +                     dev_err(&pdev->dev, "unable to get refclk960m\n");
>> +                     return PTR_ERR(phy->optclk);
>> +             }
>> +             clk_prepare(phy->optclk);
>> +     }
>
> instead, can't you just always try to get the clock but ignore the error
> if it fails ?

This clock is needed for usb2 to work in dwc3 (omap5). So we have to
report the error in case we dont get the clock no?

Thanks
Kishon
