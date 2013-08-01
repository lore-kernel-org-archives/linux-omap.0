From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 02/33] clk: omap: introduce clock driver
Date: Thu, 1 Aug 2013 17:59:46 +0300
Message-ID: <51FA77E2.60104@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-3-git-send-email-t-kristo@ti.com> <51F7DA0D.7060709@ti.com>
 <51F8D1E3.2@ti.com> <51FA663E.3070109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51FA663E.3070109@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/01/2013 04:44 PM, Nishanth Menon wrote:
> On 07/31/2013 03:59 AM, Tero Kristo wrote:
>> On 07/30/2013 06:21 PM, Nishanth Menon wrote:
>>> On 07/23/2013 02:19 AM, Tero Kristo wrote:
>>>> Parses OMAP clock data from DT and registers those clocks with the
>>>> clock
>>>> framework.  dt_omap_clk_init must be called early during boot for timer
>>>> initialization so it is exported and called from the existing clock
>>>> code
>>>> instead of probing like a real driver. Based on initial work done by
>>>> Mike Turquette.
>>>>
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> Cc: Mike Turquette <mturquette@linaro.org>
>>>> ---
>>>>   drivers/clk/Makefile      |    1 +
>>>>   drivers/clk/omap/Makefile |    1 +
>>>>   drivers/clk/omap/clk.c    |   39
>>>> +++++++++++++++++++++++++++++++++++++++
>>>
>>> Minor suggestion - should we just start drivers/clk/ti/ instead of
>>> clk/omap?
>>>
>>> AM335x/DRA7 are not "strictly OMAP".. might also allow for some reuse
>>> for other TI platforms..
>>
>> Not sure, this idea has been bounced around a bit. samsung has its own
>> directory under drivers/clk/ so maybe. I can change this if there is a
>> strong wish for this.
>
> just my 2 cents - if we use drivers/clk/ti, we can then move required
> stuff from arch/arm/mach-davinci or arch/arm/mach-keystone to a ti
> generic location allowing us to reuse things as needed.

Ok, I'll rename the dir.

>
>>
>>>
>>>>   include/linux/clk/omap.h  |   24 ++++++++++++++++++++++++
>>>>   4 files changed, 65 insertions(+)
>>>>   create mode 100644 drivers/clk/omap/Makefile
>>>>   create mode 100644 drivers/clk/omap/clk.c
>>>>   create mode 100644 include/linux/clk/omap.h
>>>>
>>>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>>>> index 4038c2b..d3c3733 100644
>>>> --- a/drivers/clk/Makefile
>>>> +++ b/drivers/clk/Makefile
>>>> @@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_VT8500)    += clk-vt8500.o
>>>>   obj-$(CONFIG_ARCH_ZYNQ)        += zynq/
>>>>   obj-$(CONFIG_ARCH_TEGRA)    += tegra/
>>>>   obj-$(CONFIG_PLAT_SAMSUNG)    += samsung/
>>>> +obj-$(CONFIG_ARCH_OMAP)        += omap/
>>>>
>>>>   obj-$(CONFIG_X86)        += x86/
>>>>
>>>> diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
>>>> new file mode 100644
>>>> index 0000000..8195931
>>>> --- /dev/null
>>>> +++ b/drivers/clk/omap/Makefile
>>>> @@ -0,0 +1 @@
>>>> +obj-y                    += clk.o
>>>> diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
>>>> new file mode 100644
>>>> index 0000000..4bf1929
>>>> --- /dev/null
>>>> +++ b/drivers/clk/omap/clk.c
>>>> @@ -0,0 +1,39 @@
>>>> +/*
>>>> + * OMAP PRCM clock driver
>>>
>>> maybe then prcm-clk.c ?
>>
>> Maybe remove the PRCM part. We have some clocks behind i2c for example,
>> and we might want to add support for them here.
>
> I think we can actually drop this file in it's entirety if we stick with
> of_clk_init(NULL) and depend solely of CLK_OF_DECLARE from relevant
> drivers.

Yeah, I'll do this and drop the file.
