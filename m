From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 7/7] omap: mailbox: remove unreachable return
Date: Sat, 06 Nov 2010 14:21:39 -0400
Message-ID: <4CD59CB3.2060306@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com> <1289006244-27147-8-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50043 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab0KFSU2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Nov 2010 14:20:28 -0400
In-Reply-To: <1289006244-27147-8-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
> Remove unreachable return statement.
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> ---
>   arch/arm/mach-omap2/mailbox.c |    2 --
>   1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 5e9ea0f..335eb2b 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -434,8 +434,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>   		return ret;
>   	}

Please add a blank line here.

Otherwise you can add: Acked-by: Benoit Cousson <b-cousson@ti.com>

Thanks,
Benoit

>   	return 0;
> -
> -	return ret;
>   }
>
>   static int __devexit omap2_mbox_remove(struct platform_device *pdev)

