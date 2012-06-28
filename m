From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 14:10:15 +0300
Message-ID: <1340881815.5037.53.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340869729.5037.7.camel@deskari>
	 <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	 <1340878461.5037.30.camel@deskari>
	 <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	 <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-sllUbsjyofyMnEOtM3ep"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51306 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752432Ab2F1LK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 07:10:29 -0400
Received: by lbjn8 with SMTP id n8so3790473lbj.14
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 04:10:17 -0700 (PDT)
In-Reply-To: <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org


--=-sllUbsjyofyMnEOtM3ep
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 16:28 +0530, Jassi Brar wrote:
> On 28 June 2012 16:17, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> > On 28 June 2012 15:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> On Thu, 2012-06-28 at 15:18 +0530, Jassi Brar wrote:
> >
> >>> >> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> >>> >> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> >>> >> @@ -243,10 +243,13 @@ static int hdmi_check_hpd_state(struct hdmi_=
ip_data *ip_data)
> >>> >>
> >>> >>       hpd =3D gpio_get_value(ip_data->hpd_gpio);
> >>> >>
> >>> >> -     if (hpd)
> >>> >> +     if (hpd) {
> >>> >>               r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON)=
;
> >>> >> -     else
> >>> >> +     } else {
> >>> >> +             /* Invalidate EDID Cache */
> >>> >> +             ip_data->edid_len =3D 0;
> >>> >>               r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON=
);
> >>> >> +     }
> >>> >
> >>> > There's a problem with this patch, which leaves a wrong EDID in the
> >>> > cache: if you first have the cable connected and hdmi is enabled, y=
ou
> >>> > then turn off the HDMI display device via sysfs, we do not go to
> >>> > hdmi_check_hpd_state at all. The next time hdmi is enabled, we only=
 get
> >>> > the plug-in event, and thus EDID cache is never invalidated.
> >>> >
> >>> If the hdmi cable is not replugged during that period, I don't see wh=
y
> >>> would you want the EDID invalidated ?
> >>
> >> I wasn't very clear with my comment.
> >>
> >> When the display device is disabled, we're not listening to the hpd
> >> interrupt anymore. So when it's disabled, the cable can be replugged a=
nd
> >> the monitor changed, and the driver won't know about it. And so it'll
> >> return the old EDID for the new monitor.
> >>
> > If that could be a problem, then we already have some problem with
> > current omapdss.
> >
> > I think among the first things, while enabling HDMI, should be to see
> > if there is really some display connected on the port i.e, HPD
> > asserted. Only if ti_hdmi_4_detect() returned true, should we
> > proceed otherwise wait for HPQ irq.
> >
> > Unconditionally invalidating edid really seems like a regression - we
> > impose atleast 50ms (edid read) as extra cost on
> > hdmi_check_hpd_state(), which kills half the purpose of this patch.
> >
> Sorry a correction. Reading detect() won't work. I suggest we keep HPD
> IRQ enabled for the lifetime of the driver.

Ok, I see. But that's not acceptable. It would require us to keep the
TPD12S015 always powered and enabled. Even if you're not interested in
using HDMI at all.

For this to work like you want we need a bigger restructuring of HDMI
and partly omapdss also. Currently we have just one big "enabled" or
"disabled" state. We need multiple states. Probably something like:

- disabled, everything totally off
- low power, hotplug detection enabled
- powered on, but no video
- video enabled

Been long in my mind, but I'm not very familiar with HDMI so I could get
my simple prototypes to work when I tried something like this once.

 Tomi


--=-sllUbsjyofyMnEOtM3ep
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7DuXAAoJEPo9qoy8lh71a4YP/1B0qWGprtPQxPomD+FCk9Bf
Ugv6IGRHaGoWY5gBxpcZgv5GW9N/oZSMKNKvwxI34UeVMI5tO3hnldSiIdiBU7bm
fBOv125aqsKbycMjoiCOZQVTZICDZ3ogQC7LJFwsI1kBFbm+bQn3OPHlj/BwofWI
a6t61OQJIox7oBPt+xNf8t0UycFxaHNZFdqZsWEGbCy1mDbbAhZst/vsHlReCMIn
SLPqsS4yD/C58jQL7nFbKMo3dYc3DTXifJNd8AmVU+OjuxT6Def0irXe1Wn/ZP1u
9bUWSbeHnbaeSRfmNjkwxlCVR4JNZRZnJZFDf+69AYbNx7qe7YbIviaJRQIWrf92
6IQCiXUNPMMbupxpkMfF32VAPN6uKB5SiognXo8FbEdIZqnA/sKzdV/aGd4PV5dU
7VqMb48LmMqZZx8FS4VkrPPtC4XWj1cwZqjRv3gzPzwiXekUcTbEnpL55l6K6CkZ
cnwWrlHcL4gPJ2I+ex90DVoyP+oiMBCwvLjd3t4HhPTjfA3fRGDM/bRg3/RmO1vt
lVRIYJZ+YXy5jTVHgSXmxtVy9xzTuuqIm/jdumYWG++KCuFpPKnUOKjopIYGcfkR
7UJEiTCZj8KU3gYUslln2+DqL8OAi2Q2rjYk76Ne/ya17Fx4aBchKKeCbZycgolw
xd7z1ksViP72acdi0vgi
=DZq7
-----END PGP SIGNATURE-----

--=-sllUbsjyofyMnEOtM3ep--

