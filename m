From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 5/8] ARM: OMAP4: hwmod_data: Remove modulemode from
 IPU/DSP hwmods
Date: Tue, 22 Aug 2017 15:54:04 -0500
Message-ID: <76d185df-3daf-cc9e-aabd-5fea26f1f028@ti.com>
References: <20170821234818.4755-1-s-anna@ti.com>
 <20170821234818.4755-6-s-anna@ti.com> <20170822173749.GK6008@atomide.com>
 <a7ed87b7-bfe3-0b0c-08b4-4c44570364f2@ti.com>
 <20170822192425.GM6008@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170822192425.GM6008@atomide.com>
Content-Language: en-US
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
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 08/22/2017 02:24 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [170822 11:45]:
>> On 08/22/2017 12:37 PM, Tony Lindgren wrote:
>>> I think a better way to fix this would be to make sure the module
>>> is enabled during the unmapping phase of the MMUs. If there is no
>>> driver left at that point to call pm_runtime_get() on the module,
>>> do it via pdata-quirks.c using struct iommu_platform_data?
>>
>> The problem is because there is no reference counting on modulemode
>> programming unlike clocks or omap_device pm_domain callbacks. The IOMMU
>> driver already has an active pm_runtime_get() invoked earlier and
>> invoking another wouldn't result in any change.
> 
> Hmm iommu driver has pm_runtime_get() on which modules? Can you
> please point me to that code too so I can follow..

The OMAP IOMMU driver deals with the MMU device only and uses both the
omap_device_{assert/deassert}_hardreset and omap_device_{enable/idle} on
the omap_device associated with the MMU device. The MMU register space
has a SYSCONFIG register (also has softreset that only resets the MMU
block) so we do have a hwmod associated with it to deal with its
setting. Today, the reset API is invoked through pdata-quirks and the
omap_device_{enable/idle} API through the pm_runtime in the IOMMU
driver. Lookup iommu_enable() and iommu_disable() in
drivers/iommu/omap-iommu.c

> Or is there maybe a single module shared across multiple devices?

Yeah kinda. The PRCM registers are just one set, with different bits in
RSTCTRL and RSTST registers dealing with different reset lines. The API
to deal with resets is still using the omap_device API and they are
invoked using pdata-quirks. For OMAP remoteproc driver, we only have one
pdata quirks defined, but the function we plug in invokes both the reset
as well as the omap_device_enable/idle functions (not in mainline yet).
See [1] for reference.

So, we have a unique hwmod/omap_device associated with each of the
individual devices (IOMMU and the processor are represented as a device
each).

> If so, we need a minimal module wrapper driver. You can do what we
> already do for musb on am335x in drivers/usb/musb/musb_am335x.c.
> A single module has two musb instances and a shared cppi41 dma
> instance. See also it's related entries in am33xx.dtsi.
> 
> Note that the clkctrl clocks are available now as clocks, so they
> could be directly enabled for testing. See omap4_tesla_clkctrl_regs
> and omap4_ducati_clkctrl_regs if that helps.

OK, looks like these are recent additions by Tero. It will still be a
shared set between the MMU and remoteproc drivers, but let me look into
how these get integrated. At this point, I don't want to be dealing with
separate clk API in my driver.

>> The remoteproc driver is only dealing with its resets and hwmod while
>> the IOMMU driver is dealing with its dedicated reset. The PRCM registers
>> though are a single set between the two.
> 
> Sorry but I'm having hard time following which driver claims
> which modules :)

OMAP IOMMU driver claims and deals with the MMU device in each of the
DSP and IPU subsystems. The OMAP remoteproc driver deals with the DSP or
the Cortex-M3/M4 cores.

regards
Suman

[1]
http://git.ti.com/gitweb/?p=rpmsg/remoteproc.git;a=blob;f=arch/arm/mach-omap2/remoteproc.c;h=78a4c4746bb568420b251bc42db02849ef439e27;hb=6f7d874549ce847eeb0308704b6a477c308f59e5
