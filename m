From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v4 3/3] ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
Date: Fri, 23 Nov 2012 11:47:33 +0100
Message-ID: <87vccwegu2.fsf@dell.be.48ers.dk>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
	<1353338956-19420-4-git-send-email-zonque@gmail.com>
	<87zk2djox6.fsf@dell.be.48ers.dk> <50AF51AF.4050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38805 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab2KWKrg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 05:47:36 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so533939wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Nov 2012 02:47:35 -0800 (PST)
In-Reply-To: <50AF51AF.4050003@gmail.com> (Daniel Mack's message of "Fri, 23
	Nov 2012 11:36:31 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com

>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:

Hi,

 D> +	Layouts for 1-bit ecc: stored at beginning of spare area as romcode:
 D> +
 D> +		"hw-romcode"	gpmc method & romcode layout
 D> +		"bch4"		4-bit BCH ecc code
 D> +		"bch8"		8-bit BCH ecc code
 D> +
 >> 
 >> These are not 1-bit - Well, romcode might be depending on SoC. Looking at
 >> omap2.c it seems to be an alias for hw, so that isn't really helpful on
 >> E.G. am33xx where you should select bch8 to have something compatible
 >> with the romcode.

 Daniel> Not sure whether I follow you here. drivers/mtd/nand/omap2.c handles
 Daniel> cases for pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW, so the DT bindings
 Daniel> need to offer a way to set it.

 Daniel> Or are you purely referring to the comments only?

Yes, but the document states (the first line I'm quotinge) 'Layouts for
1-bit ecc'. The other comment was about hw-romcode not being a very good
name, as it apparently means the 1bit hamming code and ECC layout used
on the older omap3, and not E.G. the bch8/elm layout used by
E.G. am335x.


 D> + - ti,nand-ecc-use-elm:		Property without value to specify that the
 D> +				hardware error correction mode should be used.
 >> 
 >> It's called the error location module. Like you pointed out yourself,
 >> this property isn't really nice. I haven't looked at the elm bindings in
 >> detail, but couldn't the nand driver automatically use the elm if the
 >> device tree provides a node for it? Perhaps the elm should be a subnode
 >> of the nand one?

 Daniel> That is to be discussed for the elm driver then. I'm not sure though
 Daniel> whether the elm should always be used when its DT node is present.

 Daniel> For now, I would leave it the way it is and have an optional
 Daniel> "ti,nand-ecc-use-elm". I just added some more lines of documenation to
 Daniel> describe the fact that the elm driver is needed in order to make it work.

As discussed elsewhere, the elm also changes the ECC layout, so why not
just have bchN (software bchN layout) / bchN-elm selections instead of
the seperate ti,nand-ecc-use-elm?

-- 
Bye, Peter Korsgaard
