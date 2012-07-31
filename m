From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Tue, 31 Jul 2012 12:57:34 +0300
Message-ID: <1343728654.4685.68.camel@lappyti>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	 <CAJe_ZhfoYoFd1AkFmb0E7=iSvZeAQRmSFONCW7jE8psCMDQ3Hg@mail.gmail.com>
	 <1343721101.4685.35.camel@lappyti>
	 <CAJe_Zheg_fpnRb+eLt5SQioSUXp=PFcPz-vWC-RL3_Mh35VBdA@mail.gmail.com>
	 <1343722450.4685.37.camel@lappyti>
	 <CAJe_Zhd4ubkfMRmVNt734N0Sc3+7OfXrgSPq-fUSH+uQfQ5RzA@mail.gmail.com>
	 <1343724140.2633.20.camel@deskari>
	 <CAJe_ZhfN1OEVq-MFdupZLjgc-LQBRred=L1o6wkd0FEDoSGUMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-WBxalYC1M74VrG42ZLzE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:41240 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425Ab2GaJ5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 05:57:40 -0400
Received: by lbbgg6 with SMTP id gg6so3997647lbb.36
        for <linux-omap@vger.kernel.org>; Tue, 31 Jul 2012 02:57:36 -0700 (PDT)
In-Reply-To: <CAJe_ZhfN1OEVq-MFdupZLjgc-LQBRred=L1o6wkd0FEDoSGUMA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Raphael Assenat <raph@8d.com>, linux-omap@vger.kernel.org, Archit Taneja <a0393947@ti.com>


--=-WBxalYC1M74VrG42ZLzE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-07-31 at 14:27 +0530, Jassi Brar wrote:
> On 31 July 2012 14:12, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Tue, 2012-07-31 at 13:57 +0530, Jassi Brar wrote:
> >> On 31 July 2012 13:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> > On Tue, 2012-07-31 at 13:33 +0530, Jassi Brar wrote:
> >> >> On 31 July 2012 13:21, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote=
:
> >> >>
> >> >> > 2) Have the configuration for countless panels specified in the D=
T data
> >> >> >
> >> >> Why should a DT blob for a board contain more than 1 panel configur=
ation?
> >> >
> >> > I meant the DT data generally, for all boards.
> >> >
> >> If you mean : Why have the configuration (those 15 integers) of the
> >> panel on a board specified in board.dtb?
> >> Well, that is an important purpose of DT - moving board specific
> >> parameters, on which a generic code works, out of kernel (I am
> >> refraining from preaching the goodness of that).
> >
> > Sure. But panel's unconfigurable properties are not board specific
> > parameters, they are panel's internal stuff. It doesn't matter to which
> > board I attach Acme Foo-123 panel, the panel timings are still the same=
.
> >
> It's not about the panel, it's about the board. For the generic driver
> in the kernel , the 'panel' is just a set of 15 integer values.
> There's no "Acme Foo-123" or "Acme Bar-123".  In fact, the _only_
> purpose of the panel's name string in the driver is to pick the
> correct set of "15 integers". With DT, the name string would be
> unnecessary.

Yes, the panel's name is used to "probe" the correct config. If we had
panels that could be asked "which panel are you" we could use that, but
with dummy panels we need to manually give the identifier (name) so that
the driver can do the probe.

> Consider two panels "ABC_123" and "XYZ_321" having identical
> parameters but different internals.
> Would you have duplicate elements in the generic_dpi_panels[] array ?
> Because the 'panels' are different.
> Or would you simply assume the XYZ_Board has the panel 'ABC_123'?
> Because after all it's the parameters that matter.

I would duplicate the elements. Or, if we have lots of panels having the
exact same parameters, we could have an array of names instead of just a
name.

> In short, we should see a 'panel' simply as a set of 15 integers.

Ok, I see. You mean that the 15 integers define the panel, so, in a
sense, the 15 integers is the name/identifier for the panel.

It would technically work, of course. But I do disagree with it:

1) I still don't see why you say it's board related. The properties in
question are properties of the panel, told in the panel specs, and
programmed when using the panel. No matter where the panel is used, the
same properties should be used.

2) As I see it, describing non-configurable device hardware properties
in the DT data is the wrong way. The driver should either probe the
properties or an ID from the device, or the ID of the device should be
given to the driver (a bit like what can be done with i2c).

3) Moving the data to DT would make any future changes more difficult.
Say, we could (probably should) add some regulator handling to the
driver, because usually panels need power to operate. Currently we just
presume the powers are always on.

Adding this is easy with the current approach. Adding it if the data is
in DT would be difficult, if not impossible, as all the board out there
could already be using the old DT format which doesn't have the
regulator data. Even in the best case all the boards out there would not
be able to use the regulator stuff.


Academic issues aside, what is the issue with the current approach in
practice? How would the DT approach make it better? Both approaches work
just fine, afaik. The current approach requires some maintenance from
me, but that's rather minor.

Anyway, even if I don't see the point, I'm not strictly against your
approach. If everybody thinks it's much better, it's fine for me. We're
currently discussing a platform agnostic approach to panel drivers with
some other SoC guys, I'll raise this question.

However, I don't want to apply the patch to move the properties to board
files. We're gonna move to DT anyway, and that patch would be just extra
stuff.

 Tomi


--=-WBxalYC1M74VrG42ZLzE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQF6wOAAoJEPo9qoy8lh71QREP/0yJCZi1LS5rzeJT+hXJXkGZ
sVdtXlFHYCH/IgQk/GeLuN7NS8zl/VOfNw+1eLdznwX8cV63cs6rB8LRC6mCUfdd
bshIlqiFFP4y3AbAuoAe9n3WVBqDT34Vdl7b4Vc0IlooqFvczrRb/0fn+4A3A9/n
V62yhjsFstV3TgAE44pThs+sYoOAP/2x6H/10SpBrCkhHDoJPClUUiqhtLEc6lIb
9VoDhXcpiX1c49Rk5LwzqLCzcAYQckncnKnBR7QvpIjDnnfDWvvGvF9iGrzT5icO
FPAoX9hgbeTkjI8Q/JSiZ51J+hmeXZ9cvq28/TkHURIntuP9o1sCbdywTLNozWRZ
kaOXTzdIqZdGM7vHRMELAejL7yoyq53x8AkaRB1eiWyawRuWSkKsApiLq9+9NlpY
J1zFGPzWF24HsiW8DcCIl1GEaqtbIb+wjFUiGOeJt/8xbd+REgwL4QzBf/lSvR2R
2uhX5/jyNegyK9hvwqkwglJIlLhh/nfPq+4ca8UHfVThsLtKeGR7qaaSW/VHMqRv
5DmzudNY8wFjUidM18YmXlUZa4SpLouU/jTyIBbBvodw5UPS1dMQEvDcLfePZw5V
UIidYxfRS13xH5cqPh2ri9tIC50lpmE8S77h5q/XYElHahn533q89b6t7qC934Sa
MjohqXu2lH3QTOiHY3lB
=4xpm
-----END PGP SIGNATURE-----

--=-WBxalYC1M74VrG42ZLzE--

