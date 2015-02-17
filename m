From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 4/4] ARM OMAP2+ GPMC: add bus children
Date: Tue, 17 Feb 2015 14:57:18 +0100
Message-ID: <CAMdRc4FXv1sgAJEOO410Z9YT1gdYUyfzfo__fn2gFaaRKa2jAA@mail.gmail.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424101741-24152-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<54E30CD6.6020905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E30CD6.6020905@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Tue, Feb 17, 2015 at 10:41 AM, Roger Quadros <rogerq@ti.com> wrote:>
> Can we simply use only
> of_platform_populate(child, NULL, NULL, &pdev->dev)
>
> That way we get rid of the if..else and let OF core take care of
> creating buses or devices.

Surely, you mean

>of_platform_populate(child, of_default_bus_match_table, NULL, &pdev->dev);

? If matches is NULL, we won't match any busses. Or did you mean to
just replace the second conditional?

I'll try that and see it works.

Regards,

Robert
