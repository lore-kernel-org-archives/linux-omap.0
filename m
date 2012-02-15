From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/5] OMAPDSS: Export functions to enable dynamic linking
Date: Wed, 15 Feb 2012 10:23:25 +0200
Message-ID: <1329294205.1892.36.camel@deskari>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
	 <1329004530-28029-5-git-send-email-ricardo.neri@ti.com>
	 <1329140906.2817.6.camel@deskari>
	 <1329264022.2031.1570.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-8Ha+uK67YA+HeHT9PSGA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36661 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757959Ab2BOIX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 03:23:29 -0500
Received: by mail-lpp01m020-f174.google.com with SMTP id m4so587391lbo.33
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 00:23:28 -0800 (PST)
In-Reply-To: <1329264022.2031.1570.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org


--=-8Ha+uK67YA+HeHT9PSGA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-14 at 18:00 -0600, Ricardo Neri wrote:
> Hi Tomi,
>=20
> Thanks for your comments.
> On Mon, 2012-02-13 at 15:48 +0200, Tomi Valkeinen wrote:
> > Hi,
> >=20
> > On Sat, 2012-02-11 at 17:55 -0600, Ricardo Neri wrote:
> > > The functions dss_init_hdmi_ip_ops and dss_has_feature are used by
> > > the ASoC HDMI codec. Both the ASoC codec and DSS may be built
> > > as separate kernel modules. Hence, these two functions need to be
> > > available for dynamic linking.
> >=20
> > Neither of those functions should be exported, they are omapdss
> > internal. And you had to hack around to make those usable by adding
> > drivers/video/omap2/dss into the include path.
> >=20
> > Anything that is exported from omapdss should be added to
> > include/video/omapdss.h. Users of omapdss should never include anything
> > from drivers/video/omap2/dss.
> >=20
> > But as I said, neither of those functions should be exported, they are
> > clearly omapdss internal functions. For dss_has_feature we probably nee=
d
> > a new function to convey the information about the hdmi features that
> > the audio side needs. Or perhaps it can be in the ip_data.
> I will try to create this new functions and add it to
> include/video/omapdss.h and resubmit the patch. The approach that I am
> following is to maintain an hdmi_ip_data structure in the ASoC HDMI
> codec driver to utilize the functions of the HDMI IP library. If the DSS
> features are stored in the ip_data then I would need a DSS function
> (i.e., dss_features_init or similar) to initialize it. This may not be
> right as that is an omapdss internal function.
>=20
> >=20
> > For dss_init_hdmi_ip_ops I don't see why the audio part should see it.
> > Initializing the ops should clearly be done by omapdss automatically.
> Yes, the DSS HDMI driver already does this for its own struct
> hdmi_ip_data. However, under my approach, the hdmi_ip_data of the ASoC
> HDMI driver needs to be initialized as well.

Ah, I see, you create your own hdmi_ip_data there. I don't think this is
the right direction to go...

I have a feeling that this won't be an easy task.

> Another approach is to not have an hdmi_ip_data in the ASoC HDMI driver
> and reuse the ip_data of the DSS HDMI driver. In that case, however, a
> lot of set/get functions would need to be implemented in DSS to expose
> audio functionality: HDMI mode, deep color configuration, audio
> infoframe config and core and wrapper configuration for audio. An
> example of this is already present in here:
>=20
> http://www.spinics.net/lists/linux-omap/msg64479.html
>=20
> Being HDMI special as no other display combines audio and video, maybe a
> special header file could be created for HDMI.

We will have the same issue with DisplayPort, so it's not that special.

The HDMI and DSS architecture doesn't currently have a way to do this
easily. I'm not even sure how this should be done.

However, I think the audio driver should be a bit similar conceptually
than, say, omapfb, but for audio instead of video. What I mean is that
the audio driver should find the omap_dss_device/driver that it wants to
use, and then uses the API offered by the device/driver to handle the
audio.

This would mean adding a bunch of functions into omap_dss_driver.
Preferably the functions would be non-HDMI specific, so that DisplayPort
could use them also, or actually any other display type.

The audio driver should iterate the dss devices to find the ones (there
could well be multiple HDMI outputs) that support audio when the driver
starts.

Does the above make sense?

Btw, another thing, not directly related:

I see these in the hdmi driver:

 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
        defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)

If the audio driver is separate, I don't see need for those. In fact, I
think they are wrong in that case. The HDMI driver should have the audio
support for any user, which could in theory be some other driver than
the audio driver you are working on.

If the amount of audio code is big in the hdmi driver (which I guess it
isn't), we could have a hidden kernel config option to enable the HDMI
audio support. And the audio driver would use Kconfig's "select" to
enable it.

 Tomi


--=-8Ha+uK67YA+HeHT9PSGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPO2t8AAoJEPo9qoy8lh71lq4P/3PNOC1EB5FBWtuYnuDnz8Dj
Wn+IOOW6sjfywf8m/35m/FfaKj642CXCMzC+/X7RbkGchis/f2TpIZ1FRjUF58wC
+n/xZeaVV4a0/hfvTx+xKSyr/LorI/5g3rWKX1u4q4oSQtz/p9RQOptPh3utWqpD
m00h3xbktBMpGsqTOidjFjKomWAuNIQfNb5H8ytDets1qAZOxtrAJ33EVpQ5fkhZ
gGnjH/zbo3PXny75QnIhkEfLoCjj2NQf4rlN184g5rGG5kwR50Yr+n5HaMV8MLkB
oMK05sls9iuTP1dIv05K13P8mVhRRWgXTSKPMAHz83Zam+vbfV2Qc6adbNRZZjY8
96HDPdfX6+bng2Mf70dF6zgt+hQFotFNF+9SxBhu4UaKxyY2bqUiRFmvBOpM2aph
+s88i6Gn5cgYsfu+qPhzN/uLQlEEuiEOdZJL+0Z5aJkv6DZGBviU8EZisHV8pIQd
44LSwXztxe5WZjIrlNn5JWU4gQUFjbTIfdAewPg9qjWHsqSzTAtTkP+W4ybwDH0y
4U5LwHdlgRpOeZNyh/O8s/LWcnqn7mL5ll1UB3cW5a9v0Te9JtRF2aqIXZQM4blK
tU3nq8lWD8SXXrWRUMhTcamFD4/VIdpDKTesGr2HDVtG5KPqRXWHZA1zCJd1hbBV
VnqpRdxiGiokjr8SPEJC
=LAfk
-----END PGP SIGNATURE-----

--=-8Ha+uK67YA+HeHT9PSGA--

