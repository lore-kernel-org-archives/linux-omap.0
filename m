From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Sat, 26 Jun 2010 12:07:45 +0100
Message-ID: <20100626110745.GB10340@n2100.arm.linux.org.uk>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com> <1277422991-25350-2-git-send-email-khilman@deeprootsystems.com> <AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com> <20100625200659.GB22090@n2100.arm.linux.org.uk> <AANLkTikYE6Kg8C_ZClx9aKLvOa9CQRUT587hQnB91sua@mail.gmail.com> <20100625202002.GC22090@n2100.arm.linux.org.uk> <alpine.LFD.2.00.1006251941190.24097@xanadu.home> <20100626105133.GA762@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45701 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab0FZLIL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Jun 2010 07:08:11 -0400
Content-Disposition: inline
In-Reply-To: <20100626105133.GA762@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Pitre <nico@fluxnic.net>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@deeprootsystems.com>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Jun 26, 2010 at 12:51:33PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Fri, Jun 25, 2010 at 07:46:05PM -0400, Nicolas Pitre wrote:
> > On Fri, 25 Jun 2010, Russell King - ARM Linux wrote:
> >=20
> > > Does anyone know where we are on the defconfig problem?  From wha=
t I
> > > can see, it's mostly stalled for the time being, which is not goo=
d
> > > news for us.
> >=20
> > What looked to be promizing is the work by Uwe Kleine-K=F6nig accor=
ding to=20
> > the preview he posted on June 10:
> >  =20
> > Message-id: <20100610063234.GA22533@pengutronix.de>
> I think Linus is still away?!  I plan to ping him again asking for an
> opinion regarding my idea when he will be back.

It looks that way...
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
