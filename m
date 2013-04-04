From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
Date: Thu, 4 Apr 2013 16:42:32 +0530
Message-ID: <515D6020.2030103@ti.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com> <20130401170539.GK10155@atomide.com> <515BA76D.3000302@ti.com> <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40444 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757405Ab3DDLKg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 07:10:36 -0400
In-Reply-To: <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Kristo, Tero" <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Anna, Suman" <s-anna@ti.com>

+ Tero and few more TI folks,

On Thursday 04 April 2013 01:12 AM, Paul Walmsley wrote:
> Hi Santosh
> 
> On Wed, 3 Apr 2013, Santosh Shilimkar wrote:
> 
>> Thes patchset has already missed last couple of merge windows and its the
>> biggest bottleneck in getting OMAP5 booting from mainline. So I request
>> you to please have a look it quickly so that Tony can line that up for
>> 3.10.
> 
> Looks like there are a few minor issues with the patches based on a quick 
> look.  I'll post those to the list shortly; they should be easy to fix.  
> But those issues aren't my real concern with this series.
> 
> What's harder to fix are the underlying process issues.  My main concern 
> is that these patches add almost 9,000 lines of code and data.  We've 
> received clear guidance from the upstream ARM SoC maintainers that any 
> significant new additions need to be balanced with moving a similar number 
> of lines of code and data out of arch/arm/{plat-,mach-}* into drivers/.  
> (Or the new patches should be accompanied with patches that show obvious 
> progress towards the goal of moving code and data out of 
> arch/arm/{plat-,mach-}*.)  We need to see more help from TI on the 
> prerequisites for this cleanup process.
>
I agree that we are not making faster progress but as part of the
$subject series itself, for DT only build, we removed around ~4000
lines of data from hwmod. After the merge window, we can trim
the AM33XX and then later OMAP4 when it is made DT only support.
That should give us another 6000 lines of negative diff.
At the same time removal of MUX data for OMAP4 should be
around 2000 lines of negative diff.

You might also notice, we dropped OMAP5 clock data considering
its move under drivers/clk/. Rajendra and Tero already posted
patches [1] for the same on the list. Ofcourse your feedback is
needed to make progress there.

> For example, as discussed last year with the TI upstream PM team, an 
> important first step in this process in my view is to get rid of the 
> direct PRM/CM register accesses in the OMAP PM code.  See commit 
> c4ceedcb18cf7a06059482a3a1828b9aad9f78cf ("ARM: OMAP2+: CM/clock: convert 
> _omap2_module_wait_ready() to use SoC-independent CM functions") as an 
> example of this process.  This should make it easier to get the PRM/CM 
> functionality into drivers/.  That in turn make it possible to move the 
> clockdomain, clock, powerdomain, and hwmod code to drivers/.ARM: OMAP2+: 
> CM/clock: convert _omap2_module_wait_ready() to use SoC-independent CM 
> functions.  So far as I can tell, there hasn't been any forward progress 
> on this.
>
On this part as well after my discussion with Tony, Tero picked it up
and he and Eduardo posted questions to you [2] considering you
already had some WIP patches as we learned from Tony. I suggest
you send any information on this to "Tero" since he is leading the
PM effort and has plans to work on these items.
 
> It's also necessary to see more TI contributions in finding and fixing 
> regressions.  Detecting and fixing regressions from the previous kernel 
> release should be done first, before working on cleanup series or new 
> feature/SoC additions.  Looking at the list of v3.9-rc regressions that 
> I've found, we've gotten very little organized help from TI on dealing 
> with them.  
> 
> This in turn robs the maintainers of time that could be spent doing patch 
> review or further cleanup work, which benefits no one in the end.  
> Ideally each regression would be assigned to a member of the TI upstream 
> team, and the whole process could be completed within one or two weeks.
>
I agree with you overall. 

On couple of specific issues though,

- BOOT-Loader version:  IMHO boot-loader should be upgraded here.
We always upgrade kernel for new/fixed features and bootloader should
be no exception.

- Co-processor Power issue: This one is also has boot-loader dependency
but here too, going on path where firmware needs to be loaded to idle
them isn't great idea. We never did that for OMAP2/3 where DSP, Tesla
was present. IMO, we should not bring these devices out of reset and
let the "remote_proc()" frame works take care of them when it is
available in kernel. Suman from TI is working on it to enable that.
 
> ...
> 
> So from my point of view, I'd like to see the following changes before we 
> accept any new patchsets that add a significant number of lines:
> 
> 1. Organized help from TI in finding and fixing regressions in the -rc 
> cycle, with the regressions dealt with before any new feature 
> pull-requests are sent
>
Agreed. Tero can help here to streamline the process for PM regressions.
Rest of the core regressions and MPU PM, feel free to pass it on to
Rajendra/me. We will try to address them on priority.

 
> 2. Help from TI on some of the cleanup work that we've mentioned in the 
> past, starting with the PRM/CM register access cleanup inside mach-omap2/
> 
Absolutely. As I mentioned earlier, Eduardo and Tero are waiting for your
inputs on this topic.

> 3. Pairing any large feature or SoC additions with at least an equal 
> removal of lines of code
> 
As listed in beginning of the email, there is an effort going on in this
direction. In fact removal of lines of code has to happen even without
any new feature. As Tony mentioned in past, we eventually want to support
DT only builds and that should also allow us significant loc removal
opportunity. But feel free to suggest ideas if you see more opportunities
apart from the obvious ones.

Thanks for all your help.

Regards,
Santosh

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg87110.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85602.html
