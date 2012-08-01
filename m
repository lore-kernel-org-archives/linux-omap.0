From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Wed, 01 Aug 2012 12:21:10 +0300
Message-ID: <1343812870.2645.37.camel@deskari>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
	 <1343742034.2633.56.camel@deskari>
	 <CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-+WUmkUAQy3u9aEOyILo4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:36733 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753477Ab2HAJVO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 05:21:14 -0400
Received: by lboj14 with SMTP id j14so204434lbo.7
        for <linux-omap@vger.kernel.org>; Wed, 01 Aug 2012 02:21:11 -0700 (PDT)
In-Reply-To: <CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>


--=-+WUmkUAQy3u9aEOyILo4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-07-31 at 09:45 -0500, Rob Clark wrote:
> On Tue, Jul 31, 2012 at 8:40 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:

> > It's not really about being friendly. Omapdss tries to do as little as
> > possible, while still supporting all its HW features. Shadow registers
> > are a bit tricky creating this mess.
>=20
> What I mean by 'friendly' is it tries to abstract this for simple
> users, like an fbdev driver.  But this really quickly breaks down w/ a

No, that's not what omapdss tries to do. I'm not trying to hide the
shadow registers and the GO bit behind the omapdss API, I'm just trying
to make it work.

The omapdss API was made with omapfb, so it's true that the API may not
be good for omapdrm. But I'm happy to change the API.

> And btw, I think the current mapping of drm_encoder to mgr in omapdrm
> is not correct.  I'm just in the process of shuffling things around.
> I think drm/kms actually maps quite nicely to the underlying hardware
> with the following arrangement:
>=20
>  drm_plane -> ovl
>  drm_crtc -> mgr
>  drm_encoder -> DSI/DPI/HDMI/VENC encoder
>  drm_connector -> pretty much what we call a panel driver today

Hmm, what was the arrangement earlier?

I guess the fact is that DRM concepts do not really match the OMAP DSS
hardware, and we'll have to use whatever gives us least problems.

> It would be quite useful if you could look at the omap_drm_apply
> mechanism I had in omapdrm, because that seems like a quite
> straightforward way to deal w/ shadowed registers.  I think it will

Yes, it seems straightforward, but it's not =3D).

I had a look at your omapdrm-on-dispc-2 branch. What you are doing there
is quite similar to what omapdss was doing earlier. It's not going to
work reliably with multiple outputs and fifomerge.

Configuring things like overlay color mode are quite simple. They only
affect that one overlay. Also things like manager default bg color are
simple, they affect only that one manager.

But enabling/disabling an overlay or a manager, changing the destination
mgr of an overlay, fifomerge... Those are not simple. You can't do them
directly, as you do in your branch.

As an example, consider the case of enabling an overlay (vid1), and
moving fifo buffers from currently enabled overlay (gfx) to vid1: you'll
first need to take the fifo buffers from gfx, set GO, and wait for the
settings to take effect. Only then you can set the fifo buffers for
vid1, enable it and set GO bit.

I didn't write omapdss's apply.c for fun or to make omapfb simpler. I
made it because the shadow register system is complex, and we need to
handle the tricky cases somewhere.

So, as I said before, I believe you'll just end up writing similar code
to what is currently in apply.c. It won't be as simple as your current
branch.

Also, as I mentioned earlier, you'll also need to handle the output side
of the shadow registers. These come from the output drivers (DPI, DSI,
etc, and indirectly from panel drivers). They are not currently handled
in the best manner in omapdss, but Archit is working on that and in his
version apply.c will handle also those properly.

About your code, I see you have these pre and post apply callbacks that
handle the configuration. Wouldn't it be rather easy to have omapdss's
apply.c call these?

And then one thing I don't think you've considered is manual update
displays. Of course, one option is to not support those with omapdrm,
but that's quite a big decision. omapdss's apply.c handles those also.

Also, can you check again my mail "Re: OMAPDSS vsyncs/apply" Sat, 12 May
2012 10:01:24, about the request_config() suggestion. I think that would
be somewhat similar to your pre/post callbacks. I'll try to write some
prototype for the request_config suggestion so that it's easier to
understand.

 Tomi



--=-+WUmkUAQy3u9aEOyILo4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQGPUGAAoJEPo9qoy8lh71M3AP/jzY2HVapjeZomIHBIS2662/
orKzLLNn7Q74UMxOqqbebZL8er/r/JQPpaInKDDWDzgx/BNXbCGT/XaDWyawWpVb
h0L2wfZo4Nm5SuSKpGYxsG6eibcMgpSdynLjsJjtG8SxADIBujDKthJy6Shc8haF
qhZTuCY+c/qLwEYzaFZm0HJMpECdjRlbl8YOsYgb1R9VssJyiJ1rQgVWhzQbdWZN
zlqK0N7MZvK58iVcD3hFk/5DGOUWRS6BHfulTi4lg50A+hMsUOXIolhq71wdqjQL
JIcMFA+q1z60jiTzyKbF0TAqryaVC/O51D4wfdaSnB5vJdwqB4auoaMDtCMDRURB
UQoshJNVFobT5HbCjy5pG8wNg0CuY5/eUQ9ujuwapb5QN90XUYRDZtAO6VL6CKLJ
Rcjbxd3EIKZ756n5TACRg4wjTu0hRcaRsWF/iIBBZNCWm2cWIz8+ZCWdt7LvZQJ8
zyy2pDMrfK5JKxIBw67+ao5bKdNZOEy7Hp8IqnwsRqOHxte88wxl1php18WiVvaQ
p1YKkzmn8YI+GEsXgTR+4fNP7sLD7oXhdNzl6Kc1joh9YiY4tv9pEiNEegQfmzQr
T5F8v70nc7hDp9kmLXzT9qJxB2FX0Aor6X3I/iY4Mz09qKwPQEbtsJULneCgYEoI
B1DPj/r6FqDc9NsomB4g
=IZJ1
-----END PGP SIGNATURE-----

--=-+WUmkUAQy3u9aEOyILo4--

