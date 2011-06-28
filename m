From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Tue, 28 Jun 2011 13:47:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106281346160.2874@utopia.booyaka.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org> <201106232234.21930.rjw@sisk.pl> <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com> <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-293461756-1309290467=:2874"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40054 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab1F1Trs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 15:47:48 -0400
In-Reply-To: <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-293461756-1309290467=:2874
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Arve,

On Fri, 24 Jun 2011, Arve Hj=F8nnev=E5g wrote:

> On Fri, Jun 24, 2011 at 12:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > As I understand it, in the original Android implementation, the hardwar=
e
> > that they were using didn't have fine-grained power management. =A0So
> > system-wide suspend made more sense in that context. =A0But that should=
n't
> > be confused with the modern rationale for wakelocks:
> >
> > https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668.h=
tml
> >
> > "On the hardware that shipped we enter the same power state from idle
> > and suspend, so the only power savings we get from suspend that we
> > don't get in idle is from not respecting the scheduler and timers."
> >
>=20
> This is no longer the case. Both the Nexus-S and Xoom enter lower
> power states from suspend than idle.

Just out of curiosity, is that due to some kind of hardware limitation on=
=20
those platforms, or is it because the software infrastructure for dynamic=
=20
deep idle hasn't been fully implemented in that subarchitecture code?


- Paul
--155748971-293461756-1309290467=:2874--
