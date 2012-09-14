From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm
Date: Fri, 14 Sep 2012 10:28:37 +0000
Message-ID: <201209141028.38185.arnd@arndb.de>
References: <1347551685-19781-1-git-send-email-anilkumar@ti.com> <201209140826.07069.arnd@arndb.de> <331ABD5ECB02734CA317220B2BBEABC13EA2F0AB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58045 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab2INK2v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 06:28:51 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2F0AB@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "greg@kroah.com" <greg@kroah.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>

On Friday 14 September 2012, AnilKumar, Chimata wrote:
>> On Fri, Sep 14, 2012 at 13:56:06, Arnd Bergmann wrote:
> > On Thursday 13 September 2012, AnilKumar Ch wrote:

> > 
> > Why do you put the "reg" property here
> 
> Here I specified reg property because lis331dlh I2C slave address is 0x18.
> 
> > 
> > >  		dcan1: d_can@481d0000 {
> > >  			status = "okay";
> > >  			pinctrl-names = "default";
> > > @@ -61,6 +70,39 @@
> > >  		regulator-max-microvolt = <5000000>;
> > >  		regulator-boot-on;
> > >  	};
> > > +
> > > +	lis3_reg: fixedregulator@1 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "lis3_reg";
> > > +		regulator-boot-on;
> > > +	};
> > > +};
> > > +&lis331dlh {
> > > +	compatible = "st,lis3lv02d-i2c";
> > 
> > and all the rest here? At least I would expect the "compatible" property
> > to be in the same place above.
> 
> This data is appended to above one, to make it readable I moved remaining
> properties to here.

I don't follow how this is making things more readable.

Maybe a more logical way to do this would be use the existing i2c2 label
and write all the additions as

i2c2: {
	status = "okay";
	clock-frequency = <400000>;

	lis331dlh@18 {
		compatible = "st,lis3lv02d";
		reg = <0x18>;

		vdd-supply = <&lis3_reg>;
		vdd-io-supply = <&lis3_reg>;
		...
	};

> > Also, I think you should remove the "-i2c" postfix from the name, that
> > is already implied by the parent bus.
> 
> I will remove, but in case of spi the compatible name is lis3lv02d_spi.
> By mistake I have uses "-i2c" instead of "_i2c".

The normal convention is to use '-', not '_', so that part was ok.

I think naming the other one lis3lv02d_spi was a mistake, it should
be named 'st,lis3lv02d' independent of the bus IMHO.

> Document is already present, 
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;h=2f2ff3cc8d930493f9a598b9192706c09403e12e
> 
> Some minor changes in docs, in my next version I will update document
> as well. I will send V3 if there are no comments on v2.

Ok.

	Arnd
