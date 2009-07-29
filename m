From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH V2 0/32] mmc and omap_hsmmc patches
Date: Wed, 29 Jul 2009 12:13:27 +0100
Message-ID: <20090729111327.GB6057@console-pimps.org>
References: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754125AbZG2LNz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090728103834.2371.65809.sendpatchset@ahunter-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Denis Karpov <ext-denis.2.karpov@nokia.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 28, 2009 at 01:38:34PM +0300, Adrian Hunter wrote:
> Hi
> 
> Here is version 2 of our 32 patches for mmc and omap_hsmmc.
> 
> They include Matt Fleming's change for card caps, and 2 other fixes:
> 	- use a spin lock rather than enable / diable irq
> 	- make disable delay specified in milliseconds not jiffies because the
> 	value is an int, and jiffies are unsigned long (also millisecs are
> 	better anyway)
> 

Thanks for doing this Adrian. I appreciate it. My Reviewed-by tag still
applies.
