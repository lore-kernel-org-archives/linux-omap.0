From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC][PATCH 1/2] ARM: OMAP4: clock: Add device tree support for
 AUXCLKs
Date: Thu, 4 Apr 2013 10:35:12 +0300
Message-ID: <515D2D30.3000306@ti.com>
References: <1363703220-4777-1-git-send-email-rogerq@ti.com> <1363703220-4777-2-git-send-email-rogerq@ti.com> <20130403234242.GE10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130403234242.GE10155-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: b-cousson-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 04/04/2013 02:42 AM, Tony Lindgren wrote:
> Hi,
> 
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [130319 07:31]:
>> Register a device tree clock provider for AUX clocks
>> on the OMAP4 SoC. Also provide the binding information.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../devicetree/bindings/clock/omap4-clock.txt      |   32 ++++++++++++++++++
>>  arch/arm/boot/dts/omap4.dtsi                       |    5 +++
>>  arch/arm/mach-omap2/board-generic.c                |    2 +-
>>  arch/arm/mach-omap2/cclock44xx_data.c              |   35 ++++++++++++++++++++
>>  arch/arm/mach-omap2/clock44xx.h                    |    1 +
>>  arch/arm/mach-omap2/common.h                       |    9 +++++
>>  arch/arm/mach-omap2/io.c                           |    6 +++
>>  7 files changed, 89 insertions(+), 1 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/omap4-clock.txt
>>
> ...
> 
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/omap4-clock.txt
> 
> Is this really specific to omap4 and auxclk only?
> 
> Shouldn't it be just omap-clock.txt?

Yes, I've fixed this up in v2 of this patch.

> 
>> --- a/arch/arm/mach-omap2/cclock44xx_data.c
>> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/clk-private.h>
>>  #include <linux/clkdev.h>
>>  #include <linux/io.h>
>> +#include <linux/of.h>
>>  
>>  #include "soc.h"
>>  #include "iomap.h"
>> @@ -1663,6 +1664,40 @@ static struct omap_clk omap44xx_clks[] = {
>>  	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
>>  };
>>  
>> +static struct clk *scrm_clks[] = {
>> +	&auxclk0_ck,
>> +	&auxclk1_ck,
>> +	&auxclk2_ck,
>> +	&auxclk3_ck,
>> +	&auxclk4_ck,
>> +	&auxclk5_ck,
>> +};
> 
> Hmm I don't like the idea of specifying the auxclk both in the
> cclock44xx_data.c and in DT..

Right, but till we have all clocks moved to DT we only need this
approach for general purpose clocks that are not mapped to devices
by hwmod.

e.g. auxclk are required to be specified in DT nodes for USB PHY.
Without this we can't get USB host working on Panda.

As Rajendra points out, it seems moving entire clock data to DT is not
going to happen soon. So this is the simplistic way things can work.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
