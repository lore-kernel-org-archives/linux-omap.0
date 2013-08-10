From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] ARM: dts: AM4372: add few nodes
Date: Sat, 10 Aug 2013 15:23:17 +0100
Message-ID: <20130810142317.GE18085@e106331-lin.cambridge.arm.com>
References: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com>
 <6f0f838176ab93aac8dab4c3ab9d9f95a3027ff7.1375450395.git.afzal@ti.com>
 <51FCEE60.7080809@ti.com>
 <51FF335D.4050803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42689 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933861Ab3HJOXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Aug 2013 10:23:20 -0400
Content-Disposition: inline
In-Reply-To: <51FF335D.4050803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <benoit.cousson@linaro.org>, "benoit.cousson@gmail.com" <benoit.cousson@gmail.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

On Mon, Aug 05, 2013 at 06:08:45AM +0100, Afzal Mohammed wrote:
> Hi Muguthan,
> 
> On Saturday 03 August 2013 05:19 PM, Mugunthan V N wrote:
> > On 8/2/2013 7:16 PM, Afzal Mohammed wrote:
> 
> >> +		mac: ethernet@4a100000 {
> >> +			compatible = "ti,am4372-cpsw","ti,cpsw";
> 
> > compatibility "ti,am4372-cpsw" is not needed as driver has only "ti,cpsw"
> > compatibility
> 
> No, please read device tree documentation [1].
> 
> DT is a pure hardware description, it does not depend on driver, 
> dependency is only vice versa.

One point worth mentioning is that the "ti,am4372-cpsw" string isn't
documented. Will the "ti,am4372-cpsw" binding definitely be a superset
of the "ti,cpsw" binding, and if you were to take the DT as of this
patch, and attempt to use it with a future kernel, can you guarantee
it'll work? 

> 
> >> +			reg = <0x4a100000 0x800
> >> +			       0x4a101200 0x100>;
> >> +			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH
> >> +				      GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH
> >> +				      GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH
> >> +				      GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> >> +			ti,hwmods = "cpgmac0";
> >> +			status = "disabled";
> >> +		};
> 
> > There are many other parameters which are missed here.
> 
> Reason has been mentioned in the commit message, quoting relevant here 
> again,

Actually, as you've marked the nodes disabled, it's probably fine. But
worth considering as properties are added...

Thanks,
Mark.

> 
>  >> For i2c, spi, cpsw & pwm - only the properties that were sure to be
>  >> correct has been added (main intention is to make hwmod happy and
>  >> avoid any later modification to here added properties).
> 
> I really wanted to avoid a later patch that has a line starting with 
> minus on DTS.
> 
> Since you are working on cpsw support, can you help here with a patch 
> for other properties.
> 
> Regards
> Afzal
> 
> [1] 
> http://devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
> 
