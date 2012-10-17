From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Wed, 17 Oct 2012 19:02:00 +0300
Message-ID: <20121017160200.GA6567@arwen.pp.htv.fi>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
 <87ipag90om.fsf@deeprootsystems.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ipag90om.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 11, 2012 at 02:08:25PM -0700, Kevin Hilman wrote:
> Hi Kalle,
>=20
> Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org> writes:
>=20
> > The resume_noirq enables interrupts one-by-one starting from
> > first one. Now if the wake up event for suspend came from i2c
> > device, the i2c bus irq gets enabled before the threaded
> > i2c device irq, causing a flood of i2c bus interrupts as the
> > threaded irq that should clear the event is not enabled yet.
> >
> > Fixed the issue by adding suspend_noirq and resume_early
> > functions that keep i2c bus interrupts disabled until
> > resume_noirq has run completely.
> >
> > Issue was detected doing a wake up from autosleep with
> > twl4030 power key on N9. Patch tested on N9.
> >
> > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
>=20
> This version looks good, thanks for the extra comments.
>=20
> Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> Tested-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
>=20
> Wolfram, This should also probably be Cc'd to stable since it affects
> earlier kernels as well.  Thanks,

just to make sure we're not fixing the wrong problem... does [1] help in
any way ?

[1] http://marc.info/?l=3Dlinux-omap&m=3D135048839915719&w=3D2

--=20
balbi

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQftZ4AAoJEIaOsuA1yqREjEoQAIJxq1IAm4+9FGha13Awlhsa
d6Gy7GiJLcyliHm9577IHCEUU5wU5B1Xh5vk/ri3Vm8MIz0x33sMjKo+33EPj9Lg
JeXSsFY0L17uH4qjnq0lS5VJdk3DqkfxaLyCT7OO/G94JzFK5y/TKOOBc+SQ4rjb
nSOvx7kEiRwfyFJKPJHtk3VgtTrl03/l7DhTxOQ3Ws9JtSeAXjREJRRFY57FzP+c
XOC892ehqXdMtAWcrsCIJSdFjXYuHT/zLfv+aZWClTStpQJLzQ3qPjF/2+6/C12c
Phv8jhUZkny6P6EubNAjDJCrneNP0J69b0BI9nc2xTFOTWz7UbttCb0cDWOyPiN/
qP39gwhVkNOv+ug5DbK8gEpRoB8xgfJxcQRqWkOXAxkErmht/gP7FV6XlGjeLE95
GQi+QnvbgXc2eEtdu00NORHFMxZX2XduIna0WELBBCHQFczVTt1Aviiigcpz05Z6
V/h1fzH5+xU/d8+PMEYPQ5aZoota9VN+/aDicIDesFpS/YLIv8TJqVsemLSDmFlq
OBAXIathulxinzzrcGzHwF7ntoooXMNsYzLqHpRMCnnqyuYSskFxY+01Fr72aR2F
fUGQmleItruQIlB5KObZMoZ+9uSeIEJwEmByp4hy926AnNrw6JihxW1M/ssfaP8T
MF/BW7oI4GQmndCl1foS
=X81s
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
