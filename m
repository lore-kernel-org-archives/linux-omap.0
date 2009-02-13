From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] Removal of duplicate cbus entry
Date: Fri, 13 Feb 2009 09:23:00 +0200
Message-ID: <20090213092300.1b9a5d38.jarkko.nikula@nokia.com>
References: <499442C9.7030406@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24907 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZBMHXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 02:23:53 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1D7Nk9p015283
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 09:23:50 +0200
In-Reply-To: <499442C9.7030406@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 12 Feb 2009 16:39:53 +0100
"Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com> wrote:

> Removal of duplicate cbus entry.
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>   drivers/Makefile |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 67de08b..1eff6ed 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -41,7 +41,6 @@ obj-y                         += serial/
>   obj-$(CONFIG_PARPORT)         += parport/
>   obj-y                         += base/ block/ misc/ mfd/ net/
> media/ cbus/ obj-y                         += i2c/
> -obj-y                          += cbus/
>   obj-$(CONFIG_NUBUS)           += nubus/

Patch is somehow malformatted. It doesn't apply because of extra space
in beginning of each non-changed line.

Notes:

Even this is linux-omap specific only since the cbus is not in mainline,
subject needs "ARM: OMAP " prefix so it's easy to see for what
subsystem the patch is.

For this patch subject is descriptive enough. No need for duplicated
comment.

Probably Tony would like that duplicated cbus is removed from the line
where are those other directories and to keep cbus in it's own line for
avoiding possible merge conflicts in the future?


Jarkko
