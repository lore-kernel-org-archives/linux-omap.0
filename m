From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Cache EDID
Date: Mon, 25 Jun 2012 11:11:35 +0300
Message-ID: <1340611895.3395.14.camel@deskari>
References: <1340438806-25622-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340606154.12683.34.camel@lappyti>
	 <CAJe_Zhf1RsDtKXOpQ97Am-ByBYUtOgjJYyySGYGL9zHNYB_Ejw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-y28E/33xMLuTykAtRSpN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:55236 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751088Ab2FYILa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 04:11:30 -0400
Received: by lbok6 with SMTP id k6so7695918lbo.32
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 01:11:27 -0700 (PDT)
In-Reply-To: <CAJe_Zhf1RsDtKXOpQ97Am-ByBYUtOgjJYyySGYGL9zHNYB_Ejw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-y28E/33xMLuTykAtRSpN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 13:26 +0530, Jassi Brar wrote:
> On 25 June 2012 12:05, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
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
> >>
> >> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> >> ---
> >>  drivers/video/omap2/dss/hdmi.c            |    1 +
> >>  drivers/video/omap2/dss/ti_hdmi.h         |    2 ++
> >>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   23 ++++++++++++++++++++=
---
> >>  3 files changed, 23 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/=
hdmi.c
> >> index 900e621..0a8c825 100644
> >> --- a/drivers/video/omap2/dss/hdmi.c
> >> +++ b/drivers/video/omap2/dss/hdmi.c
> >> @@ -764,6 +764,7 @@ static int __init omapdss_hdmihw_probe(struct plat=
form_device *pdev)
> >>       hdmi.ip_data.core_av_offset =3D HDMI_CORE_AV;
> >>       hdmi.ip_data.pll_offset =3D HDMI_PLLCTRL;
> >>       hdmi.ip_data.phy_offset =3D HDMI_PHY;
> >> +     hdmi.ip_data.edid_len =3D 0; /* Invalidate EDID Cache */
> >>       mutex_init(&hdmi.ip_data.lock);
> >
> > Your HDMI patches seem to depend on each other. Please post them as a
> > proper patch series, instead of each one separately.
> >
> They don't depend functionality wise. Any fix can be accepted
> regardless of others.
> I deliberately avoided a series, because revision of just one could
> require resending 3, otherwise
> perfectly OK, patches. I just wanted to limit the noise.

You don't need to send the whole series, you can just send a revised
patch as a reply to the older version of that patch. (see --in-reply-to
of git send-email).

Of course if you end up changing many of the patches, or one patch lots
of times, it is good to send the whole series at some point later when
the patches have stabilized.

> I understand, 'git am' might complain but I think that should be trivial =
to fix.

I'd rather not spend time doing trivial fixes, or trying to find latest
versions of individual patches that have dependencies. Having the
patches in a series and replying with new versions to the older versions
makes my life much easier. I'll see all of them in my email client in
one bunch, properly sorted.

> I am perfectly OK to resend as a patch series, if you want.

Yes please.

> >>  bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
> >>  {
> >> -     return gpio_get_value(ip_data->hpd_gpio);
> >> +     if (gpio_get_value(ip_data->hpd_gpio))
> >> +             return true;
> >> +
> >> +     /* Invalidate EDID Cache */
> >> +     ip_data->edid_len =3D 0;
> >> +
> >> +     return false;
> >
> > Why is this needed? The HPD interrupt should handle this already. And i=
f
> > the HPD interrupt doesn't work for some reason, this won't work either,
> > as the user can plug and unplug his HDMI monitors a thousand times
> > between two detect calls.
> >
> I thought it is almost impossible to unplug->plug cycle the HDMI cable
> even twice a second, let alone 1000 times against the 10Hz .detect()
> poll  :)    Or you mean some relay controlled HDMI switching
> mechanism?

omapdss doesn't call the detect function, so it can't presume it's used
in some certain frequency. Also, last time I tested omapdrm, I think
detect was called once in 5 secs or so.

>  Anyways, that is not the point of this patch. This patch only aims to
> avoid un-ncessary EDID reads while doing its best to make sure we
> invalidate EDID 'as soon as possible'.

I'm not sure I understand your point. If the HPD interrupt works
properly, EDID is invalidated there, and the code in detect is not
needed. And if the HPD interrupt doesn't work (although I don't see why
it wouldn't), the code in detect doesn't work. In either case it's not
correct.

 Tomi


--=-y28E/33xMLuTykAtRSpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6B03AAoJEPo9qoy8lh71Dh4QAKojO4rVPwywmKjFZBNyvjzb
aNrpTzQhHYXiqBxEUef1fybBGqFgE4c5cqZP8BIVyCByDY1cDqS0C8F/VxRuJSfY
aKNZZuOgECz8bpwqI3/jBKP3x5kx6tfxiEJfaZ4lqlcrFL8GDddn8UiIAnq38WSJ
82MRYqNklQEJR6ReVa/PjwTPU9cv/yFGNOQ5aX7p48r595HCFmMNF23z1v+fgTgW
5o++gZbGViK8AUWVCc7eeEt73EfUWYoos8ZiNEn2fulxZp5EmnkHdyrYszNmyC0V
18GcVeVKyxWQfozC/q8tV4T7OqDShSZ0XCwQlBhsUcyJd6C1ZYJHvGkP+9Pzggsh
JHq6IDHXS65s6XT/bncTuwKlD//j9OWdUr/SSinJXVy8oeZe2lA0Mqjrw2TgkdNz
lFtVOYjskTaoJzxd0uMoxEgkUsbjbRQLuulNbpQq2lgrt237uYa0nTRCuTIM0A2G
ocIyC5fXhXrdjzHZGvS+EzKEzhHLmoYEzuXFU/+4qRgmmn5JbgWBV74EMK1tDPCH
1K9fKFR4ag6iM3BNRRwCNM6gaQq3YkmSBQHzcFZkCLuRwM/gu7LHJUzpOs/NldqH
sqGYIhZSf4N6tn6+5r6NhazCAfBVxhe82gRgUC7ypnR84vFr4KUeCzh7xzXcf3iz
frTVGzaZ1O0wp6FIQFqh
=A/Xq
-----END PGP SIGNATURE-----

--=-y28E/33xMLuTykAtRSpN--

