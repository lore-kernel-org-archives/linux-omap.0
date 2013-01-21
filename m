From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] OPP usage fixes for RCU locking
Date: Mon, 21 Jan 2013 13:40:35 +0100
Message-ID: <3394404.9F6oTTpRKB@vostro.rjw.lan>
References: <1358538755-29109-1-git-send-email-nm@ti.com> <2007041.tOt4VKpdOD@vostro.rjw.lan> <CAJ0PZbS6Ka7ZNJ+a4kXW89dYgwASWA_3pYQFPFtTNv8DwwQzLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ0PZbS6Ka7ZNJ+a4kXW89dYgwASWA_3pYQFPFtTNv8DwwQzLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@gmail.com
Cc: Nishanth Menon <nm@ti.com>, linux-pm <linux-pm@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, lkml <linux-kernel@vger.kernel.org>, lo <linux-omap@vger.kernel.org>, Jack <jack@embed.me.uk>, Alexander <holler@ahsoftware.de>
List-Id: linux-omap@vger.kernel.org

On Monday, January 21, 2013 02:45:32 PM MyungJoo Ham wrote:
> On Sat, Jan 19, 2013 at 7:28 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, January 18, 2013 01:52:31 PM Nishanth Menon wrote:
> >> Hi,
> >> Despite being documented in function documentation and in
> >> Documentation/power/opp.txt, many of the users of OPP APIs
> >> dont honor RCU lock usage appropriately.
> >>
> >> This recently appeared in IRC discussion earlier today [1].
> >> I did an audit of current usage and the following series
> >> is a result of this.
> >>
> >> NOTE:
> >> 1. The patch "PM / devfreq: exynos4_bus: honor RCU lock usage" has only
> >>    been build tested as I dont have an exynos platform to try it on. I have
> >>    tried to make it as least intrusive as possible and at least reviewed
> >>    to ensure I haven't screwed anything up.
> >>
> >> Other than this, I have added appropriate tested by information in requisite
> >> patches.
> >
> > Thanks for the fixes.
> >
> > MyungJoo, do you want me to take the devfreq ones too?
> >
> > Rafael
> 
> Yes, please take RCU-OPP patches. Having those patches splitted
> doesn't seem beneficial.

OK, I will take them.

> I'll let other devfreq patches be based on this after you get them applied.

OK

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
