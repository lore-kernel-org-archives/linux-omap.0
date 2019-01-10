From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Thu, 10 Jan 2019 08:45:58 +0100
Message-ID: <20190110074558.GA26167@lenoch>
References: <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch>
 <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch>
 <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
 <20190109160736.GA7416@lenoch>
 <CAKfTPtBnNA6knrsHsZXeaotBSn5mS12xNWNUKdSwZ1EUvueQkA@mail.gmail.com>
 <20190109172623.GB1711@lenoch>
 <CAKfTPtBGh+ShbNCZLiYr4PZJooun7uctuQaomc40czvAk5Yizg@mail.gmail.com>
 <CAJZ5v0jPJYyszAs4qJhqX+5RGwzJoo=+reTS__buoCrfTeYY8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990945AbfAJHqARsGeQ (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Thu, 10 Jan 2019 08:46:00 +0100
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jPJYyszAs4qJhqX+5RGwzJoo=+reTS__buoCrfTeYY8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 09, 2019 at 11:06:34PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 9, 2019 at 7:05 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 9 Jan 2019 at 18:26, Ladislav Michl <ladis@linux-mips.org> wrote:
> > >
> > > On Wed, Jan 09, 2019 at 05:32:31PM +0100, Vincent Guittot wrote:
> > > > On Wed, 9 Jan 2019 at 17:07, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > >
> > > > > On Wed, Jan 09, 2019 at 03:12:25PM +0100, Vincent Guittot wrote:
> > > > > > Please keep all thread list when replying :-)
> > > > >
> > > > > Ahh, sorry for that...
> > > > > [snip]
> > > > > > On Wed, 9 Jan 2019 at 14:33, Ladislav Michl <ladis@linux-mips.org> wrote:
> > > > > > > I agree, but it doea all the magic correctly, so you won't need
> > > > > > > to touch that code is ktime_t changes (I know, unlikely..)
> > > > > >
> > > > > > But the current implementation doesn't care of any changes in ktime_t
> > > > > > as it uses raw ns
> > > > >
> > > > > Fair enough, so let's go back to:
> > > >
> > > > This one looks good for me
> > >
> > > Lets split is for 'comments fix' patch, which was just send and 'the rest'.
> > > Now, 'the rest' can either be v2 of your "PM/runtime: Fix autosuspend_delay on
> > > 32bits arch" or will wait for 5.1. You decide :)
> >
> > I don't really mind.
> >
> > Rafael,
> > Do you prefer to only take the fix for u64 casting problem or do you
> > prefer to also take the optimization below in one single patch ?
> 
> The casting problem is a bug and the optimization is next release
> material in my view.  Please send the optimization separately.

Ok, will send that separately in a few moments...
Btw, u64 casting problem seems to be still present in rpm_suspend while
computing slack for autosuspend delay greater than 25% of 2^31 (2^33) ns.
Not sure if that triggers any real bug.
