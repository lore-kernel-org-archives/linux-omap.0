From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc5 0/5] twl4030 irq assignments
Date: Tue, 25 Nov 2008 15:31:10 -0800
Message-ID: <20081125233108.GB11997@atomide.com>
References: <200811191709.28974.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63160 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYKYXbK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 18:31:10 -0500
Content-Disposition: inline
In-Reply-To: <200811191709.28974.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081119 17:34]:
> The following patches remove some needless dependencies from
> TWL4030 support, supporting non-OMAP builds and in some cases,
> non-SDP (etc) builds.
> 
>  - keypad driver ... use platform_get_irq(), no board dependencies
>  - BCI driver ... likewise
>  - MADC driver ... use platform_get_irq()
>  - power button ... still pretty hacky, there's no device here
>  - removes the now-dead symbols, and OMAP-dependency
> 
> Build-tested.
> 
> With this, I think the keypad driver becomes ready to go upstream,
> after related twl4030-core updates.  At least, it's ready for review.
> (Including:  Why pass the keypad module id to kpread/kpwrite, it's
> the only one ever used?  Why does Kconfig mention GPIOs, since they
> aren't used?)
> 
> The point of these patches is that last one, which lets non-OMAP
> folk do test builds and easily make updates when APIs change.
> Yeah, it's a strange notion, but not everyone does OMAP builds.  ;)

Pushing these to l-o tree today.

Tony
