From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 11:45:06 +0200
Message-ID: <1274867106.5882.5090.camel@twins>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	 <201005242049.18920.rjw@sisk.pl> <87wrusvrqe.fsf@deeprootsystems.com>
	 <201005250138.16293.rjw@sisk.pl> <1274863655.5882.4875.camel@twins>
	 <AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:47437 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934086Ab0EZJpM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 05:45:12 -0400
In-Reply-To: <AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@deeprootsystems.com>, felipe.balbi@nokia.com, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Wed, 2010-05-26 at 02:41 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> On Wed, May 26, 2010 at 1:47 AM, Peter Zijlstra <peterz@infradead.org=
> wrote:
> > On Tue, 2010-05-25 at 01:38 +0200, Rafael J. Wysocki wrote:
> >> > This of course will lead to a scattering of suspend blockers int=
o any
> >> > drivers/subsystems considered "useful", which by looking through=
 current
> >> > Android kernels is many of them.
> >>
> >> That depends on the maintainers of these subsystems, who still hav=
e the power
> >> to reject requested changes.
> >
> > So as a scheduler maintainer I'm going to merge a patch that does a
> > suspend_blocker when the runqueue's aren't empty... how about that?
> >
>=20
> I don't know if you are serious, since the all the runqueues are neve=
r
> empty while suspending, this would disable opportunistic suspend
> altogether.

So why again was this such a great scheme? Go fix your userspace to not
not run when not needed.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
