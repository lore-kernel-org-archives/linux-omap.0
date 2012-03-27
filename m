From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators
 for v3.4
Date: Tue, 27 Mar 2012 10:04:45 -0700
Message-ID: <20120327170445.GP9859@atomide.com>
References: <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com>
 <20120309003217.GB12083@atomide.com>
 <20120309114731.GA3273@opensource.wolfsonmicro.com>
 <87zkbp4wtj.fsf@ti.com>
 <20120311204232.GC3171@opensource.wolfsonmicro.com>
 <87399dzq5e.fsf@ti.com>
 <20120312173215.GL3110@opensource.wolfsonmicro.com>
 <87pqchv1pc.fsf@ti.com>
 <CANOLnOMfsdGn-B0zftcV-zh+tSCGgmf0g1BsrFB0+Kh-HnNq0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41944 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab2C0REu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Mar 2012 13:04:50 -0400
Content-Disposition: inline
In-Reply-To: <CANOLnOMfsdGn-B0zftcV-zh+tSCGgmf0g1BsrFB0+Kh-HnNq0g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Grazvydas Ignotas <notasas@gmail.com> [120327 07:00]:
> On Tue, Mar 13, 2012 at 1:28 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Tony, updated pull request below. =C2=A0This includes all the TWL d=
epencies
> > merged from the 'topic/twl' tag in Mark's tree.
> >
>=20
> Has this been lost now? It seems regulator parts got merged, but
> voltage parts are missing from Arnd's pull requests and are not
> showing up in linux-next.
> Was looking forward for voltage control in 3.4 to achieve higher cloc=
k
> rates on our aging OMAP3 hardware.

Sounds like this is something we should get merged early to arm-soc
tree after the merge window.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
