From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] memory: omap-gpmc: Delete an unnecessary check before the
 function call "gpiochip_free_own_desc"
Date: Mon, 1 Aug 2016 12:32:34 +0300
Message-ID: <e3aca807-d81b-a7d0-aa8d-3077a54979aa@ti.com>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <e3f6205c-39a0-b9f7-5290-be4c6cbb2f0b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <e3f6205c-39a0-b9f7-5290-be4c6cbb2f0b@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

Hi Markus,

On 23/07/16 20:09, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 23 Jul 2016 18:54:02 +0200
> 
> The gpiochip_free_own_desc() function tests whether its argument is NULL
> and then returns immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/memory/omap-gpmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 869c83f..e138875 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -2143,9 +2143,7 @@ err_child_fail:
>  	ret = -ENODEV;
>  
>  err_cs:
> -	if (waitpin_desc)
> -		gpiochip_free_own_desc(waitpin_desc);
> -
> +	gpiochip_free_own_desc(waitpin_desc);
>  err:
>  	gpmc_cs_free(cs);
>  
> 
This looks good to me. I will queue this for v4.8. Thanks.

cheers,
-roger
