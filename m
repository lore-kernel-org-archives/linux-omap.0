From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] ARM: OMAP3: Add SMSC911X support to Overo platform
	(V2)
Date: Sun, 15 Mar 2009 17:00:54 +0000
Message-ID: <20090315170054.GA12265@n2100.arm.linux.org.uk>
References: <20090313224259.8810.3283.stgit@localhost> <20090313224453.8810.41743.stgit@localhost> <20090315153827.GA10541@n2100.arm.linux.org.uk> <5e088bd90903150936w45e68b63k1252cea38b48a5fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47499 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbZCORBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 13:01:08 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90903150936w45e68b63k1252cea38b48a5fc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sun, Mar 15, 2009 at 09:36:25AM -0700, Steve Sakoman wrote:
> On Sun, Mar 15, 2009 at 8:38 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Mar 13, 2009 at 03:44:53PM -0700, Tony Lindgren wrote:
> >> Gumstix will soon be shipping a variant of their Summit board that
> >> includes an SMSC LAN9221 ethernet interface. =A0This patch provide=
s
> >> support via the smsc911x driver when enabled in kernel config.
> >
> > Does this actually work with the smsc911x driver which is in mainli=
ne,
> > or is it dependent on the smsc911x patches from Steve Glendinning?
>=20
> For the shipping Overo kernel, I build with 2 of Steve's patches, cop=
ied below.

That doesn't help answer the question.  What we need to know is whether
this patch works alone?  If not, do we know for sure that Steve's patch=
es
are going in during the next merge window?

If it doesn't work alone _and_ Steve's patches aren't for whatever reas=
on
going in (via the net tree), then this patch should be dropped from the
set.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
