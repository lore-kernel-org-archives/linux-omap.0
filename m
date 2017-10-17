From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] usb: isp1301-omap: Convert timers to use timer_setup()
Date: Tue, 17 Oct 2017 11:09:56 +0300
Message-ID: <87376ikxez.fsf@linux.intel.com>
References: <20171016232923.GA101254@beast>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016232923.GA101254@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Kees Cook <keescook@chromium.org> writes:
> In preparation for unconditionally passing the struct timer_list pointer =
to
> all timer callbacks, switch to using the new timer_setup() and from_timer=
()
> to pass the timer pointer explicitly.
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Tony Lindgren <tony@atomide.com>

do you want me to take this through my tree?

If you wanna take through yours, here's my ack:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlnlutQACgkQzL64meEa
mQZMWg//UwODuqBKNNrFO6veExcEii+DiV8QXBf62rQU5MCsTS0fEWLlA61nxck0
dIOKwxLe/h7Y0/Fp+8a/udsb3f+7iZYj+IG4MZfiTn5/noCDrOHYftT2ZZcliyVd
Eeba6/M4woHaPJL33nSmWnxH0dn4VweWAr9dNHgC09CNzezB+0q+s3DtHuePBatQ
vrDWLfMfDdJY0Y1DllLWAUgTPSiSrOq7F4uNoOc83463XRkuZD8De8meC95i/rYc
EAz0s+51kckLVSU3+tTRsn1pHl6MrPCraFcGyoeQ1kpi7xv2Dym5coscKBjqINrk
27WsmkN5j2Ef/bKILwnwirUX1KydGPSlQJUI/FOh22BPS/zFnD3ShTl/3vBTVEcq
SQB5iVmhyqfDsExbNMZhgjXLQThZs4ZvMwkcU9EHL8CvODd4Qp8JDFa81MEoK0D9
hAmUtlqf4MdPa4VS8kt7ZxawLJHn/1mxuWJtXYmjSvNmyKyyas7DqL1H56CFNcLb
1Oo+wqRvEJZCp48/FFVZe8VuqUizbAum9LmBXUj589Tg3pB7hURVt4bILEs+NQZW
oefms6Ob7qU2F4LPsgypIaKZxttaMqhrIW4YzlYameXKE/247cR5lRIYvRjxbQF0
eCl2ezGxCMqcRIxFZom1eHAubPopi/ITm78915wrJLPCEhG3HTA=
=hefD
-----END PGP SIGNATURE-----
--=-=-=--
