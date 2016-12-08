From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops on boot
Date: Thu, 08 Dec 2016 11:44:08 +0200
Message-ID: <87lgvqkb6f.fsf@linux.intel.com>
References: <20161208032108.21962-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161208032108.21962-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> Somehow starting with v4.9-rc7 there have been imprecise

There's nothing touching dwc3 since v4.9-rc5.

> external aborts on omap5-uevm dwc3 controller. I have not been
> able to bisect what exactly triggered this as it does not always
> happen. It seems that something changed with probing that
> now exposes the issue:
>
> Unhandled fault: imprecise external abort (0x1406) at 0x00000000

hmmm, clock disabled... dwc3-omap shouldn't have pm runtime at all.

> ...
> PC is at dwc3_omap_interrupt_thread+0x20/0x80
> LR is at irq_thread_fn+0x1c/0x54
> ...
> [<c0989fa8>] (dwc3_omap_interrupt_thread) from [<c038a4d8>]
> (irq_thread_fn+0x1c/0x54)
> [<c038a4d8>] (irq_thread_fn) from [<c038a7b0>] (irq_thread+0x12c/0x1f0)
> [<c038a7b0>] (irq_thread) from [<c035d6f0>] (kthread+0xdc/0xf4)
> [<c035d6f0>] (kthread) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
> ...
>
> Unable to handle kernel paging request at virtual address ffffffec
> ...
> Internal error: Oops: 37 [#2] SMP ARM
> PC is at kthread_data+0x4/0xc
> LR is at irq_thread_dtor+0x28/0xd0
> ...
> [<c035e0b4>] (kthread_data) from [<c038a5dc>] (irq_thread_dtor+0x28/0xd0)
> [<c038a5dc>] (irq_thread_dtor) from [<c035bef0>] (task_work_run+0xb8/0xdc)
> [<c035bef0>] (task_work_run) from [<c03448d4>] (do_exit+0x314/0xa20)
> [<c03448d4>] (do_exit) from [<c030bea8>] (die+0x410/0x474)
> [<c030bea8>] (die) from [<c0301350>] (do_DataAbort+0xb4/0xb8)
> [<c0301350>] (do_DataAbort) from [<c030c578>] (__dabt_svc+0x58/0x80)
> Exception stack(0xee777ec8 to 0xee777f10)
> 7ec0:                   0000014d ee6e6f10 00000034 fc020034 ee6e6f10 ee1e=
ec00
> 7ee0: 00000000 00000000 ee6ec640 c038a4bc 00000000 00000000 00000000 ee77=
7f18
> 7f00: c038a4d8 c0989fa8 60000013 ffffffff
> [<c030c578>] (__dabt_svc) from [<c0989fa8>] (dwc3_omap_interrupt_thread+0=
x20/0x80)
> [<c0989fa8>] (dwc3_omap_interrupt_thread) from [<c038a4d8>] (irq_thread_f=
n+0x1c/0x54)
> [<c038a4d8>] (irq_thread_fn) from [<c038a7b0>] (irq_thread+0x12c/0x1f0)
> [<c038a7b0>] (irq_thread) from [<c035d6f0>] (kthread+0xdc/0xf4)
> [<c035d6f0>] (kthread) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
>
> Fix the issue by making sure the dwc3 interrupts are disabled
> before we call devm_request_threaded_irq().

that should already be the case. Are you sure that register isn't zero
in probe?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlhJK2gACgkQzL64meEa
mQZ7Ww//SQmcaYad5wuAmhJjkTjlsy6UOt5BJ1LcFHuNkx/QO2WV/QaE0CDSFk6A
GJ9TxUrBcgZLz1Wl11QKPPiNGGwL9yeOEH5+tKu3Z/v4WKu8hCiKhFVV50ckK5AE
csXACwlxE1gp6Rq/GfxAZgJr2ACsYsTlJIUWZoEyZLj445AYuIoxXVKM7VBcznTN
3E787E4X1pKLH6OJQre6dZnLrp5f68at0kCXjvuUCAyAuJfVMhH+Kt+Fz0YdOy8R
e13ICzUDkM+DXNC5SqEwhb5V5C8FqT47MwPGT548l5UJ4WTC1VHIwjKnc9U9Fj2V
bGzoIRrSgbQ11dk644IGsis6U4gxmH/+SbtSZZ0otEPYMyfx0Kk4MPta5Smt5tCi
aFHBVw1MY88wN85ukGG/wRrov5KPnsa/xe6M51XZxispufo7FmsRM5Vul5kYkQoi
py70IUuOE2gNSiHWDDiGjrvSkzVIBTMUB4RxEobkNkPiUd3C6maSCUwPIUL46woL
TU3kDNjkjSRi2M/CIiSbTrmvFwB5IwqsePnWYYkQ1vcWPNpfkUqy3zZKjxsUJ1Pt
XM7w/Y5Cwm5pacKXGhc1W/JS2/aeO5Pdj09gZOV0wuPLHpiKlPQzOf/Xk5Erb4nM
BB4q92xnyaLm2O+tq4BEK17vc5JTLkLAL7cAhu/tzuM9qRjcoHw=
=wU5+
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
