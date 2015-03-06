From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/24] ARM: OMAP2+: clock: remove support for legacy
 mpurate command line param
Date: Fri, 6 Mar 2015 08:25:17 -0800
Message-ID: <20150306162516.GN13520@atomide.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
 <1425644939-3232-12-git-send-email-t-kristo@ti.com>
 <20150306153254.GK13520@atomide.com>
 <54F9D160.7010708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery2.ore.mailhop.org ([54.69.130.42]:42304 "EHLO
	pmta2.delivery2.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751430AbbCFQai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 11:30:38 -0500
Received: from smtp6.ore.mailhop.org (172.31.36.112) by pmta2.delivery1.ore.mailhop.org id hv7b4g20u50f for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2015 16:31:04 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <54F9D160.7010708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150306 08:10]:
> On 03/06/2015 05:32 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [150306 04:29]:
> >>The legacy support is wrong and dangerous, as it doesn't take any
> >>OPPs into account and does not scale voltages. Switching mpurate should
> >>be handled through cpufreq.
> >
> >Hmm I wonder if some systems actually rely on the mpurate cmdline
> >parameter. If this cannot be fixed properly, you should at least
> >print an error here.
> 
> Yea, I was kind of worried about this comment. We have also an option of
> doing this through clock driver, but I was hesitant of doing this either.
> Isn't having a global kernel option like this frowned upon anyway? I believe
> this piece of init code gets executed on every board on multiarch kernel.

Well the option has been there probably for 10 years already so we
can't just drop it like that. Chances are it's unused though, so I
suggest you just print out a warning for it.

It's called from omap_arch_initcall which checks for soc_is_omap()
so that's not an issue. But when moving the code, you naturally
need to check the moved code initcall usage.

Regards,

Tony
