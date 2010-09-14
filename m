From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [v4 6/6] OMAP: WDT: Use PM runtime APIs instead of clk FW APIs
Date: Tue, 14 Sep 2010 11:04:47 -0700
Message-ID: <87zkvknqv4.fsf@deeprootsystems.com>
References: <1284390809-11519-1-git-send-email-charu@ti.com>
	<1284390809-11519-7-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36165 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab0INSEw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 14:04:52 -0400
In-Reply-To: <1284390809-11519-7-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Mon, 13 Sep 2010 20:43:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: tony@atomide.com, wim@iguana.be, linux-watchdog@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
> for enabling/disabling the clocks, sysconfig settings instead of using
> clock FW APIs.
>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks mostly good, one minor comment

[...]

> +static int wdt_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int wdt_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops gpio_pm_ops = {
> +	.runtime_suspend = wdt_runtime_suspend,
> +	.runtime_resume	 = wdt_runtime_resume,
> +};
> +

This isn't needed anymore for 2.6.37, a fix for the return values in the
generic runtime PM calls has been queued for 2.6.37[1]

Kevin

[1] https://lists.linux-foundation.org/pipermail/linux-pm/2010-September/028466.html
