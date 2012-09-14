From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 2/2] ARM: dts: AM33XX: Add lis331dlh device tree data to
 am335x-evm
Date: Fri, 14 Sep 2012 09:18:32 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2F0AB@DBDE01.ent.ti.com>
References: <1347551685-19781-1-git-send-email-anilkumar@ti.com>
 <1347551685-19781-3-git-send-email-anilkumar@ti.com>
 <201209140826.07069.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52722 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758166Ab2INJTE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 05:19:04 -0400
In-Reply-To: <201209140826.07069.arnd@arndb.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "greg@kroah.com" <greg@kroah.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

Hi Arnd,

Thanks for the review,

On Fri, Sep 14, 2012 at 13:56:06, Arnd Bergmann wrote:
> On Thursday 13 September 2012, AnilKumar Ch wrote:
> > Add lis331dlh device tree data to am335x-evm.dts. In AM335x EVM
> > lis331dlh accelerometer is connected to I2C2 bus. So this patch
> > change the status to "okay" to use I2C2 bus. Also added all the
> > required platform data to am335x-evm.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/boot/dts/am335x-evm.dts |   42 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> > index 9fb59c5..9e5a878 100644
> > --- a/arch/arm/boot/dts/am335x-evm.dts
> > +++ b/arch/arm/boot/dts/am335x-evm.dts
> > @@ -47,6 +47,15 @@
> >  			};
> >  		};
> >  
> > +		i2c2: i2c@4802a000 {
> > +			status = "okay";
> > +			clock-frequency = <400000>;
> > +
> > +			lis331dlh: lis331dlh@18 {
> > +				reg = <0x18>;
> > +			};
> > +		};
> 
> Why do you put the "reg" property here

Here I specified reg property because lis331dlh I2C slave address is 0x18.

> 
> >  		dcan1: d_can@481d0000 {
> >  			status = "okay";
> >  			pinctrl-names = "default";
> > @@ -61,6 +70,39 @@
> >  		regulator-max-microvolt = <5000000>;
> >  		regulator-boot-on;
> >  	};
> > +
> > +	lis3_reg: fixedregulator@1 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "lis3_reg";
> > +		regulator-boot-on;
> > +	};
> > +};
> > +&lis331dlh {
> > +	compatible = "st,lis3lv02d-i2c";
> 
> and all the rest here? At least I would expect the "compatible" property
> to be in the same place above.

This data is appended to above one, to make it readable I moved remaining
properties to here.

> 
> Also, I think you should remove the "-i2c" postfix from the name, that
> is already implied by the parent bus.

I will remove, but in case of spi the compatible name is lis3lv02d_spi.
By mistake I have uses "-i2c" instead of "_i2c".

> 
> > +	Vdd-supply = <&lis3_reg>;
> > +	Vdd_IO-supply = <&lis3_reg>;
> > +
> > +	st,click-single-x;
> > +	st,click-single-y;
> > +	st,click-single-z;
> > +	st,click-thresh-x = <10>;
> > +	st,click-thresh-y = <10>;
> > +	st,click-thresh-z = <10>;
> > +	st,irq1-click;
> > +	st,irq2-click;
> > +	st,wakeup-x-lo;
> > +	st,wakeup-x-hi;
> > +	st,wakeup-y-lo;
> > +	st,wakeup-y-hi;
> > +	st,wakeup-z-lo;
> > +	st,wakeup-z-hi;
> > +	st,min-limit-x = <120>;
> > +	st,min-limit-y = <120>;
> > +	st,min-limit-z = <140>;
> > +	st,max-limit-x = <550>;
> > +	st,max-limit-y = <550>;
> > +	st,max-limit-z = <750>;
> 
> Is there a binding document that describes all these?

Document is already present, 
http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;h=2f2ff3cc8d930493f9a598b9192706c09403e12e

Some minor changes in docs, in my next version I will update document
as well. I will send V3 if there are no comments on v2.

Thanks
AnilKumar
