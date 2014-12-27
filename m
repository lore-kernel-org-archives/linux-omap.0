From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] usb: dwc3: gadget: Fix TRB preparation during SG
Date: Sat, 27 Dec 2014 11:44:09 -0600
Message-ID: <20141227174409.GA17608@saruman>
References: <cover.1418972323.git.amit.virdi@st.com>
 <1908f9be4bfb2148b4d2efa2dbc6de88c204e7f4.1418972323.git.amit.virdi@st.com>
 <20141222160431.GC12815@saruman>
 <CAEOkp46psaZjeMc3qQmbnV8iqoXtbPJDrORABqhCt_f9tfOZeg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56419 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbaL0Rok (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Dec 2014 12:44:40 -0500
Content-Disposition: inline
In-Reply-To: <CAEOkp46psaZjeMc3qQmbnV8iqoXtbPJDrORABqhCt_f9tfOZeg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Virdi <amitvi128@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Amit Virdi <amit.virdi@st.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, pratyush.anand@gmail.com, ajay.khandelwal@st.com

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 27, 2014 at 12:39:23PM +0530, Amit Virdi wrote:
> On Mon, Dec 22, 2014 at 9:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Dec 19, 2014 at 12:40:15PM +0530, Amit Virdi wrote:
> >> When scatter gather is used, multiple TRBs are prepared from one DWC3 =
request.
> >> Hence, we must set the 'last' flag when the SG is last as well as the =
TRB is
> >> last. The current implementation uses list_is_last to check if the dwc=
3_request
> >> is the last request in the request_list.
> >>
> >> This doesn't work when SG is used. This is because, when it is the las=
t request,
> >> the first TRB preparation (in dwc3_prepare_one_trb) modifies the dwc3_=
request
> >> list's next and prev pointers while moving the URB to req_queued.
> >>
> >> Hence, list_is_last always return false no matter what. The correct wa=
y is not
> >> to access the modified pointers of dwc3_request but to use list_empty =
macro
> >> instead.
> >>
> >> Fixes: e5ba5ec833aa4a76980b512d6a6779643516b850 ("usb: dwc3: gadget: f=
ix scatter
> >> gather implementation"
> >>
> >> Signed-off-by: Amit Virdi <amit.virdi@st.com>
> >
> > you need to Cc stable here and make sure you point out which kernel
> > versions this should be backported to. Looks like this sould be:
> >
> > Cc: <stable@vger.kernel.org> # v3.9+
>=20
> Okay. I checked the git log. The commit ("usb: dwc3: gadget: fix
> scatter gather implementation") was introduced in v3.8-rc5, hence
> v3.8, so I need to
>=20
> Cc: <stable@vger.kernel.org> # v3.8+

hehe, many folks get confused by this. New features will never get
merged upstream during the -rc cycle. -rc5 is when I applied it to my
tree so it could be merged on the following merge window, which was
v3.9.

> > Also, how have you tested this ? I need a test case to make sure it
> > fails here and this patch really fixes the problem.
> >
>=20
> This bug can be easily reproduced/tested if the gadget driver submits
> a urb having number of sg entries mapped to DMA more than 1 on bulk

which gadget driver does this ?

> endpoint. Following is the log snippet once this bug is reproduced:
> ----
> dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
> dwc3 dwc3.0: queing request 24cc5780 to ep2in-bulk length 960002
> dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 24eb6400 length 2 chain
> dwc3 dwc3.0: ep2in-bulk: req 24cc5780 dma 25901800 length 960000
> dwc3 dwc3.0: queing request 24cc5000 to ep2in-bulk length 960002
> dwc3 dwc3.0: ep2in-bulk: Transfer Not Ready
> dwc3 dwc3.0: queing request 24cc5900 to ep2in-bulk length 960002
> -----
>=20
> Without this fix, the hardware never generates "Transfer Complete"
> event for the corresponding EP and goes into an unknown state.

whiuch kernel are you using to develop this ? Most of these messages
don't exist anymore with v3.19-rc because I have converted them into
tracepoints, considering you're showing me logs with these messages,
this tells me that you're sending me a patch developed/tested against a
kernel older than v3.18. I need to see full bootup logs, a register dump
(/sys/kernel/debug/*dwc3*/regdump) and a much larger debugging log from
dwc3 in order to accept patches from you. Sorry, but I cannot take
patches which were not tested against, at a minimum, the latest major
release.

It would be much better if you developed/tested against v3.19-rc1,
considering we have 40 different patches which were merged since v3.18
was tagged.

--=20
balbi

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnu/oAAoJEIaOsuA1yqREp+wP/2AmS+qahLGZPKLszIJJi/vB
pgfowPF93oN5e8imBIzYGHxAzW2t8392X/fedifaXaDae0JOBWCYTKd+D0RJU4TD
9T6I3/7eG6+LxD3yl7eSdsPmS97LGkQvGrTr4chcYo1+AP/ZILgapBCyxUf7C/gn
3FRjGMPMGDDCofvHrgmjR0aag47eWc0fbS+SsGyAeCNdEpCQPvontUGWE+I2VJpz
lZNdmonrnAoh2OTEEj8M0ZFS2iKHLLqgT5adQarXQbocYXIWThap/73VpHBHBACn
xIAF9GCKbXveznJT6UqOO8Qd58UMWtxUOr94IaTQfajTyCDTQ61XvUDv4kusRWF+
l24YmKjxptb784T2AyU29YgCfuU6BQlvhbpSLDyC6xuKWU5kxxXXXhnOkFj78f/L
hjs7vfUctgNmspFamV4Mjl5AkHs0Rq8f3ACf3EY94UmqXCD/lkDlUHVcRuQzdYCT
ppbC9c0QUynnO8iz+W0aF7qngvLZDlmT0atciB2xZI1Z2bXKqA5oIjVnOabx8B19
OxWwmeFjZijtZiWE9KSfIKd6r6sIL1lB3+DlscNX5/npF0p0uNCDXpfl4bHLbhhX
O9dEqtrKHso+LiAhpdi1GVAUQ0stI7rZ3rPogsETyVnFSKysLcUzlaKo1GgN6iOj
vW+iYJJDRjWJIntWhDhR
=vYZg
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
