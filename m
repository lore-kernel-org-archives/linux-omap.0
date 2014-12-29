From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Mon, 29 Dec 2014 11:12:32 -0600
Message-ID: <20141229171232.GI29379@saruman>
References: <cover.1418972323.git.amit.virdi@st.com>
 <995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
 <20141222160626.GD12815@saruman>
 <CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com>
 <20141227174628.GB17608@saruman>
 <CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43416 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbaL2RNA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Dec 2014 12:13:00 -0500
Content-Disposition: inline
In-Reply-To: <CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Virdi <amitvi128@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Amit Virdi <amit.virdi@st.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, Pratyush Anand Thakur <pratyush.anand@gmail.com>, ajay.khandelwal@st.com

--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 29, 2014 at 12:05:57PM +0530, Amit Virdi wrote:
> >> >> When SG is used, there are two loops iterating to prepare TRBs:
> >> >>  - Outer loop over the request_list
> >> >>  - Inner loop over the SG list
> >> >>
> >> >> The driver must stop preparing TRBs when the max TRBs have been pre=
pared. The
> >> >> code was missing break to get out of the outer loop.
> >> >>
> >> >> Signed-off-by: Amit Virdi <amit.virdi@st.com>
> >> >
> >> > which bug is this fixing ? Which kernels are affected ? This need to=
 be
> >> > backported to which kernel ? Which commit introduced this bug ? How =
can
> >> > I validate this to be a valid fix ?
> >> >
> >>
> >> Problem description:
> >> DWC3 gadget sets up a pool of 32 TRBs for each EP during
> >> initialization. This means, the max TRBs that can be submitted for an
> >> EP is fixed to 32. Since the request queue for an EP is a linked list,
> >> any number of requests can be queued to it by the gadget layer.
> >> However, the dwc3 driver must not submit TRBs more than the pool it
> >> has created for. This limit wasn't respected when SG was used
> >> resulting in submitting more than the max TRBs, eventually leading to
> >> non-transfer of the TRBs submitted over the max limit.
> >
> > this would become a much, much better commit log than the one you
> > provided. It's a much more verbose description of the issue.
>=20
> Okay, I'll edit the commit message.

thanks

> >> Commit that introduced this bug:
> >> This bug is present from the day support for sg list was added to dwc3
> >> gadget., i.e. since commit eeb720fb21d61dfc3aac780e721150998ef603af
> >> ("usb: dwc3: gadget: add support for SG lists") - kernel version
> >> v3.2-rc7, hence v3.2
> >>
> >> Kernels affected:
> >> It is best to backport this fix to kernel v3.8+ as there were many
> >> enhancements/bug fixes from v3.2..v3.8
> >>
> >> Generic setup to reproduce/test this fix:
> >> This bug is reproduced whenever the number of TRBs that need to be
> >> submitted to the hardware from the software queue (request_list)
> >> becomes more than 32 on bulk endpoint. eg. if num_mapped_sgs is 2 and
> >> the request_list has 17 entries (hence, 34 potential TRBs), the
> >> scenario is reproduced.
> >>
> >> My setup details:
> >> For reproducing and testing the patches [1/4 and 2/4], I used an
> >> inhouse developed user space application that run on device side. This
> >> user space application interacts with the customized uvc webcam gadget
> >> to submit the video data to the DWC3 driver. The host side was running
> >> standard webcam application (cheese).
> >
> > oh, so this is something I can't easily reproduce myself. Then I'll need
> > full boot logs, register dump and full trace output of dwc3 running and
> > exhibiting the problem. Also, make sure you use either v3.18 or v3.19rc1
> > to validate your changes.
> >
>=20
> [Quoting you from the thread of patch 1/4]
>=20
> >> endpoint. Following is the log snippet once this bug is reproduced:
> >> ----
> >> dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
> >> dwc3 dwc3.0: queing request 24cc5780 to ep2in-bulk length 960002
> >> dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 24eb6400 length 2 chain
> >> dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 25901800 length 960000
> >> dwc3 dwc3.0: queing request 24cc5000 to ep2in-bulk length 960002
> >> dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
> >> dwc3 dwc3.0: queing request 24cc5900 to ep2in-bulk length 960002
> >> -----
> >>
> >> Without this fix, the hardware never generates "Transfer Complete"
> >> event for the corresponding EP and goes into an unknown state.
> >
> > whiuch kernel are you using to develop this ? Most of these messages
> > don't exist anymore with v3.19-rc because I have converted them into
> > tracepoints, considering you're showing me logs with these messages,
> > this tells me that you're sending me a patch developed/tested against a
> > kernel older than v3.18. I need to see full bootup logs, a register dump
> > (/sys/kernel/debug/*dwc3*/regdump) and a much larger debugging log from
> > dwc3 in order to accept patches from you. Sorry, but I cannot take
> > patches which were not tested against, at a minimum, the latest major
> > release.
> >
>=20
> Yes you're right that both the fixes [1/4] and [2/4] have only been
> build tested with the latest kernel. I should have mentioned this
> information in the commit message or the cover-letter itself.

yeah, you should've :-)

> The only reason why I have not been able to test these fixes on the
> latest is because the customized webcam gadget is not ported on the
> latest kernel. There have been a lot of changes in the video framework
> lately and that is not my area of expertise. So porting the customized
> webcam gadget to latest kernel and testing these fixes is not feasible
> for me.

right, so while I can see that both patches are very minimal and likely
to be correct, I have no way of guaranteeing that. The only thing I can
do, is run the tests which I already run (none of which exercise the
cases you found though, other I'd have found them already) to make sure
your patches don't break what's already working.

> Having said all this, the fact remains that these are bugs in the dwc3
> driver from kernel v3.9 onwards. The log messages clearly depict this.

no, it doesn't :-) your log snippet is so small that I cannot see how
the driver got to that point :-) The only thing I can see is that you
started two requests, one for 960000 bytes and another one for 2 bytes,
but I don't know how many TRBs we had available, nor do I see a Start
Transfer command, so I can't validate Start Transfer command parameters
were correct or not.

> These bugs are obviously present till date.

Right, the code is the same :-)

> I ask you to give a more deeper thought on the whole situation and not
> undermine the importance of code review.

heh

>  - [Patch 2/4] fixes a bug that could have been found in the code review.
>  - [Patch 1/4] fixes a bug which was very very subtle but a deeper
> code review can certainly boost the confidence about the change made.
> list_is_last won't work when SG is used because, for the last request
> in the request_list, the TRB for the first sg entry modifies the
> list's next and prev pointers while moving the URB to req_queued.
>=20
> I can certainly provide the dwc3 specific kernel bootup logs, full
> regdump and any loglevel you want me to, if that helps

Yeah, if you can provide those, then that'll help me verifying. Full
logs from boot to failure point with VERBOSE_DEBUG enabled (considering
you're not running on anything recent).

--=20
balbi

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUoYuAAAoJEIaOsuA1yqREqxQQAJKJR2mrdkUSEmvesGsDv/HA
4nMbmy256MyqrYpigYy9D5LGRHw0/ccLbvMEFyiWSM/rVxotRle0JDxj0Gd8wv15
mZXBxokf9O33k8h/8tq+eP0hGGmXapqXddkrAMh485GF72ncvBHHx8VHqPpuBF+5
7GmXgnTefTGpNpkWb8xn/87qzisroizP68OWEyWJYoU2YD6FKjKyxavGGzgSZl1D
j/RNT1gV4hiSfXuRyQqzUYk4C6Rf1MVRZFMqKoHKG2HtZpxMw5lnc7UGLoN2VtRt
7RR9BtqVb81+tGgrq6h7qZ86sF2Gv/VXgdwdYhMJdHkNVYsF2F0f4X6FhI2lzunj
DrkyUFXmAo5N1YAr7xVJgZdcFHyMvwHiXQy8haqPNH6CUIPWRfPtLt35hRJpckTh
Tzgx+oSGlepY1QZLKjOtQy4+E43ozuMHJa1E3tufOHmwWqDVyXXztAAWdzy11TpD
oU0PbqknWmJh6AySg7KUAFs85OWVWfECxCGAkf/AoFhkUqtBrFMERs207qmLH5LT
HzvVCjoW81jXdMfq+qPK77f/0J89YpQk9dZmw+RCWWZa/CtlYYkcM8+Wnp+jaQXW
KFMij1e2RrjCqr7fiZYW0R6HDUtLwJdFFxRnv8zH6xnfXL2F2naomSrFfswdRCiv
Tcat8TmQjzSReR9O5VSL
=C7GC
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--
