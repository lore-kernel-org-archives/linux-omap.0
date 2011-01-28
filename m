From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v10 00/18] OMAP2,3: hwmod DSS Adaptation
Date: Fri, 28 Jan 2011 14:01:40 +0200
Message-ID: <1296216100.22621.6.camel@tubuntu>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	 <87mxmq6k2g.fsf@ti.com>  <20110125170331.GM13589@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:59385 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562Ab1A1MBu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 07:01:50 -0500
In-Reply-To: <20110125170331.GM13589@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Sumit Semwal <sumit.semwal@ti.com>, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 2011-01-25 at 09:03 -0800, ext Tony Lindgren wrote:
> * Kevin Hilman <khilman@ti.com> [110124 13:56]:
> > Sumit Semwal <sumit.semwal@ti.com> writes:
> > 
> > > v10 of the patch series corrects return-error handling from platform_request_irq()
> > > based on comments from Sergei Shtylyov and Russell King.
> > > [https://patchwork.kernel.org/patch/497911/]
> > 
> > Tony,
> > 
> > Assuming Tomi is OK with this series, I think these are ready to go into
> > omap-testing for some broader testing.
> 
> I can merge in Tomi's branch for testing once Tomi is happy with them.

I've applied the patch set to my tree:

git://gitorious.org/linux-omap-dss2/linux.git master

It compiles, but due to this being my last day in Nokia, I don't have
equipment to test it. It's also missing my signed-offs.

I haven't been able to review the latest versions of the patch set, so
these patches may not be the final versions. However, everything looked
pretty good a few versions ago, so I don't expect any bigger changes.

It's up to Tony if he wants to merge the branch, even if it may not be
the very final version. I will get back to these patches when my
situation clears up, which may take a bit over a week or so.

 Tomi


