From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 00/14] omap: mailbox: bunch of cleanups
Date: Thu, 3 Jun 2010 19:15:53 +0300
Message-ID: <20100603161553.GL30622@atomide.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
 <20100603.094022.200375421.Hiroshi.DOYU@nokia.com>
 <20100603114726.GC7127@n2100.arm.linux.org.uk>
 <AANLkTinBMdcxzF_pZuiFHc1Eox_bYtD8PXG1OuKo0XWu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61971 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab0FCQQO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 12:16:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinBMdcxzF_pZuiFHc1Eox_bYtD8PXG1OuKo0XWu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Felipe Contreras <felipe.contreras@gmail.com> [100603 17:53]:
> On Thu, Jun 3, 2010 at 2:47 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jun 03, 2010 at 09:40:22AM +0300, Hiroshi DOYU wrote:
> >> > Felipe Contreras (14):
> >> > =C2=A0 omap: mailbox: trivial whitespace cleanups
> >> > =C2=A0 omap: mailbox: trivial cleanups
> >
> > I think folk need to read this:
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0http://lkml.org/lkml/2010/6/2/472
> >
> > and consider what it means for the future, and what can be done to =
reduce
> > the amount of "churn".
>=20
> If I have to decipher that rant, my best guess is that he is
> complaining about the amount of code. If that's the case, this patch
> series is only doing good:
> 6 files changed, 168 insertions(+), 230 deletions(-)
>=20
> Another part of the rant is the fact that Linus cannot follow the hug=
e
> amount of changes. I think "trivial whitespace cleanups" pretty much
> says: don't look at me if you want to be productive, while "trivial
> cleanups" says, look at me if you feel like looking at easy changes.
> If I were to squash these two, I think the patch series would become
> harder to follow.
>=20
> Something that helps in other projects, like git, is that merges are
> clearly identified.
>=20
> Merge branch 'linux-arm'
>  Merge branch 'linux-omap'
>   Merge branch 'linux-omap-mbox'
>    Merge branch 'fc-cleanups'
>    Merge branch 'ob-kfifo'
>=20
> Then it's a bit clearer what each patch series is doing in the mailbo=
x
> tree without looking at individual patches.

Also we need to make sure all the code we merge is really tested
well before the merge window. Too much of the code needs to be
fixed after the merge window. For the upcoming merge window, we
will only merge things that have been sitting in the for-next
for days before the merge window opens.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
