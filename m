From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 02/23] ARM: dts: n950: add display support
Date: Fri, 25 Mar 2016 01:15:09 +0100
Message-ID: <20160325001509.GA12097@earth>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-3-git-send-email-sre@kernel.org>
 <21766689.NesyW3QHk4@avalon>
 <20160317174901.GB3864@earth>
 <87lh59pdt6.fsf@intel.com>
 <20160323140105.GA31703@earth>
 <87h9fwdwh6.fsf@intel.com>
 <20160324142652.GA25083@earth>
 <87io0b52ss.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87io0b52ss.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 24, 2016 at 05:11:15PM +0200, Jani Nikula wrote:
> On Thu, 24 Mar 2016, Sebastian Reichel <sre@kernel.org> wrote:
> > As I said: I did use 864 initially. That results in missing pixels.
>=20
> Sorry, I didn't mean to question this. Go with what works, not with some
> old fart's ramblings!

No problem. I also wondered why this has been done. If I understood
Tomi right, the userspace team feared, that their software would not
work with 864, since it was originally written for 854.

Anyways I'm pretty sure, that the first 5 pixels are unusable
=66rom the users point of view.

> > I _think_, that your HW team decided to cover the first and the
> > last few pixels of the 864 display with plastic. So technically
> > it's a 864 display, but effectively it's 854.
>=20
> (*shudder* at "your HW team" ;)

;)

> It's plausible, the covers did change slightly for the developer
> edition.

Assuming the non-developer edition can use the full display it
can be "unlocked" with my proposed DT bindings by slight
modifications. I guess there exist just a couple of those, so
maybe we just ignore it for the mainline kernel?

> Good luck with the upstreaming efforts!

Thanks.

-- Sebastian

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW9IMHAAoJENju1/PIO/qa9hoQAJoMSQfgwkdaghXGN6xJ5lv2
vY9vTm9BCklLa2iSv/J4XrR082tZ/T6ZZ2HS165mXVBbCkeItQSgh94shU30Eb5u
oW/0bQPtJUnPFXTk5lUQgW3eY5VnyVHxYGffPOF/rSilGyHRYvWTSiUMuf/mF37w
ezD6tOl0zsXIcLsH1Fof3IsOEwpQjfeskA7zJ9v/dNNzP76HKaaTQBLn4bSCpYBt
+ySMyIncAju5Fr1LgC/QpLjSxauZEO6edKnfmvGZIzsqOg2Y0mKWn3ki/1jNyoay
vqdUCTTMFSIWEgw49VpYobacChtcbQ48/wuuuiBdDhi1L7YEKv2ZeSRyG6tthSdA
0nxAmGAwC/Lhp2o3qs2/dtIF2sefftvffzPabPppRu7Uyro3M58wfnKBOyL4364r
5tNsyfY0kD0I2yYLmBmAfMNY4So6ktpsXdmkYpm4ZWaOtIq6Hf3oJGtbty+0gQax
+027ji/Vtf8FDI2g/0gFTI0Wr7r+ZeWx27ur+ccw+LjYX11hyQ5PyJX0EF2jVllY
3azCH/ExuBP2mvAoXgS2/NpAX2Aplj15N1r0N8mCwaiC+sB/KQhqO3J5LGSUhUUW
RrswEpaBoXTgpUk6pWTBscFP6VgQlhtrXkSsze/gckgfuFmjaan4Lz84rH3tGLho
h5kOWkRVUvXXcaezw+/y
=OG+S
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
