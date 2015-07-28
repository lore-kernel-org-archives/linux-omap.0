From: Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: Add support for phyCORE-AM335x SoM
Date: Tue, 28 Jul 2015 08:24:47 -0400
Message-ID: <20150728122447.GE15004@beef>
References: <1437035449-26956-1-git-send-email-t.remmet@phytec.de>
 <20150727143444.GD15004@beef>
 <55B73D6D.2040801@compulab.co.il>
 <1438073248.3649.6.camel@lws-tremmet.phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438073248.3649.6.camel-wipSkzokR0f8DgGbXC/JcDlJRLeN4+xs@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Cc: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 28, 2015 at 10:47:28AM +0200, Teresa Remmet wrote:
> Hello Igor,
> 
> Am Dienstag, den 28.07.2015, 11:29 +0300 schrieb Igor Grinberg:
> > Hi Matt,
> > 
> > On 07/27/15 17:34, Matt Porter wrote:
> > > On Thu, Jul 16, 2015 at 10:30:48AM +0200, Teresa Remmet wrote:
> > >> phyCORE-AM335x is a SoM (System on Module) containing
> > >> a AM335x SOC. The module can be connected to different
> > >> carrier boards.
> > >>
> > >> Some hardware parts are configurable on the phyCORE-AM335x.
> > >> So they are disabled on default in this som dtsi file.
> > >> They will be enabled in the board dts files, when populated.
> > >>
> > >> * RAM up to 1GiB
> > >> * PMIC
> > >> * NAND flash up to 1GiB
> > >> * Eth PHY on SOM: 1x RMII
> > >> * SPI NOR flash 8MiB (optional)
> > >> * i2c RTC (optional)
> > >> * i2c EEPROM 4kiB (optional)
> > >>
> > >> Signed-off-by: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
> > >> ---
> > >>  arch/arm/boot/dts/am335x-phycore-som.dtsi | 368 ++++++++++++++++++++++++++++++
> > >>  1 file changed, 368 insertions(+)
> > >>  create mode 100644 arch/arm/boot/dts/am335x-phycore-som.dtsi
> > >>
> > >> diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
> > >> new file mode 100644
> > >> index 0000000..4d28fc3
> > >> --- /dev/null
> > >> +++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
> > 
> > [...]
> > 
> > >> +#include "am33xx.dtsi"
> > >> +
> > >> +/ {
> > >> +	model = "Phytec AM335x phyCORE";
> > >> +	compatible = "phytec,am335x-phycore-som", "ti,am33xx";
> > > 
> > > One minor thing here...wildcards in compatible strings aren't permitted.
> > > However, family compatibles like "ti,am33xx" that came in before this
> > > was enforced are grandfathered. Ideally, the newly introced board/som
> > > specific strings should not propagate that wildcard. i.e. something
> > > like "phytec,am3352-phycore-som" or whatever is the base family part
> > > on these SOMs.
> > > 
> > 
> > I'm not sure this is wild card.
> > I tend to think that it is the real name of the som [1], no?
> > 
> > http://phytec.com/products/system-on-modules/phycore/am335x/
> 
> Yes, your right. This is the name of the SoM. The phyCORE may have
> different am335x versions mounted. So there is not the one am3352 or
> am3359 always used.

Ok, great. Disregard then.

-Matt
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
