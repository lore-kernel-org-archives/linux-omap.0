From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: DRA7x/OMAP5: Clock: DPLL Clock fixes
Date: Fri, 6 Mar 2015 08:37:16 -0800
Message-ID: <20150306163715.GO13520@atomide.com>
References: <1422724005-9415-1-git-send-email-rk@ti.com>
 <54E5FC6D.7040701@ti.com> <20150224162719.GA28244@atomide.com>
 <54ED79B0.4020101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <54ED79B0.4020101@ti.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, Ravikumar Kattekola <rk@ti.com>, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [150225 00:05]:
> On 02/24/2015 06:27 PM, Tony Lindgren wrote:
> >* Ravikumar Kattekola <rk@ti.com> [150219 08:13]:
> >>On 1/31/2015 10:36 PM, Ravikumar Kattekola wrote:
> >>>Fix bypass clock source for a few DPLLs.
> >>>
> >>>On DRA7x/OMAP5, for a few DPLLs, both CLKINP and CLKINPULOW are connected
> >>>to a mux and the output from mux is routed to the bypass clkout.
> >>>Add a mux-clock as bypass clock with CLKINP and CLKINPULOW as parents.
> >>>
> >>>Tested against:
> >>>	tree: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> >>>	branch: master
> >>>On:
> >>>CPU  : OMAP5432 ES2.0
> >>>Board: OMAP5432 uEVM
> >>>and
> >>>CPU  : DRA752 ES1.0
> >>>Board: DRA7xx
> >>>
> >>>
> >>>Ravikumar Kattekola (2):
> >>>   ARM: DRA7x: dts: Fix the bypass clock source for dpll_iva and others
> >>>   ARM: OMAP5: dts: Fix the bypass clock source for dpll_iva and others
> >>>
> >>>  arch/arm/boot/dts/dra7xx-clocks.dtsi   |   90 ++++++++++++++++++++++++++++----
> >>>  arch/arm/boot/dts/omap54xx-clocks.dtsi |   41 +++++++++++++--
> >>>  2 files changed, 118 insertions(+), 13 deletions(-)
> >>>
> >>Hi Benoit,
> >>     Can these fixes be looked into for 3.20-rc?
> >
> >Seem like valid fixes to me. Tero, care to take a look at these and ack
> >if OK?
> 
> Yes, both are good to go.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Applying both into omap-for-v4.0/fixes thanks.

Tony 
