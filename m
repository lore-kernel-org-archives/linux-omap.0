From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCHv4 23/35] ARM: OMAP2+: id: cache omap_type value
Date: Wed, 18 Mar 2015 21:24:32 +0300
Message-ID: <5509C2E0.8010705@cogentembedded.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com> <1426689860-17537-24-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33554 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbCRSYg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2015 14:24:36 -0400
Received: by lbnq5 with SMTP id q5so7980276lbn.0
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2015 11:24:34 -0700 (PDT)
In-Reply-To: <1426689860-17537-24-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hello.

On 03/18/2015 05:44 PM, Tero Kristo wrote:

> There is no need to read the register with every invocation of the function,
> as the value is constant. Thus, cache the value in a static variable.

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/id.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 2a2f4d5..1f5949f 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -52,7 +52,10 @@ EXPORT_SYMBOL(omap_rev);
>
>   int omap_type(void)
>   {
> -	u32 val = 0;
> +	static u32 val = OMAP2_DEVICETYPE_MASK + 1;
> +
> +	if (val < OMAP2_DEVICETYPE_MASK)

    <=, perhaps?

> +		return val;
[...]

WBR, Sergei

