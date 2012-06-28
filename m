From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 13:14:21 +0300
Message-ID: <1340878461.5037.30.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340869729.5037.7.camel@deskari>
	 <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-kqdI7LZJDxaRccbvAZGp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:59145 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756750Ab2F1KO0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 06:14:26 -0400
Received: by lbbgg6 with SMTP id gg6so3997109lbb.22
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 03:14:24 -0700 (PDT)
In-Reply-To: <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org


--=-kqdI7LZJDxaRccbvAZGp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 15:18 +0530, Jassi Brar wrote:
> On 28 June 2012 13:18, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Wed, 2012-06-27 at 19:35 +0530, jaswinder.singh@linaro.org wrote:
> >> From: Jassi Brar <jaswinder.singh@linaro.org>
> >>
> >> We can easily keep track of latest EDID from the display and hence avo=
id
> >> expensive EDID re-reads over I2C.
> >> This could also help some cheapo displays that provide EDID reliably o=
nly
> >> immediately after asserting HPD and not later.
> >> Even with good displays, there is something in OMAPDSS that apparantly
> >> messes up DDC occasionally while EDID is being read, giving the
> >>   "operation stopped when reading edid" error.
> >
> > Btw, this is in nitpicking area, but what editor do you use? I find it
> > difficult to read text that is not formatted properly =3D). At least vi=
m
> > formats text nicely with its formating commands.
> >
> Indeed a nitpick :)
> I use vim and, iirc, checkpatch.pl gave 0 warning. Perhaps my poor
> cmoposition. Please do tell how I could I make it more appealing to
> you ?

Like:

---

We can easily keep track of latest EDID from the display and hence avoid
expensive EDID re-reads over I2C. This could also help some cheapo displays
that provide EDID reliably only immediately after asserting HPD and not lat=
er.

Even with good displays, there is something in OMAPDSS that apparantly mess=
es
up DDC occasionally while EDID is being read, giving the "operation stopped
when reading edid" error.

---

So basically two things: properly formatted paragraphs and an empty line
between paragraphs. With "properly formatted" I mean that that the text
goes from the beginning of the line to the end, so that the text fills
the whole line. This can be done easily in vim with first painting the
paragraph (or multiple paragraphs), and then then press g and w.

I think those simple rules make the text much easier to read.

> >> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> >> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> >> @@ -243,10 +243,13 @@ static int hdmi_check_hpd_state(struct hdmi_ip_d=
ata *ip_data)
> >>
> >>       hpd =3D gpio_get_value(ip_data->hpd_gpio);
> >>
> >> -     if (hpd)
> >> +     if (hpd) {
> >>               r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
> >> -     else
> >> +     } else {
> >> +             /* Invalidate EDID Cache */
> >> +             ip_data->edid_len =3D 0;
> >>               r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
> >> +     }
> >
> > There's a problem with this patch, which leaves a wrong EDID in the
> > cache: if you first have the cable connected and hdmi is enabled, you
> > then turn off the HDMI display device via sysfs, we do not go to
> > hdmi_check_hpd_state at all. The next time hdmi is enabled, we only get
> > the plug-in event, and thus EDID cache is never invalidated.
> >
> If the hdmi cable is not replugged during that period, I don't see why
> would you want the EDID invalidated ?

I wasn't very clear with my comment.

When the display device is disabled, we're not listening to the hpd
interrupt anymore. So when it's disabled, the cable can be replugged and
the monitor changed, and the driver won't know about it. And so it'll
return the old EDID for the new monitor.

 Tomi


--=-kqdI7LZJDxaRccbvAZGp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7C59AAoJEPo9qoy8lh71qfYQAIQH8LVBJzmo8R+VXTw36UYR
b+H3d7egiNTGWOcoAEl5g+8lnJiOVhv123fPj6gRNQD+t3i4isd7Li3am/Su1ELo
H4yYqqrQmi70Z4k/QYIVGSreGLqIuTNbG7KGt2dozf53GH1T8b1OHWFYRY7EjEuu
Ef14NhvYV0OwQYdx2TYtLrXqpyJ03nYCSmx6z7aOc5tYXcJQyr5xJVjc2LYxjjhw
Od4pbo35KAowtecu/gIQHkLNyohm6KoZHR1fe0TgqpIOFX3RpEUglrL502XoYImB
o8anRvzKYzZDYvub5cx6VaBTiw9x+UdewnPhgwda2ziPFPiNhJrwT9byg6PVHRp9
Q8DNOIMJJSVS4pIhfSSLIEsueyQ9Arj5eWo86vhkKMXR/CGdTsa7u1OjAXac6moV
FFsDdmLYgR5NDVqpB/OLUUwUEQi7WFX7lYBzvPHbhmhmb0dCLCg+sfgRuX3gHMg5
sxJt5smiP0++LXfn0Xnr+gN3oxshcd9TU3+NmGYpO8pcoK37RUICzX3du3RePbYI
3JsTGvx6cfydW6htJtYmi8IFr2UKXnxMRQbmbcykq/0+uQbzNls1ZdLVx1ZLlrPg
D14ke8EiUVlwJSi5ooXhmFnxd6Uu6lKoYuYlnQVO+5AsQgI+Z755knnWWepiOFor
i/lO+eblN4+PgXuKnLpQ
=o4ms
-----END PGP SIGNATURE-----

--=-kqdI7LZJDxaRccbvAZGp--

