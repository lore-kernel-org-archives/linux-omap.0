From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
Date: Tue, 14 Feb 2012 11:19:22 -0800
Message-ID: <20120214191921.GQ1426@atomide.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
 <20120210191813.GU1426@atomide.com>
 <4F39EDD0.9010304@ti.com>
 <CAMQu2gxnHE8fps6LD93B2G_w-p=i7YmuadasPrE-601-S8mUkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10392 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757016Ab2BNTTX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 14:19:23 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gxnHE8fps6LD93B2G_w-p=i7YmuadasPrE-601-S8mUkA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120213 22:44]:
> On Tue, Feb 14, 2012 at 10:44 AM, Rajendra Nayak <rnayak@ti.com> wrot=
e:
> > On Saturday 11 February 2012 12:48 AM, Tony Lindgren wrote:
> >>
> >> * Santosh Shilimkar<santosh.shilimkar@ti.com> =C2=A0[120202 05:33]=
:
> >>>
> >>> > =C2=A0From: Rajendra Nayak<rnayak@ti.com>
> >>> >
> >>> > =C2=A0hwmod setup already does a reset and sets the OCP sysconf=
ig
> >>> > =C2=A0registers appropriately. Avoid doing a reset again and ov=
erriding
> >>> > =C2=A0the OCP sysconfig settings in the system timer init code.
> >
> >>
> >>
> >> If we want this queued as a fix, it should also describe what
> >> actually breaks? Timer? PM?
> >
> >
> > It only fixes the redundant reset and overriding the smartidle-wake=
up
> > OCP setting (done by hwmod) with the smartidle in the driver.
> > Doing this doesn't really break anything as yet in mainline, but wi=
ll
> > cause timer wakeup issues once OFF mode is in place for OMAP4. On O=
MAP5
> > however this was causing more issues as the softreset bit position =
is
> > different than on OMAP2/3/4.
> > So it should be ok to queue this in for 3.4 considering neither OMA=
P4
> > OFF, not OMAP5 support is in mainline yet.
> >
> I second Rajendra's comment.

OK thanks, will apply into fixes-non-critical.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
