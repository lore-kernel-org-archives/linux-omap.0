From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: Add clocks for dm814x ADPLL
Date: Tue, 22 Dec 2015 12:29:08 -0800
Message-ID: <20151222202907.GF2793@atomide.com>
References: <1450799607-9334-1-git-send-email-tony@atomide.com>
 <5679AE41.2080409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5679AE41.2080409@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [151222 12:08]:
> On 12/22/2015 05:53 PM, Tony Lindgren wrote:
> >These use the standard clock bindings and now we can make some
> >of the fixed clocks into real clocks.
> >
> >Cc: Tero Kristo <t-kristo@ti.com>
> >Signed-off-by: Tony Lindgren <tony@atomide.com>
> >---
> >Changes since v1:
> >
> >- Updated for changed clock names for "dcoclkldo"
> >- Merged in the dra62x changes
> >
> >---
> >  arch/arm/boot/dts/dm814x-clocks.dtsi | 256 ++++++++++++++++++++++++++++++-----
> >  arch/arm/boot/dts/dra62x-clocks.dtsi |  26 ++++
> >  2 files changed, 251 insertions(+), 31 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/dm814x-clocks.dtsi b/arch/arm/boot/dts/dm814x-clocks.dtsi
> >index e0ea6a9..b75ca91 100644
> >--- a/arch/arm/boot/dts/dm814x-clocks.dtsi
> >+++ b/arch/arm/boot/dts/dm814x-clocks.dtsi
> >@@ -4,6 +4,170 @@
> >   * published by the Free Software Foundation.
> >   */
> >
> >+&pllss {
> >+	/*
> >+	 * See TRM "2.6.10 Connected outputso DPLLS" and
> >+	 * "2.6.11 Connected Outputs of DPLLJ". Only clkout is
> >+	 * connected except for hdmi and usb.
> >+	 */
> >+	adpll_mpu_ck: adpll@40 {
> >+		#clock-cells = <1>;
> >+		compatible = "ti,dm814-adpll-s-clock";
> >+		reg = <0x40 0x40>;
> >+		clocks = <&devosc_ck &devosc_ck &devosc_ck>;
> >+		clock-names = "clkinp", "clkinpulow", "clkinphif";
> >+		clock-indices = <0>, <1>, <2>, <3>;
> >+		clock-output-names = "481c5040.adpll.dcoclkldo",
> >+				     "481c5040.adpll.clkout",
> >+				     "481c5040.adpll.clkoutx2",
> >+				     "481c5040.adpll.clkouthif";
> 
> Discussed this offline, but looks like most of the clock output names can
> probably be generated runtime, as they seem duplicate across adplls?
> Including the address component.

Yes the output names could be generated if not separately specified.
Eventually we probably want to use more descriptive names here though.

> Based on the offline discussion though:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

OK thanks,

Tony
