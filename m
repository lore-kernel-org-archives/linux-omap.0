From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] ARM: OMAP4: hwmod_data: Remove modulemode from
 IPU/DSP hwmods
Date: Tue, 22 Aug 2017 12:24:27 -0700
Message-ID: <20170822192425.GM6008@atomide.com>
References: <20170821234818.4755-1-s-anna@ti.com>
 <20170821234818.4755-6-s-anna@ti.com>
 <20170822173749.GK6008@atomide.com>
 <a7ed87b7-bfe3-0b0c-08b4-4c44570364f2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <a7ed87b7-bfe3-0b0c-08b4-4c44570364f2@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [170822 11:45]:
> On 08/22/2017 12:37 PM, Tony Lindgren wrote:
> > I think a better way to fix this would be to make sure the module
> > is enabled during the unmapping phase of the MMUs. If there is no
> > driver left at that point to call pm_runtime_get() on the module,
> > do it via pdata-quirks.c using struct iommu_platform_data?
> 
> The problem is because there is no reference counting on modulemode
> programming unlike clocks or omap_device pm_domain callbacks. The IOMMU
> driver already has an active pm_runtime_get() invoked earlier and
> invoking another wouldn't result in any change.

Hmm iommu driver has pm_runtime_get() on which modules? Can you
please point me to that code too so I can follow..

Or is there maybe a single module shared across multiple devices?

If so, we need a minimal module wrapper driver. You can do what we
already do for musb on am335x in drivers/usb/musb/musb_am335x.c.
A single module has two musb instances and a shared cppi41 dma
instance. See also it's related entries in am33xx.dtsi.

Note that the clkctrl clocks are available now as clocks, so they
could be directly enabled for testing. See omap4_tesla_clkctrl_regs
and omap4_ducati_clkctrl_regs if that helps.

> The remoteproc driver is only dealing with its resets and hwmod while
> the IOMMU driver is dealing with its dedicated reset. The PRCM registers
> though are a single set between the two.

Sorry but I'm having hard time following which driver claims
which modules :)

Regards,

Tony
