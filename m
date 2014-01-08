From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding
 information
Date: Wed, 08 Jan 2014 11:40:14 +0100
Message-ID: <4840680.vVGZYBJBID@wuerfel>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
 <4812867.NuB3hNkV9d@wuerfel> <52CD2807.9000200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52CD2807.9000200@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, "Kristo, Tero" <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 08 January 2014 15:57:19 Roger Quadros wrote:
> It is a clock gate defined like so in the DT clock data
> 
> on OMAP4
>         init_60m_fclk: init_60m_fclk {
>                 #clock-cells = <0>;
>                 compatible = "ti,divider-clock";
>                 clocks = <&dpll_usb_m2_ck>;
>                 reg = <0x0104>;
>                 ti,dividers = <1>, <8>;
>         };
> 
> on OMAP5
>         l3init_60m_fclk: l3init_60m_fclk {
>                 #clock-cells = <0>;
>                 compatible = "ti,divider-clock";
>                 clocks = <&dpll_usb_m2_ck>;
>                 reg = <0x0104>;
>                 ti,dividers = <1>, <8>;
>         };
> 
> So you can see that it is the same thing with a different name.

Right, but init_60m_fclk is the name of the clock output of the
divider here, which is /not/ what you should put in the "clock-names"
property of the consumer. The clock input name should reflect what
the clock is used for instead.

	Arnd
