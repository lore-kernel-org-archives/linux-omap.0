From: Sebastian Reichel <sre@kernel.org>
Subject: Re: omap4: support for manually updated display
Date: Mon, 10 Sep 2018 23:28:20 +0200
Message-ID: <20180910212820.ygr3japdw6td2qvm@earth.universe>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dw66pgggewo6aiya"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3205865.8O8aibZXye@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Pavel Machek <pavel@ucw.cz>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--dw66pgggewo6aiya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 10, 2018 at 03:24:37PM +0300, Laurent Pinchart wrote:
> On Monday, 10 September 2018 14:59:23 EEST Tomi Valkeinen wrote:
> > On 30/08/18 12:04, Pavel Machek wrote:
> > > There's neat series of patches on
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git=
/log/
> > > ?h=3Ddroid4-pending-v4.19
> > >=20
> > > They enable display support for my hardware. As you can imagine,
> > > display is rather important for a cellphone.
> > >=20
> > > Tomi, can you take the patches? I can resubmit them in email, or
> > > shuffle them to another branch without mfd changes, or clean them up
> > > etc...
> >=20
> > A large omapdrm change set from Laurent was merged into drm-next, and
> > I'm certain they conflict with this series. Laurent also has continued
> > that work, and while those new patches haven't been sent for review yet,
> > I fear they'll also conflict with these.
> >=20
> > So in the minimum, a rebase on top of drm-next is needed.
> >=20
> > I also continue to be very worried that adding DSI support to omapdrm at
> > this stage will be a huge extra burden for Laurent's work.
> >=20
> > We should transform the panel-dsi-cm.c towards the common DRM model.
> > With a quick look, there seems to be a driver for Samsung's S6E63J0X03
> > panel. So possibly all the DSI features are there in the DRM framework,
> > but someone needs to check that and start working on panel-dsi-cm.c so
> > that it's ready when we finally switch to the DRM model.
> >=20
> > In my opinion, which I've also expressed before, the above work is much
> > easier to do by first changing the omapdrm to DRM model, without any DSI
> > displays, and then add the DSI command mode support. But if people
> > insist on adding the DSI support already now, I would appreciate the
> > same people working on the DSI support so that Laurent doesn't have to
> > do it all.
>=20
> I want to make it clear that I don't want to claim any privilege in getti=
ng=20
> patches merged first. I am however worried that, without an easy way to t=
est=20
> DSI support, and without enough time to focus on it, I would break whatev=
er=20
> would be merged now in future reworks. I would thus like to find out how =
to=20
> collaborate on this task, hopefully to move towards usage of drm_bridge a=
nd=20
> drm_panel for DSI-based pipelines.

I'm currently quite busy and barely find enough time to do my work
as power-supply subsystem maintainer, but I already started to
rebase the series. I agree, that it would be very nice to move towards
usage of common DRM framework(s), but it's also nice to see which
patch breaks DSI ;)

P.S.: Laurent, if its helpful for your work I'm willing to sponsor
a Droid 4. It's OMAP4 based and uses a manually updated DSI panel.

-- Sebastian

--dw66pgggewo6aiya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluW4fEACgkQ2O7X88g7
+poXihAAqi26GWZFTILEwOqVcbq+FOWXtFvc3L2YpIruW3Q0AaDpz0AJonH1yBsK
s05sjpe/ZgbhwYwr1xGLnRNsMGa4C5gHMARsbm2g3WT8XPuTfmtvMSQLh6w8n/L/
X40Lyq09N96bZZ6WomzGszQJa++VpT03KVCjdo32jngH3w4M/7VJOIUQo56O5A3o
2ZKwYcTKX8Om9yuXlpyb+bwyLPqBbEcJgFSsFKN8H6aXxnY7wWn8qM95Pjrzaz16
Rxl3Pb+TvDdAGPRbdUsaFREN1SzW/LO/4vwNNaDoT6VTUtrER+PpPAyNBOHeOQLy
y8oULoihhnLuM6IFOkviJw2BPQuqy73nfirLPqudi5YmECrbtiNJRKDwwvhrbL4F
OD8xGhPvH6oYSdAVj5k5YdpSWhzfjDHs3RvSCrCbMePebGl2J32lpdWvDIgH09jW
ibatXWQIfMlfOeQpvW1xTHiwD26sOBfeqXe82Qy67IX6gmDlw5+1FM5ASO+NgfZx
/DyV41bgyhvUVKeVTUK+buPHN9cpWMxVidQtetKTfM9dikPTJEokqUieqRoyVEV7
88kQeBayN86lM/jvkmpei09bNUeQ5jC6RHPxWFEnOSKlE1rZ1wio4S+QCX5CG1jy
XEOahufTYJx/mcMoXEa3t4Tx3jmM7mPpoNKaaypjuf21oDZT+3E=
=vMAI
-----END PGP SIGNATURE-----

--dw66pgggewo6aiya--
