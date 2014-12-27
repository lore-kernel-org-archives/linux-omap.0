From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Sat, 27 Dec 2014 11:46:28 -0600
Message-ID: <20141227174628.GB17608@saruman>
References: <cover.1418972323.git.amit.virdi@st.com>
 <995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
 <20141222160626.GD12815@saruman>
 <CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54858 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbaL0Rq7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Dec 2014 12:46:59 -0500
Content-Disposition: inline
In-Reply-To: <CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Virdi <amitvi128@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Amit Virdi <amit.virdi@st.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, pratyush.anand@gmail.com, ajay.khandelwal@st.com

--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 27, 2014 at 01:24:03PM +0530, Amit Virdi wrote:
> On Mon, Dec 22, 2014 at 9:36 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Dec 19, 2014 at 12:40:16PM +0530, Amit Virdi wrote:
> >> When SG is used, there are two loops iterating to prepare TRBs:
> >>  - Outer loop over the request_list
> >>  - Inner loop over the SG list
> >>
> >> The driver must stop preparing TRBs when the max TRBs have been prepar=
ed. The
> >> code was missing break to get out of the outer loop.
> >>
> >> Signed-off-by: Amit Virdi <amit.virdi@st.com>
> >
> > which bug is this fixing ? Which kernels are affected ? This need to be
> > backported to which kernel ? Which commit introduced this bug ? How can
> > I validate this to be a valid fix ?
> >
>=20
> Problem description:
> DWC3 gadget sets up a pool of 32 TRBs for each EP during
> initialization. This means, the max TRBs that can be submitted for an
> EP is fixed to 32. Since the request queue for an EP is a linked list,
> any number of requests can be queued to it by the gadget layer.
> However, the dwc3 driver must not submit TRBs more than the pool it
> has created for. This limit wasn't respected when SG was used
> resulting in submitting more than the max TRBs, eventually leading to
> non-transfer of the TRBs submitted over the max limit.

this would become a much, much better commit log than the one you
provided. It's a much more verbose description of the issue.

> Commit that introduced this bug:
> This bug is present from the day support for sg list was added to dwc3
> gadget., i.e. since commit eeb720fb21d61dfc3aac780e721150998ef603af
> ("usb: dwc3: gadget: add support for SG lists") - kernel version
> v3.2-rc7, hence v3.2
>=20
> Kernels affected:
> It is best to backport this fix to kernel v3.8+ as there were many
> enhancements/bug fixes from v3.2..v3.8
>=20
> Generic setup to reproduce/test this fix:
> This bug is reproduced whenever the number of TRBs that need to be
> submitted to the hardware from the software queue (request_list)
> becomes more than 32 on bulk endpoint. eg. if num_mapped_sgs is 2 and
> the request_list has 17 entries (hence, 34 potential TRBs), the
> scenario is reproduced.
>=20
> My setup details:
> For reproducing and testing the patches [1/4 and 2/4], I used an
> inhouse developed user space application that run on device side. This
> user space application interacts with the customized uvc webcam gadget
> to submit the video data to the DWC3 driver. The host side was running
> standard webcam application (cheese).

oh, so this is something I can't easily reproduce myself. Then I'll need
full boot logs, register dump and full trace output of dwc3 running and
exhibiting the problem. Also, make sure you use either v3.18 or v3.19rc1
to validate your changes.

--=20
balbi

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnvB0AAoJEIaOsuA1yqREASIP/12p/Eny4zSj9+tDjNtSmTK5
TPB2CKm1GS0f6N+YYhB6eikMDruURjOQZVaV6yP423aMQtJhReytL196FQrzg3Si
QCeA6T1ow+gVjATNQiH+EPvtG5GMBdEpvHeNLm4kMyiEZW9jQVMcoChAz0x6EuWa
Xg+W7CHbl2Nvg7/TFeumRBFh7lhlA+4Xmp38BDN0tFJuJ1B4+NFcYQDGRKmrhszg
GpSD2MtBtkIVKDJi8jaOwoHetFScqL0pw4vgSL8W3e+JRwxWQdFbSO38UBghiEGs
fcNHBDJTx84t40cckkcqZLkT2BEWmAGJLzQG+lTkxg8FCgEW1DWv1cTBxuU6YCse
usdYtBEPJyRhrDG90v2vEItxJAmaIn/3PCcDvId1k+IgFoJf+rYwEIEEzdPFD039
JvYdvTNfjNTqb9SPUul/7yClBxnLWk62obaAtjr4SQXGvfhYRdgla/EA5hJ4tNfE
mOJuPBm8x3IKP0gTCTTKz1Dkg1M83YLDsE4AD5AucUdrlIk8scizS+JNHixZ1Hau
uAX4++l+wAjmyK8K/gcv4eroj4CtXwroxbRiINaTlJW2tXgqYr4PyhzdvEvsapjY
Vlzp9lywutnNgyjy2w9PPyb2/dNKAEWhQ+6RbyeFk/CbN5xDQe/FazFLS707Zqb1
6nuIdt6Oa5Wt6eFMBAtM
=0RTZ
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
