From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] ti-sysc dts changes for omaps for v4.21
Date: Thu, 20 Dec 2018 16:37:12 +0100
Message-ID: <CAK8P3a1fnreKPkbyEMBgC_ACGCnhJ56bQOad38VfaQcKNnWEeg@mail.gmail.com>
References: <pull-1544723769-214686@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1544723769-214686@atomide.com>
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 13, 2018 at 9:25 PM Tony Lindgren <tony@atomide.com> wrote:
>   ARM: dts: Cosmetic fix for omap5 USB node names (2018-12-13 09:08:43 -0800)
>
> ----------------------------------------------------------------
> Add interconnect target module dts data for omaps for v4.21
>
> This big set of changes adds SoC specific l4 interconnect target module
> device tree data for am335x, am437x, omap5 and dra7 SoCs. We also move
> existing devices to the right location in the l4 interconnect hierarcy.
> This is similar to what we've already done for omap4 l4 interconnects
> earlier, and follows what is documented in the ti-sysc driver dts binding
> in Documentation/devicetree/bindings/bus/ti-sysc.txt.
>
> These changes will essentially replace the struct ti_sysc and clock
> entries in the arch/arm/mach-omap2/omap_hwmod_*_data.c files. Then a few
> merge windows later, we can start dropping the built-in platform data
> from the omap_hwmod_*_data.c files in favor of the device tree data only.
> For now, we verify the device tree data module data against the built-in
> data and warn about changes to prevent regressions.
>
> With the device tree data, we are also probing devices with the ti-sysc
> interconnect target module instead of omap_device. This fixes up the
> handling for multiple device instances in a single interconnect target
> module that has caused trouble earlier. A custom wrapper driver has been
> needed earlier for such cases.
>
> And as the device tree data is organized by the l4 interconnect instances,
> we will be able to use genpd later on. This is because each interconnect
> instance is also often also a single power domain.
>
> This series of changes has been brewing for several months now. I did not
> want to send a pull request earlier as people were still seeing device
> specific issues until recently though. However, it turned out that all the
> issues were quite trivial to fix. I had missed adding device tree ranges
> for the l3 data port used on some devices, and I had missed converting the
> device addresses for a few devices. And some devices like needed fixes for
> deferred probe handling such as the EHCI PHY for built-in case on omap5.
>
> Anyways, in case of trouble, we can easily just revert changes for a
> single device if needed.

Thanks a lot for the detailed description and background, that really helps!

Pulled into next/dt now,

      Arnd
