From: Rob Landley <rob@landley.net>
Subject: Re: [CFT 11/11] Add feature removal of old OMAP private DMA implementation
Date: Fri, 08 Jun 2012 13:37:11 -0500
Message-ID: <4FD24657.5020207@landley.net>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk> <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36341 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab2FHTAC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 15:00:02 -0400
Received: by obbtb18 with SMTP id tb18so2771709obb.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 12:00:02 -0700 (PDT)
In-Reply-To: <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-doc@vger.kernel.org

On 06/07/2012 06:09 AM, Russell King wrote:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/feature-removal-schedule.txt |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 56000b3..1f7ba35 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -612,3 +612,14 @@ When:	June 2013
>  Why:	Unsupported/unmaintained/unused since 2.6
>  
>  ----------------------------
> +
> +What:	OMAP private DMA implementation
> +When:	2013
> +Why:	We have a DMA engine implementation; all users should be updated
> +	to use this rather than persisting with the old APIs.  The old APIs
> +	block merging the old DMA engine implementation into the DMA
> +	engine driver.
> +Who:	Russell King <linux@arm.linux.org.uk>,
> +	Santosh Shilimkar <santosh.shilimkar@ti.com>
> +
> +----------------------------

Whose tree do feature-removal-schedule patches go in through?

(They're not really documentation, they're design coordination/logistics.)

Rob

-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
