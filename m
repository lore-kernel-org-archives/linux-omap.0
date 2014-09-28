From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: Legacy Code in gpmc-onenand.c
Date: Sun, 28 Sep 2014 21:44:07 +0530
Message-ID: <20140928161407.GA2493@sudip-PC>
References: <5427744E.4040409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58452 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaI1QOU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Sep 2014 12:14:20 -0400
Content-Disposition: inline
In-Reply-To: <5427744E.4040409@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nick <yocto6@gmail.com>
Cc: khilman@deeprootsystems.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Sat, Sep 27, 2014 at 10:37:02PM -0400, nick wrote:
> Greetings Kevin and others,
> I am wondering if the below code is legacy I can remove it as stated it the fix me.
> Cheers Nick 
> else {
>                 /*
>                 * FIX ME: Appears to be legacy code from initial ONENAND commit.
>                 * Unclear what boards this is for and if this can be removed.
>                  */
>                 if (!cpu_is_omap34xx())
>                         onenand_sync.wait_on_read = true;
>         }

the FIX ME does not say that you can remove the code. It says you need to find out that the code is being used by which board. And if you want to remove it then you have to explain why the code is removed , and after removing what will be the effect , and if there is no effect then why there is no effect.

Good Luck.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
