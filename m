From: Tony Lindgren <tony@atomide.com>
Subject: Re: Important changes, please read
Date: Thu, 22 Jan 2009 17:46:03 -0800
Message-ID: <20090123014602.GI7172@atomide.com>
References: <20090114134152.GJ29324@atomide.com> <200901200226.19385.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62225 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbZAWBqG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 20:46:06 -0500
Content-Disposition: inline
In-Reply-To: <200901200226.19385.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090120 02:26]:
> On Wednesday 14 January 2009, Tony Lindgren wrote:
> > - We stop using source.mvista.com git tree, and only use the
> > =A0 kernel.org git tree. There's no need for having two master tree=
s,
> > =A0 and kernel.org is the standard way to go. Big thanks to
> > =A0 Monta Vista for hosting us for many years.
>=20
> This means that the new "OMAP and DaVinci for Dummies"
> book needs updating already.  ;)
>=20
> I see the DaVinci tree there includes a "WARNING..." that
> points to the kernel.org tree .. maybe the OMAP tree should
> do the same.

OK, I've added a warning too, and move linux-omap-2.6.git
into linux-omap-2.6-historic.git. So that means it's no longer
being updated, but still available for reference.

Please everybody, update your .git/config to point to kernel.org:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

or if behind a firewall:

http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.gi=
t

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
