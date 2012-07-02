From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP2+: Fix Wake-up power domain power status
Date: Mon, 02 Jul 2012 10:52:32 -0700
Message-ID: <87k3ym6of3.fsf@ti.com>
References: <1341003892-14424-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:38637 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753781Ab2GBRw0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 13:52:26 -0400
Received: by ghrr11 with SMTP id r11so4368781ghr.19
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 10:52:25 -0700 (PDT)
In-Reply-To: <1341003892-14424-1-git-send-email-jon-hunter@ti.com> (Jon
	Hunter's message of "Fri, 29 Jun 2012 16:04:52 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Jon Hunter <jon-hunter@ti.com> writes:

> Note: Re-sending with updated kernel doc.
>
> The wake-up power domain is an alway-on power domain and so this power domain
> does not have a power state status (PM_PWSTST_xxx) register that indicates the
> current state. However, during the registering of the wake-up power domain the
> state of the domain is queried by calling pwrdm_read_pwrst(). This actually
> tries to read a register that does not exist and returns a value of 0 that
> indicates that the current state is OFF. The OFF state count of the wake-up
> power domain is then set to 1 and the current state to OFF. Both of which are
> incorrect.
>
> To fix this, if a power domain only supports the ON state, do not attempt to
> read the power state status register and simply return ON as the current power
> state.
>
> This is based upon Tony's current linux-omap master branch.
>
> Testing:
> - Boot tested on OMAP4460 panda.
> - Boot tested on OMAP3430 beagle and validated CORE RET still working (using
>   Paul's 32k timer patch [1]).
>
> [1] http://marc.info/?l=linux-omap&m=134000053229888&w=2
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>


> ---
>  arch/arm/mach-omap2/powerdomain.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index eefe179..69b36e1 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -526,7 +526,8 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
>   *
>   * Return the powerdomain @pwrdm's current power state.	Returns -EINVAL
>   * if the powerdomain pointer is null or returns the current power state
> - * upon success.
> + * upon success. Note that if the power domain only supports the ON state
> + * then just return ON as the current state.
>   */
>  int pwrdm_read_pwrst(struct powerdomain *pwrdm)
>  {
> @@ -535,6 +536,9 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> +	if (pwrdm->pwrsts == PWRSTS_ON)
> +		return PWRDM_POWER_ON;
> +
>  	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
>  		ret = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
