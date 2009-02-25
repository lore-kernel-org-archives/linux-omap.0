From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/2] twl: usb: Add the resume() and suspend() methods
	to twl4030-usb.c
Date: Wed, 25 Feb 2009 13:44:25 +0200
Message-ID: <20090225114419.GL16942@scadufax.research.nokia.com>
References: <4d34a0a70902250355q4b8c54e4rc9bbc1f40539e486@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64107 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616AbZBYMAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 07:00:41 -0500
Content-Disposition: inline
In-Reply-To: <4d34a0a70902250355q4b8c54e4rc9bbc1f40539e486@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kim Kyuwon <chammoru@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>, "q1.kim@samsung.com" <q1.kim@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>

On Wed, Feb 25, 2009 at 12:55:41PM +0100, ext Kim Kyuwon wrote:
> +int twl4030_usb_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +       struct twl4030_usb *twl = platform_get_drvdata(pdev);
> +
> +       if (!twl->suspend_enabled)
> +               return 0;
> +
> +       twl->otg.set_suspend(&twl->otg, 1);

otg_set_suspend(otg, 1);

> +
> +       return 0;
> +}
> +
> +int twl4030_usb_resume(struct platform_device *pdev)
> +{
> +       struct twl4030_usb *twl = platform_get_drvdata(pdev);
> +
> +       twl->otg.set_suspend(&twl->otg, 0);

otg_set_suspend(otg, 0);

-- 
balbi
