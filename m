From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] OMAP2+: PM: SR: add suspend/resume handlers
Date: Fri, 22 Jul 2011 13:10:53 -0700
Message-ID: <87hb6e13g2.fsf@ti.com>
References: <1311314153-23531-1-git-send-email-nm@ti.com>
	<1311314153-23531-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:56999 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132Ab1GVUK4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 16:10:56 -0400
Received: by mail-yw0-f45.google.com with SMTP id 3so1717532ywb.4
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 13:10:55 -0700 (PDT)
In-Reply-To: <1311314153-23531-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 22 Jul 2011 00:55:53 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Colin <ccross@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Suspend and Resume paths are safe enough to do it in

What is 'it'  ?

> the standard LDM suspend/resume handlers where one can
> sleep. Add suspend/resume handlers for SmartReflex.

Minor comments on the code below, but this changelog doesn't read well,
or at least I can't make any sense of it.

[...]

> @@ -684,6 +685,12 @@ void omap_sr_enable(struct voltagedomain *voltdm)
>  	if (!sr->autocomp_active)
>  		return;
>  
> +	if (sr->is_suspended) {
> +		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
> +		return;
> +	}
> +
> +

extra blank line

>  	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
>  		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
>  			"registered\n", __func__);

[...]

>  static struct platform_driver smartreflex_driver = {
>  	.remove         = omap_sr_remove,
> +	.suspend	= omap_sr_suspend,
> +	.resume		= omap_sr_resume,

You're using the legacy methods here, please use dev_pm_ops.

That means you'll need to create a struct dev_pm_ops and fill in these
mehods there (and note the dev_pm_ops methods don't have a 'state'
argument.

Also, when implementing suspend/resume, you need to make sure the
hibernate callbacks are populated also.  They should be populated with
the same callbacks, so the best way to do this is to use
SIMPLE_DEV_PM_OPS() (see <linux/pm.h>).  That macro also takes care of
the !CONFIG_PM case as well.

IOW, the result would look someting like this (not even compile tested):

static SIMPLE_DEV_PM_OPS(omap_sr_pm_ops, omap_sr_suspend, omap_sr_resume)

static struct platform_driver smartreflex_driver = {
	.remove         = omap_sr_remove,
	.driver		= {
		.name	= "smartreflex",
                .pm     = &omap_sr_pm_ops,
	},
};

Kevin
