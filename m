From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2 PM: do RCU locking for opp_get_voltage()
Date: Tue, 14 Feb 2012 10:48:37 -0800
Message-ID: <87sjid6yka.fsf@ti.com>
References: <1329122644-7121-1-git-send-email-arnout@mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:35336 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754994Ab2BNSsm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 13:48:42 -0500
Received: by mail-pw0-f45.google.com with SMTP id ro12so741485pbb.32
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 10:48:41 -0800 (PST)
In-Reply-To: <1329122644-7121-1-git-send-email-arnout@mind.be> (Arnout
	Vandecappelle's message of "Mon, 13 Feb 2012 09:44:04 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Thara Gopinath <thara@ti.com>, Russell King <linux@arm.linux.org.uk>, Philip Oberstaller <philip.oberstaller@septentrio.com>

"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be> writes:

> From: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
>
> According to the documentation of opp_get_voltage(), it must be called
> with rcu_read_lock() held.  The OMAP2 power manager doesn't do this.
> The locking error is caught by PROVE_RCU.
>
> Signed-off-by: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>

Thanks for the patch, I've got a patch from Neil Brown queued for this
already:

       http://marc.info/?l=linux-omap&m=132608991812586&w=2

Kevin

> ---
> Please CC me, I'm not on the list.
>
> I was very surprised by this error, because this is the only user of
> opp_get_voltage().
>
> Regards,
> Arnout
> ---
>  arch/arm/mach-omap2/pm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 00bff46..bce2bdc 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -174,14 +174,17 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
>  	freq = clk->rate;
>  	clk_put(clk);
>  
> +	rcu_read_lock();
>  	opp = opp_find_freq_ceil(dev, &freq);
>  	if (IS_ERR(opp)) {
>  		pr_err("%s: unable to find boot up OPP for vdd_%s\n",
>  			__func__, vdd_name);
> +		rcu_read_unlock();
>  		goto exit;
>  	}
>  
>  	bootup_volt = opp_get_voltage(opp);
> +	rcu_read_unlock();
>  	if (!bootup_volt) {
>  		pr_err("%s: unable to find voltage corresponding "
>  			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);
