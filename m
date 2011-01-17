From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] arm: mach-omap2: potential NULL dereference
Date: Mon, 17 Jan 2011 15:30:56 +0300
Message-ID: <4D343680.1030701@ru.mvista.com>
References: <1295258922-31242-1-git-send-email-segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295258922-31242-1-git-send-email-segoon@openwall.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: kernel-janitors@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 17-01-2011 13:08, Vasiliy Kulikov wrote:

> kzalloc() may fail, if so return -ENOMEM.

> Signed-off-by: Vasiliy Kulikov<segoon@openwall.com>
[...]

> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 77ecebf..871bca9 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -260,7 +260,10 @@ static int sr_late_init(struct omap_sr *sr_info)
>   	if (sr_class->class_type == SR_CLASS2&&
>   		sr_class->notify_flags&&  sr_info->irq) {
>
> +		ret = -ENOMEM;
>   		name = kzalloc(SMARTREFLEX_NAME_LEN + 1, GFP_KERNEL);
> +		if (name == NULL)
> +			goto error;

    Why not:

		if (name == NULL) {
			ret = -ENOMEM;
			goto error;
		}

WBR, Sergei
