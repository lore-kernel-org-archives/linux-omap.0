From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 1/4] ARM: OMAP2+: cleaned-up DT support of various ECC
 schemes
Date: Tue, 27 Aug 2013 10:04:42 -0700
Message-ID: <20130827170442.GB22852@quad.lixom.net>
References: <1373748891-7779-1-git-send-email-pekon@ti.com>
 <1373748891-7779-2-git-send-email-pekon@ti.com>
 <20130822045452.GA5151@quad.lixom.net>
 <20980858CB6D3A4BAE95CA194937D5E73E9F9E94@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54572 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab3H0RFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Aug 2013 13:05:23 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so5120878pbb.33
        for <linux-omap@vger.kernel.org>; Tue, 27 Aug 2013 10:05:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9F9E94@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "zonque@gmail.com" <zonque@gmail.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "N, Mugunthan V" <mugunthanvnm@ti.com>, "tony@atomide.com" <tony@atomide.com>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Aug 22, 2013 at 07:56:57AM +0000, Gupta, Pekon wrote:
> > This change doesn't look like an improvement to me.
> > 
> [Pekon]: Accepted. I'll drop this. However, this is not a new binding.
> I was just elaborating & formatting the description because code allows only
> two values "16" or "8".

No need to prefix your replies with [Pekon]. Based on quotation level it's easy
to see who said what.

> > > - - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
> > >
> > > -		"sw"		Software method (default)
> > > -		"hw"		Hardware method
> > > -		"hw-romcode"	gpmc hamming mode method & romcode
> > layout
> > > -		"bch4"		4-bit BCH ecc code
> > > -		"bch8"		8-bit BCH ecc code
> > > + - ti,nand-ecc-opt:		Determines the ECC scheme used by driver.
> > > +				It can be any of the following strings:
> > 
> > The device tree should define the hardware, not configure the software.
> > 
> > Also, if it defines the scheme then you should probably call it something like
> > "ti,nand-ecc-scheme" instead.
> > 
> [Pekon]: Again, ti,nand-ecc-opt is not new DT binding, This was added in
> 	Commit bc6b1e7b86f5d8e4a6fc1c0189e64bba4077efe0
> 	Daniel Mack <zonque@gmail.com>
> 	ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
> I just expanded its options..

Yes, but it's not describing hardware.

If anything, the device entry should somehow describe the various ecc options
that the hardware implements (if you can't derive that from the compatible
value, which I think you can?).

> Also I'll try to explain how below ecc-scheme selection is linked to TI Hardware.
> TI SoC uses two separate H/W engines for calculating and correcting ECC.
> (a) GPMC: General Purpose Memory Controller which calculates ECC also.
> (b) ELM: Error Locator Module which just locates errors in BCHx code only.
> 
> *Reason-1*: All OMAP platforms have (a) GPMC h/w engine, but some 
> legacy OMAP  platforms do not have (b) ELM h/w engine. Such older 
> platforms use S/W lib/bch.c libraries for ECC error detection.

Ok, so then you just need a binary "elm-engine" property to indicate
that the hardware does have the engine.

> Therefore in-order to keep the driver consistent for all platforms we 
> needed to keep so many ECC options alive. Like below you would see
> two versions of BCH8 and BCH4
> - bch8_code_hw (supported on new devices with ELM h/w engine)
> - bch8_code_hw_detection_sw (kept for legacy devices)

All you need to specify is what ECC format is used. I.e. BCH8. Whether the
hardware or software will be used to calculate the checksums and detect/correct
errors is a driver decision, and not something that the device tree needs to
specify.

> *Reason-2*: Also H/W ECC schemes have different ECC layout, which is
> compatible to ROM code. Thus end-to-end NAND boot would work
> only with xx_code_hw schemes only.

So you should describe what the layout in use is. Wouldn't it be
possible to make the software handle the same layout as the hardware
engine if needed? I.e. the decision of using HW or SW is not a property
of the hardware and shouldn't be described in the device tree.

> Hence ECC selection is dependent on H/W, hence put as DT binding.
> But I agree going forward we should deprecate most of legacy options
> when there is common H/W platform for all devices.
> 
> 
> > > +
> > > +	"hamming_code_sw"		1-bit Hamming ECC
> > > +					- ECC calculation in software
> > > +					- Error detection in software
> > > +
> > > +	"hamming_code_hw"		1-bit Hamming ECC
> > > +					- ECC calculation in hardware
> > > +					- Error detection in software
> > 
> > Bzzt. Same here. It really doesn't matter to the hardware if the ECC is
> > calculated in HW or SW, and it doesn't belong in the device tree.
> 
> [Pekon]: Not a new bindings option just renamed, and kept for legacy
>  compatibility (please refer change diff below)

Same arguments as above.

> > > -		"sw"		Software method (default)
> 	renamed to "hamming_code_sw"
> 
> > > -		"hw"		Hardware method 
> 	renamed to "hamming_code_hw"
> 
> 
> > > +
> > > +	"hamming_code_hw_romcode"	1-bit Hamming ECC
> > > +					- ECC calculation in hardware
> > > +					- Error detection in software
> > > +					- ECC layout compatible to ROM code
> > > +
> > > +	"bch8_hw_code_detection_sw"	8-bit BCH ECC
> > > +					- ECC calculation in hardware
> > > +					- Error detection in software
> > > +					- depends on
> > CONFIG_MTD_NAND_ECC_BCH
> > 
> > Configuration options don't belong in here either.
> > 
> [Pekon]: As explained above, legacy platforms do not have ELM h/w.
> So they depend on lib/bch.c libraries for ECC detection. But that bloats
> the driver code-footprint a lot, just to maintain compatibility for legacy
> device platforms. Therefore I had to use KConfigs to keep driver
> code-footprint small.
>
> I can remove KConfig from documentation, but then it would confuse
> the users when they get NAND probing errors because:
> - bchx_hw_code requires ELM h/w engine, which is not present on 
> 	legacy devices.
> -  bchx_hw_code_detection_sw requires lib/bch.c which is only
> 	 enabled by CONFIG_MTD_NAND_ECC_BCH.
> 
> Will removing KConfig from DT Documentation be acceptable ?

Yes, please remove it. Bindings documentation should not document kernel config
options.

> > > +
> > > +	"bch8_code_hw"             	8-bit BCH ECC
> > > +					- ECC calculation in hardware
> > > +					- Error detection in hardware
> > > +					- depends on
> > CONFIG_MTD_NAND_OMAP_BCH
> > > +					- requires <elm_id> to be specified
> > 
> > Some of the above clearly shouldn't be described in the device tree at all, but
> > it's also not very convenient to describe them as strings. Since you have
> > a binding, it's probably easier to give them integer values and just define
> > what those mean.
> > 
> [Pekon]: Do you mean something like below ?
> ti,nand-ecc-scheme(n)  where 'n' means
> 	0 ==  1-bit Hamming in S/W
> 	1 ==  1-bit Hamming in H/W
> 	2 ==  BCH4 with S/W detection
> 	3 ==  BCH4 all in H/W
> 	4 ==  BCH8 with S/W detection
> 	5 ==  BCH8 all in H/W

Well, see above -- I think you can just describe the properties of the hardware
and make the driver pick appropriate setup based on it.

> > > + - elm_id:			Specifies elm device node. This is required to
> > > +				support some BCH ECC schemes mentioned
> > above.
> > 
> > Use dashes instead of underscores for properties. if all other properties are
> > prepended with "ti,", then so should this.
> > 
> [Pekon]: Accepted. But again this is not new DT binding. It was added in
> 	Commit 97c794a1e37b1ca128ef38f17c069186bfa5fb1b
> 	Philip Avinash <avinashphilip@ti.com>
> 	gpmc: Add device tree documentation for elm handle

Since you are revising the binding, this is the time to change it.

> > What's an ELM device node? How is it specified? A phandle?
> > 
> [Pekon]: ELM is a DT node specified in soc.dtsi (because ELM is not
>  present in  legacy devices). Example Please refer:
> $KERNEL/arch/arm/boot/dts/am33xx.dtsi

What I meant with a question like that is: Please document how it's specified.
It's not clear from reading it, since I had to ask.



-Olof
