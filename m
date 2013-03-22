From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 0/8]: omap4: clk: move clock data under drivers/clk
Date: Fri, 22 Mar 2013 11:32:34 +0200
Message-ID: <1363944754.15426.186.camel@sokoban>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
	 <514BEC05.3050105@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36083 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933343Ab3CVJcm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Mar 2013 05:32:42 -0400
In-Reply-To: <514BEC05.3050105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, "J, Keerthy" <j-keerthy@ti.com>

On Fri, 2013-03-22 at 10:58 +0530, Rajendra Nayak wrote:
> Tero,
> 
> On Thursday 21 March 2013 11:05 PM, Tero Kristo wrote:
> > Hi,
> > 
> > This is an RFC version of the clock data move under drivers/clk.
> > Tested under 3.8 and boots fine, but don't try this out unless
> > you are experimental sort (I quickly tried with 3.9-rc3 and it failed to
> > boot with that.)
> > 
> > The approach taken here has minimal impact on the clock data
> > and should make it easy to transfer clock data for omap2 / omap3 and
> > omap5 also. omap4 was only done as a proof of concept.
> > 
> > Any comments appreciated.
> 
> I strangely only see the cover letter delivered to me and no
> patches. Do you have a branch with the patches which you can
> share?

Keerthy had a similar question. It looks like TI people have had
problems with mailing list subscriptions as of late, and I am actually
also getting moderator bounces for my emails from linux-arm-kernel list
atm.

Anyway, I just pushed a branch here:

git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: linux-3.8-omap4-clk-move

-Tero



