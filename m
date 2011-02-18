From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] OMAP2+: hwmod: Avoid setup if clock lookup failed
Date: Fri, 18 Feb 2011 18:34:34 +0100
Message-ID: <4D5EADAA.7010007@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com> <1297858285-7056-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36330 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1BRRem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 12:34:42 -0500
In-Reply-To: <1297858285-7056-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2/16/2011 1:11 PM, Nayak, Rajendra wrote:
> Add a hwmod state check in the _setup function
> to avoid setting up hwmods' for which clock
> lookup has failed.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |    6 ++++++
>   1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e282e35..cd9dcde 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1362,6 +1362,12 @@ static int _setup(struct omap_hwmod *oh, void *data)
>   	int i, r;
>   	u8 postsetup_state;
>
> +	if (oh->_state != _HWMOD_STATE_CLKS_INITED) {
> +		WARN(1, "omap_hwmod: %s: _setup failed as one or more"
> +		     "clock lookups' have failed\n", oh->name);

Maybe a pr_warning will be enough for that?

> +		return -EINVAL;

As discussed previously I'd prefer to return 0 here since we do not want 
to break the iteration.

> +	}
> +
>   	/* Set iclk autoidle mode */
>   	if (oh->slaves_cnt>  0) {
>   		for (i = 0; i<  oh->slaves_cnt; i++) {

Otherwise it is fine for me.

Thanks,
Benoit
