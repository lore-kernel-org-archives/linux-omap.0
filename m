From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Move the barrier memboclk_steal() as
 part of reserve callback
Date: Tue, 14 Feb 2012 11:18:21 -0800
Message-ID: <20120214191820.GP1426@atomide.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com>
 <20120210191926.GV1426@atomide.com>
 <4F3A2025.9000609@ti.com>
 <20120214111420.GG15338@n2100.arm.linux.org.uk>
 <CAMQu2gxRT3X7Q7bg0e-7=3HNKWjfQn7gLw9EQhY=g4U10yDMtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64523 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab2BNTS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 14:18:26 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gxRT3X7Q7bg0e-7=3HNKWjfQn7gLw9EQhY=g4U10yDMtg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120214 02:58]:
> On Tue, Feb 14, 2012 at 4:44 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 14, 2012 at 02:19:41PM +0530, Santosh Shilimkar wrote:
> >> >From 4d1ea22985adfe458275b9ae3e00edc6e41a267f Mon Sep 17 00:00:00=
 2001
> >> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Date: Thu, 2 Feb 2012 15:59:51 +0530
> >> Subject: [PATCH 1/2] ARM: OMAP4: Move the barrier memboclk_steal()=
 as
> >> part of reserve callback
> >>
> >> Commit 716a3dc{ARM: Add arm_memblock_steal() to allocate memory aw=
ay
> >> from the kernel} introduced arm_memblock_steal() which lead to
> >> OMAP4_ERRATA_I688 to be broken and needed to be fixed.
> >
> > That is misleading. =C2=A0Please don't attribute blame for this bre=
akage to
> > that patch, which has nothing to do with introducing the breakage. =
=C2=A0The
> > errata was broken right from the start.
>=20
> That's right and I didn't mean that way.
> This was the same reason, first patch I just mentioned what was wrong
> in the code
> rather than mention of any commit.
>=20
> Tony,
> Let me know if you want to add any commit history to the change since
> the issue was actually existing without 'arm_memblock_stea()' commit.
> I think, first change log was good enough from the fix point of view.

OK, makes sense. I'll apply it into fixes as is then.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
