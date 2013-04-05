From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC][PATCH 1/2] ARM: OMAP4: clock: Add device tree support for
 AUXCLKs
Date: Fri, 5 Apr 2013 20:56:05 +0300
Message-ID: <515F1035.8090500@ti.com>
References: <1363703220-4777-1-git-send-email-rogerq@ti.com>
 <1363703220-4777-2-git-send-email-rogerq@ti.com>
 <20130403234242.GE10155@atomide.com> <515D2D30.3000306@ti.com>
 <20130404164137.GH10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130404164137.GH10155@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-usb@vger.kernel.org, linux@arm.linux.org.uk, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On 04/04/2013 07:41 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [130404 00:39]:
>> On 04/04/2013 02:42 AM, Tony Lindgren wrote:
>>>> --- a/arch/arm/mach-omap2/cclock44xx_data.c
>>>> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
>>>> @@ -27,6 +27,7 @@
>>>>   #include <linux/clk-private.h>
>>>>   #include <linux/clkdev.h>
>>>>   #include <linux/io.h>
>>>> +#include <linux/of.h>
>>>>   
>>>>   #include "soc.h"
>>>>   #include "iomap.h"
>>>> @@ -1663,6 +1664,40 @@ static struct omap_clk omap44xx_clks[] = {
>>>>   	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
>>>>   };
>>>>   
>>>> +static struct clk *scrm_clks[] = {
>>>> +	&auxclk0_ck,
>>>> +	&auxclk1_ck,
>>>> +	&auxclk2_ck,
>>>> +	&auxclk3_ck,
>>>> +	&auxclk4_ck,
>>>> +	&auxclk5_ck,
>>>> +};
>>> Hmm I don't like the idea of specifying the auxclk both in the
>>> cclock44xx_data.c and in DT..
>> Right, but till we have all clocks moved to DT we only need this
>> approach for general purpose clocks that are not mapped to devices
>> by hwmod.
> For v3.10, let's just make sure that USB works with DT as then
> after v3.10 we can make omap4 DT only and get rid of estimated
> 7K lines of code and data. I guess this is the last piece missing
> for that, or are we also missing something else?
>
> Can't you set up a clock alias for your device so it can find the
> auxclk when requesting it with the dev entry?
>
> For the DT clock driver if needed for v3.10, how about just do a
> minimal drivers/clock/omap/ that uses the standard binding?
> Then that driver can just do clk_get() from cclock44xx_data.c
> for now? And then later on we'll just move all the clocks to a
> combination of DT + /lib/firmware.
>
Hi Roger, Rajendra, All

Sorry that disturbing you.

I'm supporting Android OMAP4 kernels (K3.0/K3.4) and like to clarify few
points regarding this approach (having into account possible future 
migrations
on newer Kernels and OMAP5).
If I understand everything right, this patch series allows to create 
clock binding
in DT using following syntax: clocks = <&aux_clks 3>
  - does it means that in worst case there will be ~200 clock IDs defined?
  - does it means that clock nodes binding using phandles 
(human-friendly notation)
isn't going to be supported?
for example:
     clocks = <&sys_clkin_ck>
     clocks = <&dss_sys_clk &dss_tv_clk &dss_dss_clk>)

I was horrified to think about the problems of this approach support
(in case if there would be more then ~30 IDs) - just miss with on digit
and weeks of debugging would be guaranteed.

Please, say me that i'm wrong.
And why clock DT data can't be auto-generated like all other OMAP data
to close this questions?

Thanks.

>> e.g. auxclk are required to be specified in DT nodes for USB PHY.
>> Without this we can't get USB host working on Panda.
> OK. So if the USB PHY has a dev entry, can't you just set up a
> clock alias in struct omap_clk omap44xx_clks[] for it?
>   
>> As Rajendra points out, it seems moving entire clock data to DT is not
>> going to happen soon. So this is the simplistic way things can work.
> Right but seems like we can get started there without moving
> them all at once.
>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
