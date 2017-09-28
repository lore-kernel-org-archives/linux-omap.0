From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v2 16/31] usb/phy-isp1301-omap: Remove .data assignment
Date: Thu, 28 Sep 2017 12:36:15 +0300
Message-ID: <874lrnkvw0.fsf@linux.intel.com>
References: <1505950075-50223-1-git-send-email-keescook@chromium.org> <1505950075-50223-17-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505950075-50223-17-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Kees Cook <keescook@chromium.org> writes:
> The .data assignment appears to be redundant to the WORK_STOP bit for
> stopping the timer. Also, it appears this timer is entirely unused
> as it is only ever started under #define VERBOSE, which is explicitly
> undefined.
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Are you merging these as part of a larger series altogether, or should I
pick the patches that concern me?

If you're taking them all together:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlnMwo8ACgkQzL64meEa
mQaDwxAAznM8HRHE/FZ1nkD3Q0ulJT45YK5mOAbl9eIuFjs6BjHiMGPpPFFithEd
iLJhvKlHG1nppH+g7kVTtH2tlSoTNxIINEoNST+IGJMCC3XrDhqbZjmN51KNglFu
GWX2PCXxsIG0traYc0Yp0y2GZNd4IISTyQzIOTI0W6okNEtJxFxAWpoGAJkAU9+x
2Gp6c1KYOM8ONyFxyZqcKBtpMQeAXHx/CLIucapdkjYRaa7YkYKIJpdlDFugvfQ4
oEtwAHAGVNRcY4Ifq72MA1VvaTnYMGxFDN+5V42w0aa52PpvR8IpU3RDIN62GqpK
edbmemty9INw/NdXeoUNIgw8dyZODnYnx9rCjaMh4CbsFPauec7NAO4NeY6PTqF9
P8LZJtpWUIFyaf4R2/rMgDVV2oJZPhWfpg/EBYoyRK6XapxSAZ+1sYLzuQIteSWn
xExUSWCp6L5vVGGjPIWutok2llwayw5U5X1wIoenyW1eRu4hpxiEOTvABsvFKxY/
E3RemE5OWCFjXbo6GO2Gu2Xmwl5R9qRYZ1VnoqmiR9MlSAwcssu43NDunEiQsojJ
YXFv00QguGj65HH64I/YHntwbzJgOrWX+GBjfzusCtGy8YOMpoipgCxNGzBqXPxH
q/NwBEmraQM2thqzEBZtsdya9eVULT1aoJ8z1a5iSt9hP0oeZhA=
=ubfo
-----END PGP SIGNATURE-----
--=-=-=--
