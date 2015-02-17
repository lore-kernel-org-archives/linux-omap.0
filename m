From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 4/4] ARM OMAP2+ GPMC: add bus children
Date: Tue, 17 Feb 2015 16:15:48 +0200
Message-ID: <54E34D14.8080901@ti.com>
References: <1424101741-24152-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424101741-24152-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424101741-24152-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424101741-24152-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<1424101741-24152-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>	<54E30CD6.6020905@ti.com> <CAMdRc4FXv1sgAJEOO410Z9YT1gdYUyfzfo__fn2gFaaRKa2jAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMdRc4FXv1sgAJEOO410Z9YT1gdYUyfzfo__fn2gFaaRKa2jAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Cc: khilman@deeprootsystems.com, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 17/02/15 15:57, Robert Abel wrote:
> Hi Roger,
> 
> On Tue, Feb 17, 2015 at 10:41 AM, Roger Quadros <rogerq@ti.com> wrote:>
>> Can we simply use only
>> of_platform_populate(child, NULL, NULL, &pdev->dev)
>>
>> That way we get rid of the if..else and let OF core take care of
>> creating buses or devices.
> 
> Surely, you mean
> 
>> of_platform_populate(child, of_default_bus_match_table, NULL, &pdev->dev);
> 
> ? If matches is NULL, we won't match any busses. Or did you mean to
> just replace the second conditional?

I was wondering if just one call to of_platform_populate() is sufficient.
so you probably need "of_default_bus_match_table" for matches.

> 
> I'll try that and see it works.
> 

cheers,
-roger
