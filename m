From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates
 for 3.10
Date: Fri, 5 Apr 2013 15:42:27 +0300
Message-ID: <1365165747.19492.117.camel@sokoban>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com>
 <20130401170539.GK10155@atomide.com> <515BA76D.3000302@ti.com>
 <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com>
 <515D6020.2030103@ti.com>
Reply-To: t-kristo@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <515D6020.2030103@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, "Anna,
 Suman" <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, "Valentin,
 Eduardo" <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2013-04-04 at 16:42 +0530, Santosh Shilimkar wrote:
> + Tero and few more TI folks,

Hi,

Added some comments below.

> 
> On Thursday 04 April 2013 01:12 AM, Paul Walmsley wrote:
> > Hi Santosh
> > 
> > On Wed, 3 Apr 2013, Santosh Shilimkar wrote:
> > 
> >> Thes patchset has already missed last couple of merge windows and its the
> >> biggest bottleneck in getting OMAP5 booting from mainline. So I request
> >> you to please have a look it quickly so that Tony can line that up for
> >> 3.10.
> > 
> > Looks like there are a few minor issues with the patches based on a quick 
> > look.  I'll post those to the list shortly; they should be easy to fix.  
> > But those issues aren't my real concern with this series.
> > 
> > What's harder to fix are the underlying process issues.  My main concern 
> > is that these patches add almost 9,000 lines of code and data.  We've 
> > received clear guidance from the upstream ARM SoC maintainers that any 
> > significant new additions need to be balanced with moving a similar number 
> > of lines of code and data out of arch/arm/{plat-,mach-}* into drivers/.  
> > (Or the new patches should be accompanied with patches that show obvious 
> > progress towards the goal of moving code and data out of 
> > arch/arm/{plat-,mach-}*.)  We need to see more help from TI on the 
> > prerequisites for this cleanup process.
> >
> I agree that we are not making faster progress but as part of the
> $subject series itself, for DT only build, we removed around ~4000
> lines of data from hwmod. After the merge window, we can trim
> the AM33XX and then later OMAP4 when it is made DT only support.
> That should give us another 6000 lines of negative diff.
> At the same time removal of MUX data for OMAP4 should be
> around 2000 lines of negative diff.
> 
> You might also notice, we dropped OMAP5 clock data considering
> its move under drivers/clk/. Rajendra and Tero already posted
> patches [1] for the same on the list. Ofcourse your feedback is
> needed to make progress there.
> 
> > For example, as discussed last year with the TI upstream PM team, an 
> > important first step in this process in my view is to get rid of the 
> > direct PRM/CM register accesses in the OMAP PM code.  See commit 
> > c4ceedcb18cf7a06059482a3a1828b9aad9f78cf ("ARM: OMAP2+: CM/clock: convert 
> > _omap2_module_wait_ready() to use SoC-independent CM functions") as an 
> > example of this process.  This should make it easier to get the PRM/CM 
> > functionality into drivers/.  That in turn make it possible to move the 
> > clockdomain, clock, powerdomain, and hwmod code to drivers/.ARM: OMAP2+: 
> > CM/clock: convert _omap2_module_wait_ready() to use SoC-independent CM 
> > functions.  So far as I can tell, there hasn't been any forward progress 
> > on this.
> >
> On this part as well after my discussion with Tony, Tero picked it up
> and he and Eduardo posted questions to you [2] considering you
> already had some WIP patches as we learned from Tony. I suggest
> you send any information on this to "Tero" since he is leading the
> PM effort and has plans to work on these items.
>  
> > It's also necessary to see more TI contributions in finding and fixing 
> > regressions.  Detecting and fixing regressions from the previous kernel 
> > release should be done first, before working on cleanup series or new 
> > feature/SoC additions.  Looking at the list of v3.9-rc regressions that 
> > I've found, we've gotten very little organized help from TI on dealing 
> > with them.  
> > 
> > This in turn robs the maintainers of time that could be spent doing patch 
> > review or further cleanup work, which benefits no one in the end.  
> > Ideally each regression would be assigned to a member of the TI upstream 
> > team, and the whole process could be completed within one or two weeks.
> >
> I agree with you overall. 
> 
> On couple of specific issues though,
> 
> - BOOT-Loader version:  IMHO boot-loader should be upgraded here.
> We always upgrade kernel for new/fixed features and bootloader should
> be no exception.
>
> - Co-processor Power issue: This one is also has boot-loader dependency
> but here too, going on path where firmware needs to be loaded to idle
> them isn't great idea. We never did that for OMAP2/3 where DSP, Tesla
> was present. IMO, we should not bring these devices out of reset and
> let the "remote_proc()" frame works take care of them when it is
> available in kernel. Suman from TI is working on it to enable that.

I kind of understand why you insist keeping your old bootloader, as it
makes these issues visible, but well, nothing is going to happen for
them as far as I can see. If Suman can eventually provide a nice hack
that makes this happen, fine, but at least on the PM front, we can do
nothing. Even if we did, the implementation would most likely become so
ugly that it would be rejected by the maintainers anyway. I can't see
any point why to invest time on this.

> > ...
> > 
> > So from my point of view, I'd like to see the following changes before we 
> > accept any new patchsets that add a significant number of lines:
> > 
> > 1. Organized help from TI in finding and fixing regressions in the -rc 
> > cycle, with the regressions dealt with before any new feature 
> > pull-requests are sent
> >
> Agreed. Tero can help here to streamline the process for PM regressions.
> Rest of the core regressions and MPU PM, feel free to pass it on to
> Rajendra/me. We will try to address them on priority.

With this, I think we are able to only help partially. The problem is
the number of (in my view) obsolete platforms that are being used (read:
omap2.) We can't provide any support for the boards we don't have
available, and I can say from the list of your rc3 comments, that we
have access to only 4 of the boards you are using (pandas, bone and
beagle, and the panda problems you can most likely fix by updating your
bootloader.)

> 
>  
> > 2. Help from TI on some of the cleanup work that we've mentioned in the 
> > past, starting with the PRM/CM register access cleanup inside mach-omap2/
> > 
> Absolutely. As I mentioned earlier, Eduardo and Tero are waiting for your
> inputs on this topic.

Well, this part we started with moving the ccf data under drivers/clk.
prm/cm has not been started, but we have plans to work with this.

-Tero

> 
> > 3. Pairing any large feature or SoC additions with at least an equal 
> > removal of lines of code
> > 
> As listed in beginning of the email, there is an effort going on in this
> direction. In fact removal of lines of code has to happen even without
> any new feature. As Tony mentioned in past, we eventually want to support
> DT only builds and that should also allow us significant loc removal
> opportunity. But feel free to suggest ideas if you see more opportunities
> apart from the obvious ones.
> 
> Thanks for all your help.
> 
> Regards,
> Santosh
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg87110.html
> [2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85602.html
