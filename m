From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP3: Add SMSC911X support to Overo platform
	(V2)
Date: Mon, 16 Mar 2009 11:08:01 -0700
Message-ID: <20090316180800.GG19229@atomide.com>
References: <20090313224259.8810.3283.stgit@localhost> <20090313224453.8810.41743.stgit@localhost> <20090315153827.GA10541@n2100.arm.linux.org.uk> <5e088bd90903150936w45e68b63k1252cea38b48a5fc@mail.gmail.com> <20090315170054.GA12265@n2100.arm.linux.org.uk> <5e088bd90903151013i1b0e57d3hfe37353540b235e1@mail.gmail.com> <20090315173739.GA13220@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61872 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbZCPSH7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 14:07:59 -0400
Content-Disposition: inline
In-Reply-To: <20090315173739.GA13220@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, steve.glendinning@smsc.com

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090315 10:37]:
> On Sun, Mar 15, 2009 at 10:13:47AM -0700, Steve Sakoman wrote:
> > On Sun, Mar 15, 2009 at 10:00 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Sun, Mar 15, 2009 at 09:36:25AM -0700, Steve Sakoman wrote:
> > >> On Sun, Mar 15, 2009 at 8:38 AM, Russell King - ARM Linux
> > >> <linux@arm.linux.org.uk> wrote:
> > >> > On Fri, Mar 13, 2009 at 03:44:53PM -0700, Tony Lindgren wrote:
> > >> >> Gumstix will soon be shipping a variant of their Summit board=
 that
> > >> >> includes an SMSC LAN9221 ethernet interface. =A0This patch pr=
ovides
> > >> >> support via the smsc911x driver when enabled in kernel config=
=2E
> > >> >
> > >> > Does this actually work with the smsc911x driver which is in m=
ainline,
> > >> > or is it dependent on the smsc911x patches from Steve Glendinn=
ing?
> > >>
> > >> For the shipping Overo kernel, I build with 2 of Steve's patches=
, copied below.
> > >
> > > That doesn't help answer the question. =A0What we need to know is=
 whether
> > > this patch works alone? =A0If not, do we know for sure that Steve=
's patches
> > > are going in during the next merge window?
> >=20
> > It does not work without the 2 mentioned patches (IRQ's never get h=
andled).
>=20
> So I suggest that this patch is handed over to Steve to submit with h=
is
> set of patches.

I've added Steve Glendinning to the Cc.

I'll drop this from my queue, Steve Sakoman please email this to Steve
Glendinning for inclusion to his queue.

Please also Cc at least linux-omap and netdev lists.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
