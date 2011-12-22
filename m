From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 02/11] i2c: OMAP: Add DT support for i2c controller
Date: Thu, 22 Dec 2011 15:01:40 +0100
Message-ID: <4EF33844.5080105@ti.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
 <1324398444-23296-3-git-send-email-b-cousson@ti.com>
 <CAOesGMiwg9gVDDwCjuCcAPX6hc2E6OgH-c_nAqhCHmj7y5oCeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAOesGMiwg9gVDDwCjuCcAPX6hc2E6OgH-c_nAqhCHmj7y5oCeQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Olof,

On 12/20/2011 10:24 PM, Olof Johansson wrote:
> Hi,
>
> On Tue, Dec 20, 2011 at 8:27 AM, Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>  wrote:
>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index a43d002..dcbc1ec 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -37,6 +37,8 @@
>>   #include<linux/platform_device.h>
>>   #include<linux/clk.h>
>>   #include<linux/io.h>
>> +#include<linux/of_i2c.h>
>> +#include<linux/of_device.h>
>>   #include<linux/slab.h>
>>   #include<linux/i2c-omap.h>
>>   #include<linux/pm_runtime.h>
> [...]
>> @@ -1165,6 +1195,7 @@ static struct platform_driver omap_i2c_driver = {
>>                 .name   = "omap_i2c",
>>                 .owner  = THIS_MODULE,
>>                 .pm     = OMAP_I2C_PM_OPS,
>> +               .of_match_table = of_match_ptr(omap_i2c_of_match),
>>         },
>>   };
>
> of_match_ptr() comes from<linux/of.h>, so you need to include that to
> not break !CONFIG_OF builds.

Good point, I'll fix that.

Thanks,
Benoit
