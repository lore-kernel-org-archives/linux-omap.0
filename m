From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Mon, 13 Feb 2012 16:12:44 -0800
Message-ID: <20120214001244.GL1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com>
 <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
 <20120206181314.GQ1426@atomide.com>
 <20120207101057.GR1275@n2100.arm.linux.org.uk>
 <20120208053213.GB20885@atomide.com>
 <20120213211752.GG1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19234 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab2BNAMq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 19:12:46 -0500
Content-Disposition: inline
In-Reply-To: <20120213211752.GG1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Tony Lindgren <tony@atomide.com> [120213 12:46]:
> 
> Got the compiler build going further with the following fix to
> crosstool-ng in case others are having similar issues. Will send
> that separately to crosstool-ng mailing list.

Looks like that's already in works according to this:

http://sourceware.org/ml/crossgcc/2012-02/msg00048.html

Regards,

Tony

> --- a/scripts/build/debug/200-duma.sh	Thu Feb 02 22:43:18 2012 +0100
> +++ b/scripts/build/debug/200-duma.sh	Mon Feb 13 12:36:06 2012 -0800
> @@ -4,7 +4,7 @@
>      # Downloading an non-existing file from sourceforge will give you an
>      # HTML file containing an error message, instead of returning a 404.
>      # Sigh...
> -    CT_GetFile "duma_${CT_DUMA_VERSION}" .tar.gz http://mesh.dl.sourceforge.net/sourceforge/duma/
> +    CT_GetFile "duma_${CT_DUMA_VERSION}" .tar.gz http://dfn.dl.sourceforge.net/sourceforge/duma/
>      # Downloading from sourceforge may leave garbage, cleanup
>      CT_DoExecLog ALL rm -f "${CT_TARBALLS_DIR}/showfiles.php"*
>  }
> --- a/scripts/build/debug/300-gdb.sh	Thu Feb 02 22:43:18 2012 +0100
> +++ b/scripts/build/debug/300-gdb.sh	Mon Feb 13 12:36:06 2012 -0800
> @@ -62,7 +62,7 @@
>  
>      if [ "${do_expat}" = "y" ]; then
>          CT_GetFile "expat-${CT_DEBUG_GDB_EXPAT_VERSION}" .tar.gz    \
> -                   http://mesh.dl.sourceforge.net/sourceforge/expat/expat/${CT_DEBUG_GDB_EXPAT_VERSION}
> +                   http://dfn.dl.sourceforge.net/sourceforge/expat/expat/${CT_DEBUG_GDB_EXPAT_VERSION}
>      fi
>  }
>  
> --- a/scripts/build/debug/500-strace.sh	Thu Feb 02 22:43:18 2012 +0100
> +++ b/scripts/build/debug/500-strace.sh	Mon Feb 13 12:36:06 2012 -0800
> @@ -1,7 +1,7 @@
>  # Build script for strace
>  
>  do_debug_strace_get() {
> -    CT_GetFile "strace-${CT_STRACE_VERSION}" http://mesh.dl.sourceforge.net/sourceforge/strace/
> +    CT_GetFile "strace-${CT_STRACE_VERSION}" http://dfn.dl.sourceforge.net/sourceforge/strace/
>      # Downloading from sourceforge leaves garbage, cleanup
>      CT_DoExecLog ALL rm -f "${CT_TARBALLS_DIR}/showfiles.php"*
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
