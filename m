From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] OMAP2+ hwmod fixes
Date: Mon, 21 Feb 2011 09:55:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102210901140.22636@utopia.booyaka.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com> <4D5BCC10.2060301@ti.com> <6cc4b2788ff1e15c22987d5db91f0395@mail.gmail.com> <4D5E85EA.70605@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-366595252-1298306114=:22636"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60244 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab1BUQza (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 11:55:30 -0500
In-Reply-To: <4D5E85EA.70605@ti.com>
Content-ID: <alpine.DEB.2.00.1102210935270.22636@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-366595252-1298306114=:22636
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1102210935271.22636@utopia.booyaka.com>

Hello Beno=EEt, Rajendra,

On Fri, 18 Feb 2011, Cousson, Benoit wrote:

> On 2/16/2011 2:43 PM, Nayak, Rajendra wrote:
> > > -----Original Message-----
> > > From: Cousson, Benoit [mailto:b-cousson@ti.com]
> > > Sent: Wednesday, February 16, 2011 6:37 PM
> > > To: Nayak, Rajendra
> > > Cc: linux-omap@vger.kernel.org; paul@pwsan.com;
> > linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH 0/3] OMAP2+ hwmod fixes
> > >=20
> > > Hi Rajendra,
> > >=20
> > > On 2/16/2011 1:11 PM, Nayak, Rajendra wrote:
> > > > This series fixes some hwmod api return values
> > > > and also adds some state checks.
> > > > The hwmod iterator functions are made to
> > > > continue and not break if one of the
> > > > callback functions ends up with an error.
> > >=20
> > > By doing that, you change the behavior of this function.
> > > I'm not sure I fully understand why.
> > > Could you elaborate on the use case?
> >=20
> > Since these functions iterate over all hwmods
> > calling a common callback function, there might
> > be cases wherein the callback function for *some*
> > hwmods might fail. For instance, if you run through
> > all hwmods and try to clear the context registers
> > for all of them, for some hwmods which might
> > not have context registers the callback function
> > might return a -EINVAL, however that should not
> > stop you from attempting to clear the context
> > registers for the rest of the hwmods which have
> > them and abort the function midway, no?
> > This is more hypothetical, however the real usecase
> > that prompted me with this patch was when I
> > had some wrong state check in _setup function,
> > and the iterator would stop with the first failure
> > and not even attempt to setup the rest of the
> > hwmods.
>=20
> Yeah, but by using that function you implicitly accept that an error will
> break the loop, so the function you pass to the iterator should be writte=
n for
> that. Meaning if you do not want to exit on error you should not report a=
n
> error.
>=20
> > > To avoid that behavior in the past, I was just returning
> > > 0 in case of failure to avoid stopping the iteration.
> > > It looks like you do not want to stop the iteration but still
> > > retrieve the error.
> > > I do not see in this series what you plan to do with the
> > > error at the end of the iteration.
> >=20
> > Most users of these iterators would just use the non-zero
> > return value to throw an error/warning out stating there
> > were failures running through all the callback functions.
> > That does not change with this patch, and they can still
> > do it.
>=20
> Except that now, the iterator is not able anymore to stop on error if nee=
ded
> potentially.
> My point is that you are changing the behavior of this function without
> maintaining the legacy.
>=20
> So maybe creating a new iterator is a better approach.
> Even is this feature is not used today I have some secret plan for this
> behavior in the near future :-)
>=20
> But my initial comment is still valid, if you do not care about the final
> error status after the iteration, you'd better not return any error at th=
e
> beginning.
> This was the behavior or the _setup until now.

The original behavior of the iterator was intentional: loops over=20
functions like _init_clocks() and _setup() should terminate upon=20
encountering an error.  This is because the rest of that code currently=20
relies on the hwmod/clock data to be accurate in order to work.  There is=
=20
no provision in the code for a hwmod to fail initialization due to data=20
errors.  The idea was that if the data is inaccurate, the data should be=20
fixed first before doing anything else.

That said, I suppose that it's possible to enhance the code such that=20
hwmods could be allowed to fail initialization, and simply brick=20
themselves, rather than prevent the rest of the hwmods from initializing. =
=20
Probably that would need a new _HWMOD_STATE_INIT_FAILED, or something=20
similar.  If a hwmod would end up in that state, it must not be used by=20
any other code, and the code should complain loudly.

The broader issue of whether the iterators should return immediately upon=
=20
failure (as the current code does), or continue through the rest of the=20
list, is a separate one.  I'd suggest one of two approaches:

1. If the rest of the code can be changed to gracefully handle cases where=
=20
hwmod initialization fails, and if Beno=EEt agrees, I don't have a problem=
=20
with changing the iterator behavior to ignore failures as you describe. =20
Of course, all of the current users of omap_hwmod_for_each*() would need=20
to be checked to ensure that this behavior makes sense for them.

=2E.. or ...

2. The iterators could take an extra parameter that would control the=20
behavior upon encountering an error: terminate, or continue.  But I am not=
=20
sure that both cases are needed.  Ideas, feedback here are welcome.


- Paul
--155748971-366595252-1298306114=:22636--
