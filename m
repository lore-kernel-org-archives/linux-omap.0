From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 12:02:42 +0200
Message-ID: <20100526120242.5c9b73ad@schatten.dmk.lab>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl>
	<87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl>
	<1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:34780 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934106Ab0EZKC5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 06:02:57 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1OHDRv-0000aM-6Y
	for linux-omap@vger.kernel.org; Wed, 26 May 2010 12:02:55 +0200
Received: from f053208177.adsl.alicedsl.de ([78.53.208.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 12:02:55 +0200
Received: from florian by f053208177.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 12:02:55 +0200
In-Reply-To: <1274867106.5882.5090.camel@twins>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Wed, 26 May 2010 11:45:06 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, 2010-05-26 at 02:41 -0700, Arve Hj=F8nnev=E5g wrote:
> > On Wed, May 26, 2010 at 1:47 AM, Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> > > On Tue, 2010-05-25 at 01:38 +0200, Rafael J. Wysocki wrote:
> > >> > This of course will lead to a scattering of suspend blockers i=
nto any
> > >> > drivers/subsystems considered "useful", which by looking throu=
gh current
> > >> > Android kernels is many of them.
> > >>
> > >> That depends on the maintainers of these subsystems, who still h=
ave the power
> > >> to reject requested changes.
> > >
> > > So as a scheduler maintainer I'm going to merge a patch that does=
 a
> > > suspend_blocker when the runqueue's aren't empty... how about tha=
t?
> > >
> >=20
> > I don't know if you are serious, since the all the runqueues are ne=
ver
> > empty while suspending, this would disable opportunistic suspend
> > altogether.
>=20
> So why again was this such a great scheme? Go fix your userspace to n=
ot
> not run when not needed.

Hi Peter!

This was already mentioned in one of these threads.=20

The summary is: The device this kernel is running on dosn't want to
(or can) rely on userspace to save power. This is because it is an open
system, without an app-store or the like. Everyone can run what he
wants.

So anything relying on (all) userspace solves a different problem.

Cheers,
=46lo




> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
