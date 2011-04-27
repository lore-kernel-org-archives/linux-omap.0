From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v9 4/9] OMAP3: PM: TWL4030 power scripts for OMAP3
 boards
Date: Wed, 27 Apr 2011 06:05:39 -0700
Message-ID: <20110427130538.GG3755@atomide.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
 <1302784077-16697-5-git-send-email-leslyam@ti.com>
 <20110418123240.GN12272@atomide.com>
 <BANLkTinjkqmL5a2YQTnMYFSZt-11vRNy0w@mail.gmail.com>
 <20110418125820.GO12272@atomide.com>
 <BANLkTikmm5cUhSagsWqPUAjgdQnjOy6W+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15996 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759155Ab1D0NFm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 09:05:42 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikmm5cUhSagsWqPUAjgdQnjOy6W+A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Manuel, Lesly Arackal" <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

* Manuel, Lesly Arackal <leslyam@ti.com> [110427 05:55]:
> Hi Tony,
>=20
> On Mon, Apr 18, 2011 at 6:28 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Manuel, Lesly Arackal <leslyam@ti.com> [110418 15:52]:
> >> >
> >> > To me it seems this should go into drivers/mfd instead.
> >> > The script may contain omap specific values, but can be
> >> > a loadable driver module.
> >>
> >> - subsys_initcall(twl_init)
> >> =C2=A0 =C2=A0 -> twl_probe()
> >> =C2=A0 =C2=A0 =C2=A0 -> twl4030_power_init()
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -> load_twl4030_script() =C2=A0#to cop=
y this script data to the PM IC.
> >>
> >> Since this is getting called from a subsys initcall, not sure whet=
her
> >> we can make this scripts as loadable module.
> >
> > AFAIK it does not need to do anything that early. Maybe take a look
> > at initialing it later?
> >
>=20
> The loading of script data & configuration of resource is one time pr=
ocess,
> later HW will take care(executing the sequence in TWL based on
> sys_offmode, clk_req, ...signal states)
>=20
> So any specific reason for making this twl script as loadable module?

Because it should all be just a regular device driver living under
drivers/. You can still pass the platform data to it, there should not
be any need to initialize this earlier.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
