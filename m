From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 2/6] ARM: OMAP: USB: Add phy binding information
Date: Thu, 17 Jan 2013 18:01:31 +0530
Message-ID: <50F7EF23.8080903@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-3-git-send-email-kishon@ti.com>
 <CAFp+6iGEC9KgfuQz6nqnAY5JrmtPG=HkGw5yjKw7-1=8AG_=dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAFp+6iGEC9KgfuQz6nqnAY5JrmtPG=HkGw5yjKw7-1=8AG_=dg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 17 January 2013 05:41 PM, Vivek Gautam wrote:
> Hi Kishon,
>
>
> On Wed, Jan 16, 2013 at 8:30 PM, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
>> This is in preparation for the changes in PHY library to support adding
>> and getting multiple PHYs of the same type. In the new design, the
>> binding information between the PHY and the USB controller should be
>> specified in the platform specific initialization code. So it's been
>> done for OMAP platforms here.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>> This kind-of binding should be done in all the platforms (I've done only
>> for OMAP platform).
>>   arch/arm/mach-omap2/usb-musb.c |    7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
>> index 9d27e3f..bbe2fa5 100644
>> --- a/arch/arm/mach-omap2/usb-musb.c
>> +++ b/arch/arm/mach-omap2/usb-musb.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/dma-mapping.h>
>>   #include <linux/io.h>
>>   #include <linux/usb/musb.h>
>> +#include <linux/usb/phy.h>
>>
>>   #include "omap_device.h"
>>   #include "soc.h"
>> @@ -85,8 +86,12 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
>>          musb_plat.mode = board_data->mode;
>>          musb_plat.extvbus = board_data->extvbus;
>>
>> -       if (cpu_is_omap44xx())
>> +       if (cpu_is_omap44xx()) {
>>                  musb_plat.has_mailbox = true;
>> +               usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto");
>> +       } else if (cpu_is_omap34xx()) {
>> +               usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
>> +       }
>
> Just trying to understand things here.
> Is the device name we are using here the platform device name (pdev->name) ?

it's pdev->dev.name.
> If i am not wrong then for devices added through device tree
> the device name would actually include the device address in the string,

Ideally for device tree, devm_usb_get_phy_by_phandle() introduced in the 
5th patch of this series should be used.
usb_bind_phy should be called from platform specific initialization 
files (like your board file), which won't get executed in dt boot.
> wouldn't that make things somewhat weird, since we will have to add
> such bindings
> using this address string.
>
> one more doubt please :)
> is it possible to bind phy in the controllers' driver somehow ?
Thats not going to be good. Why do you need to do that?

Thanks
Kishon
