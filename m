From: jacopo mondi <jacopo@jmondi.org>
Subject: Re: [RFC PATCHv2 4/9] drm/tidss: add new driver for TI Keystone
 platforms
Date: Tue, 31 Jul 2018 11:08:58 +0200
Message-ID: <20180731090858.GC5386@w540>
References: <20180618132242.8673-1-tomi.valkeinen@ti.com>
 <20180618132242.8673-5-tomi.valkeinen@ti.com>
 <5639385.hcqW4L2iP8@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0744083679=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5639385.hcqW4L2iP8@avalon>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============0744083679==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Laurent,

On Mon, Jul 30, 2018 at 05:12:15PM +0300, Laurent Pinchart wrote:
> Hi Tomi,
>
> (CC'ing Jacopo Mondi for a comment about bus_formats in bridge drivers)

thanks for CC'ing me

>
> Thank you for the patch.
>
> On Monday, 18 June 2018 16:22:37 EEST Tomi Valkeinen wrote:
> > This patch adds a new DRM driver for Texas Instruments DSS6 IP used on
> > Texas Instruments Keystone K2G SoC. The DSS6 IP is a major change to the
> > older DSS IP versions, which are supported by the omapdrm driver, and
> > while on higher level the DSS6 resembles the older DSS versions, the
> > registers and the internal pipelines differ a lot.
> >
> > DSS6 IP on K2G is a "ultra-light" version, and has only a single plane
> > and a single output. The driver will also support future DSS versions,
> > which support multiple planes and outputs, so the driver already has
> > support for those.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---

[snip]

>
> > +static int tidss_encoder_atomic_check(struct drm_encoder *encoder,
> > +				      struct drm_crtc_state *crtc_state,
> > +				      struct drm_connector_state *conn_state)
> > +{
> > +	struct drm_device *ddev = encoder->dev;
> > +	struct tidss_crtc_state *tcrtc_state = to_tidss_crtc_state(crtc_state);
> > +	struct drm_display_info *di = &conn_state->connector->display_info;
> > +
> > +	dev_dbg(ddev->dev, "%s\n", __func__);
> > +
> > +	// XXX any cleaner way to set bus format and flags?
>
> Not that I know of :-/ Jacopo (CC'ed) started working on support for bus
> formats in bridge drivers, which you might be interested in.

For reference the series Laurent's talking about is:
https://lkml.org/lkml/2018/4/19/143

with these bits being the most relevant ones:
[add DRM bridge helper to store the bus format]
https://lkml.org/lkml/2018/4/19/164
[make use of those helpers in a bridge device]
https://lkml.org/lkml/2018/4/19/161

For my understanding of issue here, more than a requirement for
storing bus formats in bridges (the code here goes directly to the
connector format) this is another driver betting on the first
available media format reported by the next DRM pipeline component
being the 'right' one.

I've seen a few DRM drivers to be honest, but most of them would
benefit from a proper format negotiation API implementation in DRM.

Maybe I've been unlucky and that's actually a corner case? :)
I tend to think it's not, but you people with more DRM experience
could tell better than me, also considering the always growing
complexity of video pipelines in embedded systems.

Thanks
   j

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbYCcqAAoJEHI0Bo8WoVY8UOgP/RZZ79qDS0+iRjJ39iJgOeFf
WBUu4rEaQlNDztjpEHQJo9+cGQqCo7U4+0wSADq7/dJLJgFcM/+bFXr43/AeSD1Y
lK3kwM30CRtulqG1IjPGb9vDln4wgVCHwQXgARz6c7hTElYxgAmrgkwIt5x3KODR
CDk20HDiPBV9gfYVuqNz8JZwGe+GGTpurdyM9XfJw5z0ELdvGyqRUgaYJxiXeQ9J
1wUpYobG+3m7qFghkI3wMkei/FTLEmo+EZpPe4G+5GwwTGjZiX8HdaKYh8Fz0Iky
lVBn4wv3R/eHGI39Tb3967WS955AzNKU5uNK459klMUEc8OnWTMlA47DtdDrJtnl
TycxzchXtOjEFBP3CDXKq8g5rYX2jidgC4+gzd/I9bk30gH7uiBWEyte+fQYaNkQ
299Bvt6d/bgDLmhnuhMxu5KdkGlbi4dNlm94NLFH6Md1k76on6p3JB5DgfnDq3+U
2SzfkPLQ6undbNRTsjSv+pE6XXpKuuyBp7R4R4hAWHreG/4KABftm3mj4nP+ghGd
QpwxuAOqn6//SgK8+HGe8SnYe11aTwLvYh41H3yFMvGDVnSgzb3drJ5CDl+BKN2l
7KTGE5VKn0JVTP8buvnrNvuV6nACUCCpq/a4s1d5FK9gxgM60sNKWg72jB9B7RQJ
xydelVfS6Mog6CoEf+CU
=65eu
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

--===============0744083679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0744083679==--
