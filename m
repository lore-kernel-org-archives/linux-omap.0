From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fwd: Workaround for hanging u-boot 'Load Address: fffffff2'
Date: Mon, 14 Jan 2013 08:27:43 -0800
Message-ID: <20130114162743.GR14149@atomide.com>
References: <CABJxTWFKCxS=syoFCyRyCMdJmwMg_yLq3pOMfr9MhCO7g=Rtzg@mail.gmail.com>
 <CABJxTWGmmZ55GE7YiwVCCj8JmofQBF_wc-Q9PBtfQW-uarJhDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:55280 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756778Ab3ANQ1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jan 2013 11:27:45 -0500
Content-Disposition: inline
In-Reply-To: <CABJxTWGmmZ55GE7YiwVCCj8JmofQBF_wc-Q9PBtfQW-uarJhDg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kiril Maler <kiril.maler@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Kiril Maler <kiril.maler@gmail.com> [130114 01:05]:
> ---------- Forwarded message ----------
> From: Kiril Maler <kiril.maler@gmail.com>
> Date: 14 January 2013 09:46
> Subject: Workaround for hanging u-boot 'Load Address: fffffff2'
> To: "davinci-linux-open-source@linux.davincidsp.com"
> <davinci-linux-open-source@linux.davincidsp.com>
> 
> 
> If your fresh uImage hangs in a similar way:
> 
> ## Booting kernel from Legacy Image at 81000000 ...
>    Image Name:   Linux-3.8.0-rc2-tst04+
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1161118 Bytes = 1.1 MiB
>    Load Address: fffffff2
>    Entry Point:  fffffff2
>    Verifying Checksum ... OK
>    Loading Kernel Image ...

This is because we've now enabled the multiplatform support,
and you need to run mkimage manually as noted in the signed
tag omap-for-v3.9/multiplatform-enable-signed-v2.
 
> Then a temporary fix could be added in arch/arm/boot/Makefile
> 
> git diff  arch/arm/boot/Makefile
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index abfce28..4182943 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -13,6 +13,8 @@
> 
>  ifneq ($(MACHINE),)
>  include $(srctree)/$(MACHINE)/Makefile.boot
> +else
> +include $(srctree)/arch/arm/mach-omap2/Makefile.boot
>  endif
> 
>  # Note: the following conditions must always be true:
> 
> 
> Change 'mach-omap2' in the patch above to required machine directory
> 
> This is needed because 'MACHINE' in arch/arm/Makefile is
> set empty when CONFIG_ARCH_MULTIPLATFORM=y, and consequently parameters
> -a and -e are empty in arch/arm/boot/.uImage.cmd

We can't do that as then other multiplatform ARM architectures will
break. We should just disable make uImage for CONFIG_ARCH_MULTIPLATFORM
instead.

Regards,

Tony

