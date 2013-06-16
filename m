From: Suman Anna <s-anna@ti.com>
Subject: Re: [GIT PULL] mailbox driver framework for v3.10 merge window
Date: Sun, 16 Jun 2013 15:14:01 -0500
Message-ID: <51BE1C89.5080800@ti.com>
References: <CAFiDJ5_1w+M6TTroeQEjOcc5GNN2RCmLN4ZB5dxQNwoc+9R1YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47588 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab3FPUTg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Jun 2013 16:19:36 -0400
In-Reply-To: <CAFiDJ5_1w+M6TTroeQEjOcc5GNN2RCmLN4ZB5dxQNwoc+9R1YQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "LF.Tan" <lftan.linux@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux@arm.linux.org.uk, loic.pallardy@st.com, tony@atomide.com, Linus Walleij <linus.walleij@linaro.org>, omar.ramirez@copitl.com, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, jaswinder.singh@linaro.org

Hi Tan,

On 06/14/2013 04:32 AM, LF.Tan wrote:
> 
> Hi Suman
> 
> Thanks for your reply.
> I have took a look the patches you've mentioned in [1]. It is totally
> new framework from what is located in linux-next git tree now.

Yes, that is correct. The framework is different, but functionality
wise, you should be able to achieve the same (and a bit more).

> Is this going to be final version for the framework? I am going to start
> to develop the mailbox driver soon and I hope I can use the framework
> which is stable (at least not the major changes). Do you think I should
> start development based on [1]?

Jassi is working through a newer version of the patches, so there would
be minor changes once the newer patchset is ready, but the core
framework/functionality shouldn't change much from above. Do take a look
at the framework (much of the explaination in header files) and see how
it fits your driver needs.

regards
Suman

> 
> 
> On Thu, Jun 13, 2013 at 11:59 PM, Suman Anna <s-anna@ti.com
> <mailto:s-anna@ti.com>> wrote:
> 
>     Tan,
> 
>     On 06/13/2013 06:01 AM, LF.Tan wrote:
>     > Hi
>     > I would like to add a new mailbox driver with this mailbox framework.
>     > May I know this mailbox framework will available in kernel v3.10 or it
>     > is pushed to v3.11?
>     >
>     > Thanks.
> 
>     This framework is dropped from v3.10 as this is being reworked and will
>     be replaced with a different one that adds atomic context and tx
>     callback support [1]. Jassi is working on a newer patchset currently for
>     this, but you should be able to get started using [1].
> 
>     regards
>     Suman
> 
>     [1] http://marc.info/?l=linux-kernel&m=136782509309470&w=2
> 
>     >
>     > On Friday 03 May 2013 15:39:42 Linus Walleij wrote:
>     >> On Fri, May 3, 2013 at 3:25 PM, Arnd Bergmann <a...@arndb.de
>     <mailto:a...@arndb.de>
>     > <mailto:a...@arndb.de <mailto:a...@arndb.de>>> wrote:
>     >> > On Thursday 02 May 2013 17:09:07 Suman Anna wrote:
>     >> >>
>     >> >> I do not know how much of an impact it is for the ST driver as the
>     >> >> series adds the driver, and would have to wait until the RFC
>     is sorted
>     >> >> out otherwise.
>     >> >
>     >> > I think I'd prefer to drop the branch from the 3.10 queue then
>     >> > and let you all work out a common approach for 3.11. Olof, any
>     >> > other input?
>     >>
>     >> This will block all refactoring of the PRCMU driver, which Loic
>     >> is working on, and also Ulf Hansson's clock driver. It is basically
>     >> the key to breaking that driver apart and distributing it out into
>     >> the proper subsystems. Loic has a big patch series for that
>     >> for next merge window which will then have to be postponed,
>     >> or queued on top of the mailbox work when finished.
>     >>
>     >> But maybe it's the right thing to do if the subsystem needs more
>     >> work? I have no clear opinion on this, Loic, Ulf?
>     >
>     >> I think we can queue them together. I'm certainly fine with the
>     >> mailbox subsystem getting merged through both the mfd and arm-soc
>     >> trees to avoid conflicts.
>     >
>     >>     Arnd
> 
> 

