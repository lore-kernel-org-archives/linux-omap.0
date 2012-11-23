From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v4 3/3] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Fri, 23 Nov 2012 11:55:12 +0100
Message-ID: <50AF5610.7010505@gmail.com>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com> <1353338956-19420-4-git-send-email-zonque@gmail.com> <87zk2djox6.fsf@dell.be.48ers.dk> <50AF51AF.4050003@gmail.com> <87vccwegu2.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61204 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab2KWKzU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 05:55:20 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so3785903bkw.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Nov 2012 02:55:18 -0800 (PST)
In-Reply-To: <87vccwegu2.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com

On 23.11.2012 11:47, Peter Korsgaard wrote:
>>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:
> 
> Hi,
> 
>  D> +	Layouts for 1-bit ecc: stored at beginning of spare area as romcode:
>  D> +
>  D> +		"hw-romcode"	gpmc method & romcode layout
>  D> +		"bch4"		4-bit BCH ecc code
>  D> +		"bch8"		8-bit BCH ecc code
>  D> +
>  >> 
>  >> These are not 1-bit - Well, romcode might be depending on SoC. Looking at
>  >> omap2.c it seems to be an alias for hw, so that isn't really helpful on
>  >> E.G. am33xx where you should select bch8 to have something compatible
>  >> with the romcode.
> 
>  Daniel> Not sure whether I follow you here. drivers/mtd/nand/omap2.c handles
>  Daniel> cases for pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW, so the DT bindings
>  Daniel> need to offer a way to set it.
> 
>  Daniel> Or are you purely referring to the comments only?
> 
> Yes, but the document states (the first line I'm quotinge) 'Layouts for
> 1-bit ecc'.

Ok, I guess I'll just remove these comments then.

> The other comment was about hw-romcode not being a very good
> name, as it apparently means the 1bit hamming code and ECC layout used
> on the older omap3, and not E.G. the bch8/elm layout used by
> E.G. am335x.

So which name would you pick? "bch1"?

> As discussed elsewhere, the elm also changes the ECC layout, so why not
> just have bchN (software bchN layout) / bchN-elm selections instead of
> the seperate ti,nand-ecc-use-elm?

Avinash - what do you think?


Thanks for the feedback - I'd also like to get these bindings right in
the first place.


Daniel

