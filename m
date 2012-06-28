From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 16:31:18 +0300
Message-ID: <1340890278.5037.91.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340869729.5037.7.camel@deskari>
	 <CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	 <1340878461.5037.30.camel@deskari>
	 <CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	 <CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	 <1340881815.5037.53.camel@deskari> <4FEC47FA.1040801@linaro.org>
	 <CAJe_Zhdkhu4TciiwGJB2Kz8oZp2RQNZfESSr5Cfv0R1MNn=r9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-j8zU8B36FDxU2Ay1eBg3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:46717 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751652Ab2F1NbX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 09:31:23 -0400
Received: by bkty8 with SMTP id y8so2158676bkt.31
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 06:31:20 -0700 (PDT)
In-Reply-To: <CAJe_Zhdkhu4TciiwGJB2Kz8oZp2RQNZfESSr5Cfv0R1MNn=r9A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Andy Green <andy.green@linaro.org>, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, n-dechesne@ti.com, patches@linaro.org


--=-j8zU8B36FDxU2Ay1eBg3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 18:43 +0530, Jassi Brar wrote:
> On 28 June 2012 17:33, Andy Green <andy.green@linaro.org> wrote:

> > If Jassi's alright with it we might have a go at implementing this, but=
 can
> > you define a bit more about how we logically tell DSS that we want to, =
eg,
> > disable HDMI totally?
> >
> A quick reaction of my guts say, we simply enable 5V/HPD_IRQ during
> probe and disable during remove.

The problem with this is a feature of omapdss: we can have multiple
displays for the same output, of which only one can be enabled at the
same time. What this means is that you shouldn't (and in some cases
can't) allocate or enable resources in probe that may be shared, because
then the driver for both displays would try to allocate the same
resource.

Sure, this is not a problem for the HDMI configuration we are using now,
but it's still against the panel model we have. Thus we should allocate
resources only when the panel device is turned on, and release them when
it's disabled.

I do think the model is slightly broken, but that's what we have now.
And I'm also not even sure how it should be fixed...

And also, as I said earlier, if you keep it enabled all the time, it'll
eat power even if the user is never going to use HDMI.

On a desktop I guess the power consumption wouldn't be an issue, but I
do feel a bit uneasy about it on an embedded device.

> HDMI enable/disable via /sysfs/ and HPD (de)assertion, switch only
> HDMI_PHY on/off.
> The user selecting "Autodetect and Configure" option would then equate
> to "(un)loading" of the HDMI driver.

HDMI cannot be currently compiled as a separate module. Although I think
you can detach a device and a driver, achieving the same. Is that what
you meant with unloading?

 Tomi


--=-j8zU8B36FDxU2Ay1eBg3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7FymAAoJEPo9qoy8lh7123kP/162EklV443bgG4K1LM/R3XM
cKr+sBr3aNM2TefYBONvlnvGnmkERtvgx31mexl13+bAZUYunnCMud//6PY4VNFn
a30a9NAozgoxG33TGOHLEi2wWUiExY8xYXknaYCWq+cr2eQFrgwO8QlDZS/L9ACa
DTrUEQK7G5mGcrAYZAYAxchJP21gP/iliBDyOktVY57TcVgcwbbhFf+MNyfKx24J
tGwTNNqYOta8XZ63BntOKVNNK8vjzD+LEILpDxmmg8iRi1w6E03oi6QsQow3JRDg
e60j/j/tolX13NMqGPzsUI2jrahrxyTHQjOyVXf341We0O7AkamiNvAW+MWJvDz1
RcS/1cBoN7xgDj5BmliP+/NA/dGBlrfkpVrWxbau4rqP2RXjotZ0/ZHCM1QB0Go+
7cKkkwLIRXycWK61jG/kpap+RwqXo/rKsGqIt5pn1EpiX/q/4rXNk0TBvOXna6uv
6cFhcuSGYRO0fw6H0GGDY8uNNwqFlWdoblmVp0dpCa7Q3fQlnonWHEFjbbjHZLBA
c2fL21YmON5qVB3GQ9ZmWPfIR6+sjAk3l3nI69S47LJM96LXwv940di3modvze7V
ZkavqZgOJ4xBfP2uVJ5HXW8+SRdYl+roB1sQfIH06jbYXiTQ2a9FdgeaeAkdmFWK
8cV++HD8CJHCs4L/ftYc
=ZP1C
-----END PGP SIGNATURE-----

--=-j8zU8B36FDxU2Ay1eBg3--

