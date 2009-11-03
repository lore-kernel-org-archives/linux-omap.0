From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please advise on modifying defconfig for Amstrad Delta
Date: Tue, 3 Nov 2009 09:24:00 -0800
Message-ID: <20091103172400.GM8981@atomide.com>
References: <200910250340.34046.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58281 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbZKCRYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 12:24:04 -0500
Content-Disposition: inline
In-Reply-To: <200910250340.34046.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091024 19:41]:
> Hi,
> 
> I'm just working on a new, updated version of ams_delta_defconfig. Starting from the current version, created over 2 years ago for 2.6.22, I turned on a few device drivers that was added recently, turned on thumb instructions support, turned on EABI, kept old ABI compatibility and NWFPE, and got a resulting kernel that is ~170kB too large to be successfully booted using tools available at http://the.earth.li/pub/e3/.
> 
> Of course, I am able to trim that down, even adding a few more drivers for add-on hardware that I am using, and get a kernel that works perfectly for me, but since I have never prepared a default config, I'd like to get your advice on what I can remove and what should rather be kept untouched.
> 
> Instead of pasting sixteen hundred lines here, I'd rather ask about the simplest change I can see:
> 
> -# CONFIG_EMBEDDED is not set
> -CONFIG_KALLSYMS=y
> +CONFIG_EMBEDDED=y
> +# CONFIG_KALLSYMS is not set
> 
> That would give me a kernel that is small enough, but since only a few of arm defconfigs have CONFIG_KALLSYMS not set, I am not sure if it is generally acceptable.

Send that as a fix to this list with the minimal changes,
we should still be able to get it in as a fix during the -rc
series.

If you want to update the whole defconfig, we need to wait
for the merge window.

Just do the diff -u, then edit the patch to leave out all
the other hunks except the one above.

Regards,

Tony
