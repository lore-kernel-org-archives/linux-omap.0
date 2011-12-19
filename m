From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 1/3] of/base: Take NULL string into account for property
 with multiple strings
Date: Mon, 19 Dec 2011 08:02:41 -0600
Message-ID: <4EEF4401.1060303@gmail.com>
References: <1323095036-3739-1-git-send-email-b-cousson@ti.com> <1323095036-3739-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54374 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab1LSOC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 09:02:59 -0500
Received: by ghbz12 with SMTP id z12so3472463ghb.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 06:02:58 -0800 (PST)
In-Reply-To: <1323095036-3739-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/05/2011 08:23 AM, Benoit Cousson wrote:
> The current implementation just ignore any NULL string inserted in a
> multiple strings property.
> In some cases we can have a property with a fix number of strings but
> not necessarily used, like for example in a list of valid pinmux modes.
> 
>  prop = "uart_rx", "uart_tx", "", "", "safe_mode";
> 
> Do no skip NULL string and take them into account in
> of_property_read_string_index and of_property_count_strings.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>

Applied. The others need Grant's agreement.

Rob

> ---
>  drivers/of/base.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 9b6588e..b707243 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -752,7 +752,7 @@ int of_property_read_string_index(struct device_node *np, const char *propname,
>  
>  	for (i = 0; total < prop->length; total += l, p += l) {
>  		l = strlen(p) + 1;
> -		if ((*p != 0) && (i++ == index)) {
> +		if (i++ == index) {
>  			*output = p;
>  			return 0;
>  		}
> @@ -790,11 +790,9 @@ int of_property_count_strings(struct device_node *np, const char *propname)
>  
>  	p = prop->value;
>  
> -	for (i = 0; total < prop->length; total += l, p += l) {
> +	for (i = 0; total < prop->length; total += l, p += l, i++)
>  		l = strlen(p) + 1;
> -		if (*p != 0)
> -			i++;
> -	}
> +
>  	return i;
>  }
>  EXPORT_SYMBOL_GPL(of_property_count_strings);

