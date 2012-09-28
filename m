From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/6] usb: dwc3-omap: Add an API to write to dwc mailbox
Date: Fri, 28 Sep 2012 19:01:48 +0530
Message-ID: <CAAe_U6+invzzr12x7Shb-uBZfW1Tv3MpR3s0tE8ZUauH6wF-tQ@mail.gmail.com>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
 <1348836795-4783-5-git-send-email-kishon@ti.com>
 <20120928125929.GM31006@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120928125929.GM31006-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
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
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 28, 2012 at 6:29 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Fri, Sep 28, 2012 at 06:23:13PM +0530, Kishon Vijay Abraham I wrote:
>> Add an API in the omap glue layer to write to the mailbox register which
>> can be used by comparator driver(twl). To pass the detection of the attached
>> device (signified by VBUS, ID) to the dwc3 core, dwc3 core has to write
>> to the mailbox regiter.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/usb/dwc3/dwc3-omap.c  |   59 +++++++++++++++++++++++++++++++++++++++++
>>  include/linux/usb/dwc3-omap.h |   30 +++++++++++++++++++++
>>  2 files changed, 89 insertions(+)
>>  create mode 100644 include/linux/usb/dwc3-omap.h
>>
>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>> index a1704c6..7ae4d73 100644
>> --- a/drivers/usb/dwc3/dwc3-omap.c
>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>> @@ -43,6 +43,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/platform_data/dwc3-omap.h>
>> +#include <linux/usb/dwc3-omap.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/ioport.h>
>> @@ -126,6 +127,8 @@ struct dwc3_omap {
>>       u32                     dma_status:1;
>>  };
>>
>> +struct dwc3_omap             *_omap;
>> +
>>  static inline u32 dwc3_omap_readl(void __iomem *base, u32 offset)
>>  {
>>       return readl(base + offset);
>> @@ -136,6 +139,56 @@ static inline void dwc3_omap_writel(void __iomem *base, u32 offset, u32 value)
>>       writel(value, base + offset);
>>  }
>>
>> +void omap_dwc3_mailbox(enum omap_dwc3_vbus_id_status status)
>
> all other functions are "dwc3_omap_", let's keep it consistent.

Sure.

Thanks
Kishon
