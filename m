From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host bus-suspend/resume
Date: Thu, 11 Jan 2018 11:23:05 +0200
Message-ID: <87a7xkycjq.fsf@linux.intel.com>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org> <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com> <33b22192-1216-a9be-3cb5-d5bc480b4003@codeaurora.org> <87r2qwyfp9.fsf@linux.intel.com> <a30be8a0-63ee-da02-f7a2-4958b7ee35bf@codeaurora.org> <87d12gydev.fsf@linux.intel.com> <4dea746b-3b7a-7a0e-7136-cb771044e627@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4dea746b-3b7a-7a0e-7136-cb771044e627@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Manu Gautam <mgautam@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>>> In host mode runtime suspend/resume could happen very often with
>>> device connected, and resetting h/w on every runtime_resume might not
>>> be desired. And PHYs drivers can also support runtime_suspend which
>>> would be preferred instead of shutting down phy.
>>=20
>> We don't do anything when dwc3 is working as a host, we simply assume if
>> we reach dwc3.ko, xhci has done its part. Here's what our
>> suspend_common looks like:
>>=20
>> static int dwc3_suspend_common(struct dwc3 *dwc)
>> {
>> 	unsigned long	flags;
>>=20
>> 	switch (dwc->current_dr_role) {
>> 	case DWC3_GCTL_PRTCAP_DEVICE:
>> 		spin_lock_irqsave(&dwc->lock, flags);
>> 		dwc3_gadget_suspend(dwc);
>> 		spin_unlock_irqrestore(&dwc->lock, flags);
>> 		dwc3_core_exit(dwc);
>> 		break;
>> 	case DWC3_GCTL_PRTCAP_HOST:
>> 	default:
>> 		/* do nothing */
>> 		break;
>> 	}
>>=20
>> 	return 0;
>> }
>>=20
>> We're not resetting anything, not tearing down anything. No idea why
>> you're saying that in host mode we're breaking things apart. If you have
>> out-of-tree patches on top of v4.15-rc7, fix them instead of claiming
>> mainline is at fault.
>>=20
>
> This is the case after commit 689bf72c6e0d ("usb: dwc3: Don't
> reinitialize core during host bus-suspend/resume") which is breaking
> low power for TI platforms in Host mode.
>
> If we revert that commit we will be doing dwc3_core_exit() for host
> mode as well. Which is what we want for system suspend but probably
> not for runtime suspend in host case.
>
> This is why Manu wants to differentiate runtime vs system suspend.

We already differentiate them. Maybe the only thing we need is to *not*
call core_exit() in host-mode during runtime_suspend, but call it if
mode is device or during system sleep.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlpXLPkACgkQzL64meEa
mQbXNQ//bOAH9ixcQ/NVzxmUPCPPetzJhEktNe8mQ1k5xMIfgrotszBwkfeo4kqN
2cIKoK0jcOEqZRhAqYc3vJrXIked9AOmBmPhoQcoPtso+ddiFyoTlRiVtgAypafw
YyOwbi4Lxm1EZuq6NamCshOFGglFMpDS/Wl7Jnz3ogMANgjPJ4iIer6WZeap2VNj
VDitFjCal7se6NxHr837xmrj77bvtZAvEWD3OU9A1ZORiHoLbSib7s68rzKidYGa
fP8nVGnJ/cTw9wh40WluqsnBFSNA8GcoMpI8Ka/kupP9m9CixWDPBSOqFmiXR9lP
uYiZW7f3QL9l1y8i2KOz2TfHOijdgNYNqNn4QmrYJR90H5eRE704E73XjvYxjYRj
pQ3HhGt3xB8dLYZ3DlI20/eNUhu8pdhJAGRiwSWuP/Tp3QJf5eu9IjTIo5KciOGG
Eqmat9ED/kY1J8tmH3oSEzQY8p4MDJcP3+n3ls8sZnsRQuXdRxlqF21Q5RmXukpp
2HO5firwSuC8HbJQawawXwRwAq9E+7IFkxqFeg9LO/uUZPv8goYGgRI8aMgcv+oN
ht4y4+kGe5/MaXfRJlcoAQ9cis71Tgkp/yIPHzqh5VJw3r/W/27akCJCNfsDYagI
QHXnhLjkrfRs2fQNWDubYNPapsgLGZrdsulsLNZt7erhdM9Nzgc=
=Zl1V
-----END PGP SIGNATURE-----
--=-=-=--
