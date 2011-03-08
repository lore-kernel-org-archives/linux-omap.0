From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/5] OMAP: GPIO: use pwrdmn name to find wkup dmn GPIO
Date: Mon, 7 Mar 2011 19:25:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103071635410.10981@utopia.booyaka.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com> <1298890670-5481-3-git-send-email-charu@ti.com> <8762ryftbs.fsf@ti.com> <AANLkTikziwQBwPVOMxbQaTj5Oa-UAc38Eb87jq_QAHSD@mail.gmail.com> <87k4ga7o9b.fsf@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-381206735-1299540983=:10981"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54955 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab1CHCZc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 21:25:32 -0500
In-Reply-To: <87k4ga7o9b.fsf@ti.com>
Content-ID: <alpine.DEB.2.00.1103071639570.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan\\, Charulatha" <charu@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-381206735-1299540983=:10981
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1103071639571.10981@utopia.booyaka.com>

Hi

On Mon, 7 Mar 2011, Kevin Hilman wrote:

> "Varadarajan, Charulatha" <charu@ti.com> writes:
>=20
> > On Sat, Mar 5, 2011 at 02:21, Kevin Hilman <khilman@ti.com> wrote:
> >> Charulatha V <charu@ti.com> writes:
> >>>
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(bank->pwrdm_name, "wkup_pwrdm")=
)
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> >>> +
> >>
> >> This adds a string compare for every bank during every idle
> >> transistion (and every resume.) =A0That's a lot of unneeded overhead.
> >>
> >> I'd rather see a per-bank flag 'looses_context' or something that can =
be
> >> checked more efficiently in this fast path. =A0This flag can be set ba=
sed
> >> on the powerdomain name in the device init code.
> >
> > This looks better. Will do the needful.
> > One question, can "looses_context" be made as part of dev_attr?
>=20
> I guess that's up to Beno=EEt.
>=20
> But, I don't think that's necessary. It should be easy to set at runtime
> just doing a strcmp on the powerdomain during the device init,
> omap_device_build phase.

It shouldn't be part of .dev_attr, since it's not a IP block-specific=20
attribute, it's a powerdomain-specific attribute.  The same hwmod=20
structure might be used on another OMAP chip that places the device in a=20
different powerdomain.

It would also be good to avoid doing strcmp()s here.  The powerdomain name=
=20
string, like any name string, should basically be opaque to code.

In this case, the best approach is probably for the subarch integration=20
code to ask the powerdomain code whether the hwmod's powerdomain can ever=
=20
lose context.  I just posted a patch series to do this[1], so I'd suggest=
=20
you use the function that it exports.


- Paul

1. http://marc.info/?l=3Dlinux-omap&m=3D129955064112024&w=3D2
--155748971-381206735-1299540983=:10981--
