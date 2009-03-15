From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] ARM: OMAP3: Add SMSC911X support to Overo platform
	(V2)
Date: Sun, 15 Mar 2009 17:37:39 +0000
Message-ID: <20090315173739.GA13220@n2100.arm.linux.org.uk>
References: <20090313224259.8810.3283.stgit@localhost> <20090313224453.8810.41743.stgit@localhost> <20090315153827.GA10541@n2100.arm.linux.org.uk> <5e088bd90903150936w45e68b63k1252cea38b48a5fc@mail.gmail.com> <20090315170054.GA12265@n2100.arm.linux.org.uk> <5e088bd90903151013i1b0e57d3hfe37353540b235e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47642 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbZCORhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 13:37:51 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90903151013i1b0e57d3hfe37353540b235e1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sun, Mar 15, 2009 at 10:13:47AM -0700, Steve Sakoman wrote:
> On Sun, Mar 15, 2009 at 10:00 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sun, Mar 15, 2009 at 09:36:25AM -0700, Steve Sakoman wrote:
> >> On Sun, Mar 15, 2009 at 8:38 AM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Fri, Mar 13, 2009 at 03:44:53PM -0700, Tony Lindgren wrote:
> >> >> Gumstix will soon be shipping a variant of their Summit board t=
hat
> >> >> includes an SMSC LAN9221 ethernet interface. =A0This patch prov=
ides
> >> >> support via the smsc911x driver when enabled in kernel config.
> >> >
> >> > Does this actually work with the smsc911x driver which is in mai=
nline,
> >> > or is it dependent on the smsc911x patches from Steve Glendinnin=
g?
> >>
> >> For the shipping Overo kernel, I build with 2 of Steve's patches, =
copied below.
> >
> > That doesn't help answer the question. =A0What we need to know is w=
hether
> > this patch works alone? =A0If not, do we know for sure that Steve's=
 patches
> > are going in during the next merge window?
>=20
> It does not work without the 2 mentioned patches (IRQ's never get han=
dled).

So I suggest that this patch is handed over to Steve to submit with his
set of patches.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
