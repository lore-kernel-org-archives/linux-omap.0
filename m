From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] Fix to support multiple HWMODS for a single device
Date: Tue, 24 Aug 2010 13:51:57 +0200
Message-ID: <4C73B25D.5040609@ti.com>
References: <1282647790-15821-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50813 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab0HXLwE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Aug 2010 07:52:04 -0400
In-Reply-To: <1282647790-15821-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

+ Paul

Hi Vijay,

I just have a couple of minors comments.

You should copy at least the file authors when submitting a patch. Paul 
is missing.

You should correct the subject with something like:
[PATCH] OMAP: omap_device: Fix to support multiple hwmods for a single 
device

On 8/24/2010 1:03 PM, ABRAHAM, KISHON VIJAY wrote:
> Currently there is a bug in the existing omap_device core code when
> extracting the hwmod structures passed to omap_device_build_ss(). This bug
> gets exposed only when passing multiple HWMOD structure to
> omap_device_build_ss() resulting in incorrect extraction from second HWMOD
> structure.
>
> This fix uses the pointer to  pointer to OMAP_HWMOD structure (array of
Remove the space here --------^

> pointers to OMAP_HWMOD structure) passed to omap_device_build_ss() to
> correctly extract the appropriate OMAP_HWMOD structure.

All OMAP_HWMOD structure should be in lower case.

>
> This patch has been created and tested on lo/master and mainline.
>
> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>

Add Paul & Kevin in CC here after your signed-off. You can add myself as 
well, since I reviewed your first RFC.

Otherwise the patch looks fine to me.

Thanks,
Benoit

> ---
>   arch/arm/plat-omap/omap_device.c |   35 ++++++++++++++---------------------
>   1 files changed, 14 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index d2b1609..2dd2a46 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -257,12 +257,11 @@ static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
>    */
>   int omap_device_count_resources(struct omap_device *od)
>   {
> -	struct omap_hwmod *oh;
>   	int c = 0;
>   	int i;
>
> -	for (i = 0, oh = *od->hwmods; i<  od->hwmods_cnt; i++, oh++)
> -		c += omap_hwmod_count_resources(oh);
> +	for (i = 0; i<  od->hwmods_cnt; i++)
> +		c += omap_hwmod_count_resources(od->hwmods[i]);
>
>   	pr_debug("omap_device: %s: counted %d total resources across %d "
>   		 "hwmods\n", od->pdev.name, c, od->hwmods_cnt);
> @@ -289,12 +288,11 @@ int omap_device_count_resources(struct omap_device *od)
>    */
>   int omap_device_fill_resources(struct omap_device *od, struct resource *res)
>   {
> -	struct omap_hwmod *oh;
>   	int c = 0;
>   	int i, r;
>
> -	for (i = 0, oh = *od->hwmods; i<  od->hwmods_cnt; i++, oh++) {
> -		r = omap_hwmod_fill_resources(oh, res);
> +	for (i = 0; i<  od->hwmods_cnt; i++) {
> +		r = omap_hwmod_fill_resources(od->hwmods[i], res);
>   		res += r;
>   		c += r;
>   	}
> @@ -566,7 +564,6 @@ int omap_device_shutdown(struct platform_device *pdev)
>   {
>   	int ret, i;
>   	struct omap_device *od;
> -	struct omap_hwmod *oh;
>
>   	od = _find_by_pdev(pdev);
>
> @@ -579,8 +576,8 @@ int omap_device_shutdown(struct platform_device *pdev)
>
>   	ret = _omap_device_deactivate(od, IGNORE_WAKEUP_LAT);
>
> -	for (i = 0, oh = *od->hwmods; i<  od->hwmods_cnt; i++, oh++)
> -		omap_hwmod_shutdown(oh);
> +	for (i = 0; i<  od->hwmods_cnt; i++)
> +		omap_hwmod_shutdown(od->hwmods[i]);
>
>   	od->_state = OMAP_DEVICE_STATE_SHUTDOWN;
>
> @@ -692,11 +689,10 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
>    */
>   int omap_device_enable_hwmods(struct omap_device *od)
>   {
> -	struct omap_hwmod *oh;
>   	int i;
>
> -	for (i = 0, oh = *od->hwmods; i<  od->hwmods_cnt; i++, oh++)
> -		omap_hwmod_enable(oh);
> +	for (i = 0; i<  od->hwmods_cnt; i++)
> +		omap_hwmod_enable(od->hwmods[i]);
>
>   	/* XXX pass along return value here? */
>   	return 0;
> @@ -710,11 +706,10 @@ int omap_device_enable_hwmods(struct omap_device *od)
>    */
>   int omap_device_idle_hwmods(struct omap_device *od)
>   {
> -	struct omap_hwmod *oh;
>   	int i;
>
> -	for (i = 0, oh = *od->hwmods; i<  od->hwmods_cnt; i++, oh++)
> -		omap_hwmod_idle(oh);
> +	for (i = 0; i<  od->hwmods_cnt; i++)
> +		omap_hwmod_idle(od->hwmods[i]);
>
>   	/* XXX pass along return value here? */
>   	return 0;
> @@ -729,11 +724,10 @@ int omap_device_idle_hwmods(struct omap_device *od)
>    */
>   int omap_device_disable_clocks(struct omap_device *od)
>   {
> -	struct omap_hwmod *oh;
>   	int i;
>
> -	for (i = 0, oh = *od->hwmods; i<  od->hwmods_cnt; i++, oh++)
> -		omap_hwmod_disable_clocks(oh);
> +	for (i = 0; i<  od->hwmods_cnt; i++)
> +		omap_hwmod_disable_clocks(od->hwmods[i]);
>
>   	/* XXX pass along return value here? */
>   	return 0;
> @@ -748,11 +742,10 @@ int omap_device_disable_clocks(struct omap_device *od)
>    */
>   int omap_device_enable_clocks(struct omap_device *od)
>   {
> -	struct omap_hwmod *oh;
>   	int i;
>
> -	for (i = 0, oh = *od->hwmods; i<  od->hwmods_cnt; i++, oh++)
> -		omap_hwmod_enable_clocks(oh);
> +	for (i = 0; i<  od->hwmods_cnt; i++)
> +		omap_hwmod_enable_clocks(od->hwmods[i]);
>
>   	/* XXX pass along return value here? */
>   	return 0;

