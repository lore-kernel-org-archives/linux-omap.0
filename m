From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: fix build error for missing variable
Date: Mon, 12 Jul 2010 18:14:47 -0500
Message-ID: <4C3BA1E7.1070607@ti.com>
References: <1278975385-7769-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278975385-7769-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Menon, Nishanth had written, on 07/12/2010 05:56 PM, the following:
> Commit:
> staging: tidspbridge: gen: simplify and clean up
> There is recently added hex_to_bin() kernel's method which we could use
> instead of custom long function.
> 
> Introduced usage of hex_to_bin without defining the temp variable.
> this causes the build error:
> drivers/staging/tidspbridge/gen/uuidutil.c: In function 'uuid_hex_to_bin':
> drivers/staging/tidspbridge/gen/uuidutil.c:63: error: 'value' undeclared (first use in this function)
> drivers/staging/tidspbridge/gen/uuidutil.c:63: error: (Each undeclared identifier is reported only once
> drivers/staging/tidspbridge/gen/uuidutil.c:63: error: for each function it appears in.)
> 
> introduce variable value to fix the error.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/staging/tidspbridge/gen/uuidutil.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/tidspbridge/gen/uuidutil.c b/drivers/staging/tidspbridge/gen/uuidutil.c
> index eb09bc3..070761b 100644
> --- a/drivers/staging/tidspbridge/gen/uuidutil.c
> +++ b/drivers/staging/tidspbridge/gen/uuidutil.c
> @@ -58,6 +58,7 @@ static s32 uuid_hex_to_bin(char *buf, s32 len)
>  {
>  	s32 i;
>  	s32 result = 0;
> +	int value;
>  
>  	for (i = 0; i < len; i++) {
>  		value = hex_to_bin(*buf++);
arrgh.. just saw https://patchwork.kernel.org/patch/111141/ - please 
consider the same and drop this patch. apologies on the noise.

-- 
Regards,
Nishanth Menon
