From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/2] GPIO-OMAP: Adjustments for omap_gpio_probe()
Date: Mon, 12 Feb 2018 11:33:02 -0600
Message-ID: <f6e04efd-061e-a534-c821-ac717d90904b@ti.com>
References: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 02/10/2018 03:05 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Feb 2018 21:56:54 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>    Delete an error message for a failed memory allocation
>    Improve a size determination
> 
>   drivers/gpio/gpio-omap.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 

For series:
Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
