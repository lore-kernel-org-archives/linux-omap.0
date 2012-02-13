From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH v2 2/2] ARM: OMAP: sram: Add am33xx SRAM support
 (minimal)
Date: Mon, 13 Feb 2012 16:07:01 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433179FC35@DBDE01.ent.ti.com>
References: <1329113715-7634-1-git-send-email-afzal@ti.com>
 <87fweeyfp6.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38100 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754835Ab2BMQHS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 11:07:18 -0500
In-Reply-To: <87fweeyfp6.fsf@macbook.be.48ers.dk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>, "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Mon, Feb 13, 2012 at 19:54:05, Peter Korsgaard wrote:
> >>>>> "Afzal" == Afzal Mohammed <afzal@ti.com> writes:
> 
>  Afzal> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>  Afzal> Update SRAM start & size for am33xx SoC's.
> 

This is a really awkward quoting style :|

> 
> I don't particular know the omap sram stuff, but doesn't the 33xx have
> 2x 64K blocks of SRAM?
> 

Yes, but since the lower 64KB will not be available on non-GP device and
only A8 can access it, for now we make use of the higher 64KB which is referred
to as the OCMC RAM in the TRM. This will also enable SRAM usage by other drivers
like PRU and McASP.

>  
>  Afzal> +static inline int am33xx_sram_init(void)
>  Afzal> +{
>  Afzal> +	return 0;
> 
> 
> I know you mentioned it in the commit message, but it might be good with
> a comment here as well that this dummy function is needed to not get the 34xx
> init function called for 33xx, so it doesn't get removed when somebody
> decides to cleanup.

You are right in saying that the dummy function is needed to avoid 34xx SRAM init.
We'll have some PM related code coming in soon and hopefully the SRAM code won't change
Without us noticing ;)

Regards,
Vaibhav B.
