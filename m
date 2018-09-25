From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Tue, 25 Sep 2018 10:44:11 +0530
Message-ID: <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
References: <20180925000545.22931-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180925000545.22931-1-tony@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org



On Tuesday 25 September 2018 05:35 AM, Tony Lindgren wrote:
> Hi all,
> 
> Here are four patches to make am437x and am335x l4 devices to probe with
> ti-sysc driver similar to what we've already done for omap4. The related
> legacy hwmod platform data will be removed few merge cycles later.
> 
> There are still dependencies to Tero's clkctrl changes and for ti-sysc
> drivers changes. So these patches are based on on v4.19-rc3 merged with
> my omap-for-v4.20/dt branch plus the following additional series of
> patches:
> 
> [PATCH 00/11] clk: ti: clkctrl data split based on clkdm boundaries
> [PATCH 0/3] ARM: dts: am3/am4/dra7 clkctrl data conversion
> [PATCH 0/4] TI sysc driver updates for am335x and am437x
> 
> v4.19-rc3 is needed for commit 18eb8aea7fb2 ("net: ethernet:
> cpsw-phy-sel: prefer phandle for phy sel") and omap-for-v4.20/dt
> is needed to avoid conflicts with clean-up.
> 
> I've also pushed out a temporary testing branch for people to test
> as omap-for-v4.20/dt-ti-sysc-tmp-testing [0][1].
> 
> Regards,
> 
> Tony
> 
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v4.20/dt-ti-sysc-tmp-testing
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v4.20/dt-ti-sysc-tmp-testing

Hi Tony,

I tried Branch [1] above. AM335x-boneblack is doing all good with ds0.
AM437x-gp the following is happening:

https://pastebin.ubuntu.com/p/fmZNYgJ9Sp/

There seems to be a timeout due to which resume is not immediate i see
1-2s delay and i see i2c timeout.

[  402.247271] omap_i2c 4802a000.i2c: controller timed out
[  402.247441] pixcir_ts 1-005c: pixcir_int_enable: can't read reg 0x34
: -110
[  402.247486] pixcir_ts 1-005c: Failed to disable interrupt generation:
-110
[  402.247522] pixcir_ts 1-005c: Failed to stop
[  402.247607] dpm_run_callback(): pixcir_i2c_ts_resume+0x0/0x98
[pixcir_i2c_ts] returns -110

so pixcir_i2c_ts_resume is retuning -110 which is timeout error code.

I did some touch screen testing after DS0 resume seems to be working.
Everything is in pastebin link provided above.

Regards,
Keerthy
> 
> 
> Tony Lindgren (4):
>   ARM: dts: am437x: Add l4 interconnect hierarchy and ti-sysc data
>   ARM: dts: am437x: Move l4 child devices to probe them with ti-sysc
>   ARM: dts: am335x: Add l4 interconnect hierarchy and ti-sysc data
>   ARM: dts: am335x: Move l4 child devices to probe them with ti-sysc
> 
>  arch/arm/boot/dts/am335x-shc.dts |    2 +-
>  arch/arm/boot/dts/am33xx-l4.dtsi | 2132 +++++++++++++++++++++++++
>  arch/arm/boot/dts/am33xx.dtsi    |  623 +-------
>  arch/arm/boot/dts/am4372.dtsi    |  876 +----------
>  arch/arm/boot/dts/am437x-l4.dtsi | 2499 ++++++++++++++++++++++++++++++
>  5 files changed, 4651 insertions(+), 1481 deletions(-)
>  create mode 100644 arch/arm/boot/dts/am33xx-l4.dtsi
>  create mode 100644 arch/arm/boot/dts/am437x-l4.dtsi
> 
