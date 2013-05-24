From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/3] drivers: regulator: palmas: add an API to set/clear
 the switch bit on SMPS10
Date: Fri, 24 May 2013 19:09:14 +0400
Message-ID: <519F829A.6070604@cogentembedded.com>
References: <1369405896-30246-1-git-send-email-kishon@ti.com> <1369405896-30246-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369405896-30246-2-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 24-05-2013 18:31, Kishon Vijay Abraham I wrote:

> From: Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>

> Added an API to set/clear the switch bit on SMPS10 which can be used by
> palmas usb. The switch bit should be set in order for palmas to
> supply VBUS and is needed when OMAP is acting as USB HOST.

> Signed-off-by: Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/regulator/palmas-regulator.c | 26 ++++++++++++++++++++++++++
>   include/linux/mfd/palmas.h           |  2 ++
>   2 files changed, 28 insertions(+)

> diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
> index 92ceed0..d57ab55 100644
> --- a/drivers/regulator/palmas-regulator.c
> +++ b/drivers/regulator/palmas-regulator.c
> @@ -465,6 +465,32 @@ static int palmas_smps_set_ramp_delay(struct regulator_dev *rdev,
>   	return ret;
>   }
>
> +/**
> + * palmas_set_switch_smps10() - set or clear the switch bit on SMPS10
> + * @param palmas pointer to the palmas mfd structure
> + * @param sw boolean to indicate switch status

    Please follow the kernel-doc style described in 
Documentation/kernel-doc-nano-HOWTO.txt.

[...]

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
