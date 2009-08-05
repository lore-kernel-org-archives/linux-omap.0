From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Fwd: MMC3 Overo
Date: Wed, 5 Aug 2009 23:26:04 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305FC60FD@dbde02.ent.ti.com>
References: <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38245 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbZHER4N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 13:56:13 -0400
In-Reply-To: <5e088bd90908051051s98875e0vddab60dd122f3e8b@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, John Sarman <johnsarman@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>

Steve Sakoman wrote:
> On Wed, Aug 5, 2009 at 9:35 AM, John Sarman<johnsarman@gmail.com> wro=
te:
> > On Wed, Aug 5, 2009 at 12:25 PM, Kevin Hilman<khilman@deeprootsyste=
ms.com> wrote:
> >> Might I suggest a kernel patch for this rather than fixing u-boot =
so that
> >> all the midnight oil you've burnt does not have to be duplicated b=
y others.
> > Well I dont know how to answer that. =A0Because the Mux architectur=
e is
> > slightly on the scary side. =A0I personally have had success with i=
t,
> > but everytime you need to add a new pin functionality you have to
> > update mux.h. =A0I finally decided to just focus on having the MUX
> > correct at boot up via u-boot.
> >
> > I could just add the code to update the mux without using the mux a=
rchitecture.
> >
> > I would appreciate some opinions on this.
>=20
> I get discouraged every time I look at using kernel pinmuxing.  It
> seems to assume that some mux settings are "standard" when in my
> experience that is often not so.  So I face having to write code to
> undo what it does (and face glitches on the gpio lines), or the bigge=
r
> task of restructuring the code to do the right thing.
>=20
> And up to now in each case I shrug and say "no time to do that now,
> I'll just leave kernel pinmuxing turned off and do it in u-boot"
>=20

Does it make sense to do __ALL__ pin-muxing in the board-files for
a given board? That way, we have the pin-mux setting in the kernel,
plus a nice set of debug logs from CONFIG_MUX_DEBUG to tell if somethin=
g
is not right, plus it's as good as doing it in u-boot anyway?

What say?

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
