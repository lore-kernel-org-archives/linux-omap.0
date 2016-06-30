From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: host: Fix broken XHCI host
Date: Thu, 30 Jun 2016 15:01:48 +0300
Message-ID: <87shvu9977.fsf@linux.intel.com>
References: <1467287657-7280-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467287657-7280-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: b-liu-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> Looks like we lost all changes related to
> commit 9522def40065 ("usb: dwc3: core: cleanup IRQ resources") in host.c
> when Felipe's next branch was merged into Greg's next branch.
>
> Fixes 215db948181 ("Merge tag 'usb-for-v4.8' of git://git.kernel.org/pub/=
scm/linux/kernel/git/balbi/usb into usb-next")
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

looks good to me.

Acked-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXdQosAAoJEIaOsuA1yqREeDIQAIqmdRhXosexbIJzPgHgl1jO
1UkayhNnCXtPd0e3riST508lrqyEK2yndmDpdJ4tkFE3ZZGJfKIco8if2KJS6mgS
qWaMlnMpRYqnibimt6u34mPfernTzGh6Mols9X3G5qGRoTTfkyJ5chS8z3tePwRm
23qsODSHsda/5562mBVfjoHfJMzHcBvsnxrkGWBpLf5G7zGdZo2Bu50R5KkiiTC5
sWWBWe5Xbq1+Cxij9Te7HUibp6FM4UOt3qyhn22VLNAvQv1Ulpn80xsueOoxrPx4
ssMHWap+Ad6I+D1RAR02LWXkh9kXT/PBpoubWrSw9id1vlhDOdvKua6ZeQOZzg0p
QicKId/0N9REzXDHLy4BbnoyA+d5Q1WfRzRNAuZtLaaNpXsJ7SoTiuMVTcfJOyV+
rAhfGGP75PONfuMBvJKFJ+c7WI7BGD7eTPBpr32pVY59xhFPwWlW1pvs4pVDrwGG
kj/zqG58qpGdefvxE/WPncIWHrIAZjdUDdouo2069pXzdEKtJGsGjdmtOGyIUrvE
zI03rDTNcyrhOVcZsLiwwgtntr3lrmoWflEdlDi86YRXV/C9eh8UEGMWjkFPu2G/
MBWvjaid1kb541DdrF6zyoM/GYL9XmuMBK9TZ1m6L2dhAn+9ABFf/ch5ehxZNqAW
RdtFBYzGaB87C6x71uha
=vfCj
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
