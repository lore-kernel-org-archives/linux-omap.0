From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] dspbridge: Simplify Atoi() method
Date: Tue, 9 Feb 2010 20:02:41 -0600
Message-ID: <4B7213C1.1040300@ti.com>
References: <1265192086-15633-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42065 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755112Ab0BJCCr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Feb 2010 21:02:47 -0500
In-Reply-To: <1265192086-15633-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Hi,

On 2/3/2010 4:14 AM, Andy Shevchenko wrote:
> From: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
>
> Try to use simple_strtol() kernel native method instead.

strtol or strtoul?

>
> However, there are opened questions:
>   - why type of Atoi() is s32 if the sign is used only to detect base?
>   - should we really to check hex integers like DEAD0123h?
>   - how many spaces could lead token?
>
> Signed-off-by: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
> ---
>   drivers/dsp/bridge/rmgr/dbdcd.c |   42 +++++---------------------------------
>   1 files changed, 6 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
> index caa57f1..fe2ed57 100644
> --- a/drivers/dsp/bridge/rmgr/dbdcd.c
> +++ b/drivers/dsp/bridge/rmgr/dbdcd.c
> @@ -1002,50 +1002,20 @@ DSP_STATUS DCD_UnregisterObject(IN struct DSP_UUID *pUuid,
>    */
>   static s32 Atoi(char *pszBuf)
>   {
> -	s32 result = 0;
>   	char *pch = pszBuf;
> -	char c;
> -	char first;
> -	s32 base = 10;
> -	s32 len;
> +	s32 base = 0;
>
>   	while (isspace(*pch))
>   		pch++;
>
> -	first = *pch;
> -	if (first == '-' || first == '+') {
> +	if (*pch == '-' || *pch == '+') {
> +		base = 10;
>   		pch++;
> -	} else {
> -		/* Determine if base 10 or base 16 */
> -		len = strlen(pch);
> -		if (len>  1) {
> -			c = pch[1];
> -			if ((*pch == '0'&&  (c == 'x' || c == 'X'))) {
> -				base = 16;
> -				pch += 2;
> -			}
> -			c = pch[len - 1];
> -			if (c == 'h' || c == 'H')
> -				base = 16;
> -
> -		}
> -	}
> -
> -	while (isdigit(c = *pch) || ((base == 16)&&  isxdigit(c))) {
> -		result *= base;
> -		if ('A'<= c&&  c<= 'F') {
> -			c = c - 'A' + 10;
> -		} else {
> -			if ('a'<= c&&  c<= 'f')
> -				c = c - 'a' + 10;
> -			else
> -				c -= '0';
> -		}
> -		result += c;
> -		++pch;
> +	} else if (*pch&&  (pch[strlen(pch) - 1] | 0x20 == 'h')) {

perhaps tolower(x)

otherwise: (pch[strlen(pch) - 1] | 0x20 == 'h')
should be ((pch[strlen(pch) - 1] | 0x20) == 'h')

> +		base = 16;
>   	}
>
> -	return result;
> +	return simple_strtoul(pch, NULL, base);
>   }
>
>   /*

- omar
