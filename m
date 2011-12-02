From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC PATCH v1 2/7] omap4: build fdif omap device from hwmod
Date: Fri, 02 Dec 2011 16:10:17 +0400
Message-ID: <4ED8C029.7000004@ru.mvista.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com> <1322817178-8931-3-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:60542 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753795Ab1LBMLQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 07:11:16 -0500
In-Reply-To: <1322817178-8931-3-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 02-12-2011 13:12, Ming Lei wrote:

> Signed-off-by: Ming Lei<ming.lei@canonical.com>
> ---
>   arch/arm/mach-omap2/devices.c |   33 +++++++++++++++++++++++++++++++++
>   1 files changed, 33 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 1166bdc..a392af5 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -728,6 +728,38 @@ void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
>
>   #endif
>
> +static struct platform_device* __init omap4_init_fdif(void)

    Shouldn't there be space before *? checkpatch.pl is silent about it?
ALso, I'd have placed '__init' after 'static'...

> +{
> +	int id = -1;
> +	struct platform_device *pd;
> +	struct omap_hwmod *oh;
> +	const char *dev_name = "fdif";

    Why you need this variable at all?

WBR, Sergei

