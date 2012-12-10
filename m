From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/5] OMAPFB: connect ovl managers to all dssdevs
Date: Mon, 10 Dec 2012 10:03:17 +0200
Message-ID: <50C59745.2080604@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com> <1354881309-17625-5-git-send-email-tomi.valkeinen@ti.com> <50C5909E.8030800@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1847D1B47E6E6313216DCD4D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52709 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab2LJIDa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Dec 2012 03:03:30 -0500
In-Reply-To: <50C5909E.8030800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig1847D1B47E6E6313216DCD4D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-10 09:34, Archit Taneja wrote:
> Hi,
>=20
> On Friday 07 December 2012 05:25 PM, Tomi Valkeinen wrote:
>> Commit 5d89bcc341771d95e3a2996218e5949a6627f59e (OMAPDSS: remove initi=
al
>> display code from omapdss) moved setting up the initial overlay, overl=
ay
>> manager, output and display connections from omapdss to omapfb.
>>
>> However, currently omapfb only handles the connection related to the
>> default display, which means that no overlay managers are connected to=

>> other displays.
>>
>> This patch changes omapfb to go through all dssdevs, and connect an
>> overlay manager to them.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/omapfb/omapfb-main.c |   38
>> +++++++++++++++++++-----------
>>   1 file changed, 24 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
>> b/drivers/video/omap2/omapfb/omapfb-main.c
>> index 1df973e..24739fc 100644
>> --- a/drivers/video/omap2/omapfb/omapfb-main.c
>> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
>> @@ -2353,27 +2353,37 @@ static int omapfb_init_display(struct
>> omapfb2_device *fbdev,
>>   }
>>
>>   static int omapfb_init_connections(struct omapfb2_device *fbdev,
>> -        struct omap_dss_device *dssdev)
>> +        struct omap_dss_device *def_dssdev)
>>   {
>>       int i, r;
>> -    struct omap_overlay_manager *mgr =3D NULL;
>> +    struct omap_overlay_manager *mgr;
>>
>> -    for (i =3D 0; i < fbdev->num_managers; i++) {
>> -        mgr =3D fbdev->managers[i];
>> -
>> -        if (dssdev->channel =3D=3D mgr->id)
>> -            break;
>> +    if (!def_dssdev->output) {
>> +        dev_err(fbdev->dev, "no output for the default display\n");
>> +        return -EINVAL;
>>       }
>>
>> -    if (i =3D=3D fbdev->num_managers)
>> -        return -ENODEV;
>> +    for (i =3D 0; i < fbdev->num_displays; ++i) {
>> +        struct omap_dss_device *dssdev =3D fbdev->displays[i].dssdev;=

>> +        struct omap_dss_output *out =3D dssdev->output;
>>
>> -    if (mgr->output)
>> -        mgr->unset_output(mgr);
>> +        mgr =3D omap_dss_get_overlay_manager(dssdev->channel);
>=20
> This dssdev->channel reference is something we would want to get rid of=

> eventually, right?

Yes.

> At the point omapfb_init_connections() is called, we would have all the=

> omap_dss_devices registered, right? So at this point, omapfb will have
> an overall view of how the panels need to be connected to DSS.
>=20
> I think we can try to find a manager here for dssdev rather than using
> dssdev->channel directly. The dssdev's output could connect to a few
> managers. We would want to chose managers for each dssdev output in suc=
h
> a way that all outputs have a manager. I guess there would be multiple
> combinations for this, but it would be okay to pick any one of them.
>=20
> I think we would need some recursive or backtracking sort of approach t=
o
> get a desired combination. We can figure about how to make it work
> later, but do you agree if this is a right way to get rid of
> dssdev->channel?

Yes, I think that's a sensible approach. The thing I don't like about it
is that it requires omapfb/omapdrm to create the mgr-output connections.
They shouldn't really be interested in that. All they want is a display
device that works, and a way to get the mgr used for the display.

Well, I think we can hide the implementation inside omapdss, so that
omapfb/omapdrm will just need to call one omapdss func when they are
started, which will connect the mgrs to outputs.

A downside with setting up the mgr-output links at one go, when
omapfb/omapdrm starts, is that it creates a strict load order
restriction between omapdss, panels and omapfb/omapdrm. The drivers will
need to be loaded in that order, or things won't work.

Another option would be to pass information about mgr-output links from
the board files (or DT data) to the omapdss driver, so that omapdss
could setup them at probe time. With this option omapfb/omapdrm doesn't
need to care about this, and it doesn't create load order restriction.
But mgr-output links are something that I'd really like to handle inside
the drivers, not something that needs to be passed via platform data.

Third option, which is the best, but also something I have no idea how
to implement, would be to create the mgr-output links dynamically when
needed. The problem here is, of course, that a mgr could be allocated to
an output, only to be later found out that that particular mgr is needed
for another output.

But this is something we could study a bit: can we create such mgr
allocation system, that no matter what outputs the board uses, it'll
just work.

So, for example, on omap4, LCD2 mgr can be used for DPI, DSI2, DSI1, and
RFBI. LCD1 can be used for RFBI and DSI1. If we know that DSI1 and RFBI
cannot be used at the same time, we're free to give LCD1 to either one.
And if we know that DPI and DSI2 cannot be used at the same time, we're
also free to give LCD2 to either one. And if that's the case, there are
no conflicts.

I don't know if we can find such allocation for all current omaps, and I
know it's slightly risky as the next omap could have limitations even if
current ones do not.

> Also, we would need to do this for omapdrm separately using it's own
> encoder/connector entities.

Yep. That's also a negative side: both omapfb/omapdrm will need to
implement the same stuff, even if neither of them are really interested
in that stuff.

 Tomi



--------------enig1847D1B47E6E6313216DCD4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQxZdPAAoJEPo9qoy8lh71C1IQAJ8ZLDJIU/cOumZcrnSkZ8Si
jq5k/lQDP3BaeesNexSX5lA3hZtT0ZmzZsWwvQYWXU8cbSoWtqtOOqqIZchEXoHz
qH2y0z1iam/0jXwiUMXr6qa81OBPAXF+wnjHzRNMt011Wq9Mp7EpRN5/0jZ7J9fQ
m2FjVjPBLYBVSpv6QalnWPfR2Z46OlyKyBAuGYtsvnkbIKZWJKKX+DGO7g7CAFmm
BSoAkPaotFDwM+6l+72H0jIMs015XfaevXLeyopIRB1OXmmNK0xgEzr8BWfov4vN
abrv/v3Ge9gmcIETCc/GuMDnbnAzxlikNosfWFuTzdX2xOibqiIILzxHAfbR2uD0
gPHz5IUCec9u3PT/q2TcpjxwBTdvofQL89akU+KFHgKf/qztoMvYNqdXiqNsvtet
ZFI2yN9ISZ90GPdlSopFIhfXPZnCmbt2OxG+Hy2u6HQj5buXmUkB49xeCwJURtGR
Av26r2x1EQ9V+0HYV7iwM4qSeTeunlD2x/YgJe2xmJiD7zxYBtUadkiGrhuamo4E
QcxLV1y9OK3vjj06WeaCA8oRvMrKIPwLqhfDkCUrXWDMFIEBztd6rjXJb76WH47r
ePXA5jL7jux6evUPUgBOWrVLSEcj8Y5sSjLhKWhbs29FgLgKSdGT6jyx6xbTCgoZ
VNmrnS5YOrg0iFwMGr/i
=PPdy
-----END PGP SIGNATURE-----

--------------enig1847D1B47E6E6313216DCD4D--
