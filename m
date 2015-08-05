From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] omap: Fix broken pbias device creation
Date: Wed, 5 Aug 2015 03:00:09 -0700
Message-ID: <20150805100009.GY16878@atomide.com>
References: <1437999401-3519-1-git-send-email-kishon@ti.com>
 <55B89590.6000109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <55B89590.6000109@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, nsekhar@ti.com, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [150729 02:01]:
> On 07/27/2015 03:16 PM, Kishon Vijay Abraham I wrote:
> >pbias device creation got broken once SCM cleanup got merged.
> >This patch series re-enables device creation by adding
> >"simple-bus" in the compatible property of the syscon
> >dt node.
> >
> >validated this series in DRA72, OMAP4 PANDA and OMAP5 UEVM
> >boards.
> >
> >Kishon Vijay Abraham I (4):
> >   ARM: dts: omap24xx: Fix broken pbias device creation
> >   ARM: dts: OMAP4: Fix broken pbias device creation
> >   ARM: dts: OMAP5: Fix broken pbias device creation
> >   ARM: dts: dra7: Fix broken pbias device creation
> >
> >  arch/arm/boot/dts/dra7.dtsi     |    2 +-
> >  arch/arm/boot/dts/omap2430.dtsi |    3 ++-
> >  arch/arm/boot/dts/omap4.dtsi    |    3 ++-
> >  arch/arm/boot/dts/omap5.dtsi    |    3 ++-
> >  4 files changed, 7 insertions(+), 4 deletions(-)
> >
> 
> For dra7-evm:
> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applying all into omap-for-v4.2fixes-v2 thanks.

Tony
