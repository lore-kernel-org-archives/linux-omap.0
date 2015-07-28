From: Teresa Remmet <t.remmet@phytec.de>
Subject: Re: [PATCH 1/2] ARM: dts: Add support for phyCORE-AM335x SoM
Date: Tue, 28 Jul 2015 10:47:28 +0200
Message-ID: <1438073248.3649.6.camel@lws-tremmet.phytec.de>
References: <1437035449-26956-1-git-send-email-t.remmet@phytec.de>
	 <20150727143444.GD15004@beef> <55B73D6D.2040801@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B73D6D.2040801@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>, Matt Porter <mporter@konsulko.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Hello Igor,

Am Dienstag, den 28.07.2015, 11:29 +0300 schrieb Igor Grinberg:
> Hi Matt,
> 
> On 07/27/15 17:34, Matt Porter wrote:
> > On Thu, Jul 16, 2015 at 10:30:48AM +0200, Teresa Remmet wrote:
> >> phyCORE-AM335x is a SoM (System on Module) containing
> >> a AM335x SOC. The module can be connected to different
> >> carrier boards.
> >>
> >> Some hardware parts are configurable on the phyCORE-AM335x.
> >> So they are disabled on default in this som dtsi file.
> >> They will be enabled in the board dts files, when populated.
> >>
> >> * RAM up to 1GiB
> >> * PMIC
> >> * NAND flash up to 1GiB
> >> * Eth PHY on SOM: 1x RMII
> >> * SPI NOR flash 8MiB (optional)
> >> * i2c RTC (optional)
> >> * i2c EEPROM 4kiB (optional)
> >>
> >> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> >> ---
> >>  arch/arm/boot/dts/am335x-phycore-som.dtsi | 368 ++++++++++++++++++++++++++++++
> >>  1 file changed, 368 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/am335x-phycore-som.dtsi
> >>
> >> diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
> >> new file mode 100644
> >> index 0000000..4d28fc3
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
> 
> [...]
> 
> >> +#include "am33xx.dtsi"
> >> +
> >> +/ {
> >> +	model = "Phytec AM335x phyCORE";
> >> +	compatible = "phytec,am335x-phycore-som", "ti,am33xx";
> > 
> > One minor thing here...wildcards in compatible strings aren't permitted.
> > However, family compatibles like "ti,am33xx" that came in before this
> > was enforced are grandfathered. Ideally, the newly introced board/som
> > specific strings should not propagate that wildcard. i.e. something
> > like "phytec,am3352-phycore-som" or whatever is the base family part
> > on these SOMs.
> > 
> 
> I'm not sure this is wild card.
> I tend to think that it is the real name of the som [1], no?
> 
> http://phytec.com/products/system-on-modules/phycore/am335x/

Yes, your right. This is the name of the SoM. The phyCORE may have
different am335x versions mounted. So there is not the one am3352 or
am3359 always used.

Regards,
Teresa

> 
> [...]
> 
