From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/10] thermal: Remove "cooling-{min|max}-level" properties
Date: Fri,  9 Feb 2018 14:28:00 +0530
Message-ID: <cover.1518166039.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Carlo Caione <carlo@caione.org>, Chen-Yu Tsai <wens@csie.org>, Eduardo Valentin <edubezval@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Wei Xu <xuwei5@hisilicon.com>, Zhang Rui <rui.zhang@intel.com>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of the kernel currently and the max cooling state of
a cooling devices is found by cooling-device's driver itself.

Also note that a very small number of platforms that support cooling
devices currently contain these properties in their dts files. Most of
them don't specify them (as no one is going to use them anyway).

Only two type of cooling devices are using these properties currently:
cpu-cooling and gpio-fan. This series first updates all the dts files to
not specify the min/max cooling states and then removes the bindings.

The maintainers are requested to apply the relevant patches to their
trees directly as there is no dependency between the patches.

--
viresh

Viresh Kumar (10):
  ARM: dts: exynos: Remove "cooling-{min|max}-level" for CPU nodes
  ARM: dts: omap: Remove "cooling-{min|max}-level" for CPU nodes
  ARM: dts: mt7623: Remove "cooling-{min|max}-level" for CPU nodes
  ARM: dts: sun[4-7]i: Remove "cooling-{min|max}-level" for CPU nodes
  ARM64: dts: hi6220: Remove "cooling-{min|max}-level" for CPU nodes
  ARM64: dts: meson: Remove "cooling-{min|max}-level" for CPU nodes
  ARM: dts: gemini: Remove "cooling-{min|max}-level" for gpio-fan node
  ARM64: dts: meson: Remove "cooling-{min|max}-level" for gpio-fan node
  dt-bindings: cpufreq-dt: Remove "cooling-{min|max}-level" properties
  dt-bindings: thermal: Remove "cooling-{min|max}-level" properties

 Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt |  4 ----
 .../devicetree/bindings/cpufreq/cpufreq-mediatek.txt     |  4 ----
 Documentation/devicetree/bindings/thermal/thermal.txt    | 16 +---------------
 arch/arm/boot/dts/dra7.dtsi                              |  2 --
 arch/arm/boot/dts/exynos4210.dtsi                        |  2 --
 arch/arm/boot/dts/exynos4412.dtsi                        |  2 --
 arch/arm/boot/dts/exynos5250.dtsi                        |  2 --
 arch/arm/boot/dts/exynos5420-cpus.dtsi                   | 16 ----------------
 arch/arm/boot/dts/exynos5422-cpus.dtsi                   | 16 ----------------
 arch/arm/boot/dts/gemini-dlink-dns-313.dts               |  2 --
 arch/arm/boot/dts/mt7623.dtsi                            |  2 --
 arch/arm/boot/dts/omap443x.dtsi                          |  2 --
 arch/arm/boot/dts/omap4460.dtsi                          |  2 --
 arch/arm/boot/dts/omap5.dtsi                             |  2 --
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts           |  1 -
 arch/arm/boot/dts/sun4i-a10.dtsi                         |  2 --
 arch/arm/boot/dts/sun5i-a13.dtsi                         |  2 --
 arch/arm/boot/dts/sun6i-a31.dtsi                         |  2 --
 arch/arm/boot/dts/sun7i-a20.dtsi                         |  2 --
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts    |  6 ------
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi                |  2 --
 21 files changed, 1 insertion(+), 90 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
