From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH] OMAPDSS: DISPC: Fix IRQ unregister race
Date: Thu, 06 Sep 2012 16:36:54 +0300
Message-ID: <1346938614.2737.68.camel@deskari>
References: <1346613123-24053-1-git-send-email-dinuxbg@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-vdOe3wA8Djl0IpLcy+sU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:56201 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753870Ab2IFNhA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 09:37:00 -0400
Received: by lagy9 with SMTP id y9so1096302lag.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 06:36:57 -0700 (PDT)
In-Reply-To: <1346613123-24053-1-git-send-email-dinuxbg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dimitar Dimitrov <dinuxbg@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-vdOe3wA8Djl0IpLcy+sU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 2012-09-02 at 22:12 +0300, Dimitar Dimitrov wrote:
> Very rare kernel crashes are reported on a custom OMAP4 board. Kernel
> panics due to corrupted completion structure while executing
> dispc_irq_wait_handler(). Excerpt from kernel log:
>=20
>   Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
>   Unable to handle kernel paging request at virtual address 00400130
>   ...
>   PC is at 0xebf205bc
>   LR is at __wake_up_common+0x54/0x94
>   ...
>   (__wake_up_common+0x0/0x94)
>   (complete+0x0/0x60)
>   (dispc_irq_wait_handler.36902+0x0/0x14)
>   (omap_dispc_irq_handler+0x0/0x354)
>   (handle_irq_event_percpu+0x0/0x188)
>   (handle_irq_event+0x0/0x64)
>   (handle_fasteoi_irq+0x0/0x10c)
>   (generic_handle_irq+0x0/0x48)
>   (asm_do_IRQ+0x0/0xc0)
>=20
> DISPC IRQ executes callbacks with dispc.irq_lock released. Hence
> unregister_isr() and DISPC IRQ might be running in parallel on different
> CPUs. So there is a chance that a callback is executed even though it
> has been unregistered. As omap_dispc_wait_for_irq_timeout() declares a
> completion on stack, the dispc_irq_wait_handler() callback might try to
> access a completion structure that is invalid. This leads to crashes and
> hangs.
>=20
> Solution is to divide unregister calls into two sets:
>   1. Non-strict unregistering of callbacks. Callbacks could safely be
>      executed after unregistering them. This is the case with unregister
>      calls from the IRQ handler itself.
>   2. Strict (synchronized) unregistering. Callbacks are not allowed
>      after unregistering. This is the case with completion waiting.
>=20
> The above solution should satisfy one of the original intentions of the
> driver: callbacks should be able to unregister themselves.

I think it'd be better to create a new function for the nosync version,
and keep the old name for the sync version. The reason for this is to
minimize the amount of changes, as I think this one needs to be applied
to stable kernel trees also.

Also, I think we need similar one for dsi.c, as it has the same kind of
irq handling. But with a quick glance only sync version is needed there.

However, I'm not quite sure about this approach. The fix makes sense,
but it makes me think if the irq handling is designed the wrong way.

While debugging and fixing this, did you think some other irq handling
approach would be saner?

 Tomi


--=-vdOe3wA8Djl0IpLcy+sU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQSKb2AAoJEPo9qoy8lh71kTEP/3kpbxsSzcHsPYm3X8eJMH2+
VNu6Dq379JjyYWAbRnRzKOlUzeNJD2LDMGjKmdxm1fngrx0a2cbL9wuXwTc/AuY4
Slk1Wejc+SxL4UlABpOjKcznny4yfpLRzfAM3aDXTJ/QUzGAktqjd663eAKL0IO/
jfW9l6aG4zRIfpdtTau8nwlQagamvlhonQN3bkamTZ4PEDfBbx6NybNhFa71Umn9
X0jsNKNDGtg00vyM8sk7fCa1eSvFYK01vRwYM6BdAVzZEoWuUsqFqwGyT5+KEru2
nJVXeH+x6uVwrAws9yZ/HrODNAn1tADI3b1JdrvweZlJNxJ+ejwj3Fp2aqo+sHjS
aQf5XOU1l0q7ks2HH5YzaLr8TlmdZGoe9K2dJWCPxIgW4MQRaz8lrXRyPEXiY4v0
a/N1l2hyZDTXtGWMu2VIujiyODXJXPsUvdiXA/pnT36RzgV8Doo3d8DHGMbAQH83
bkoIZuEsyg1WaEDbO1bCzjLSZEM5Rnn+9RlnaatVj60PAaxJsdNhQ30BqQK4QC9R
E732hiUVlMGuhlEDniW+xnEAhaR9+elPHg+OiUs9HZMk8VBjmCnnXZIr4ShFTYgC
XTdXMlfvXWOrEspFHF5VdiyrHTXaG8upPlkMdNWEdXU7f/5D72S219Tc3uCKs6A1
A1IPbw7aE0VtLFW6CQkV
=hNZm
-----END PGP SIGNATURE-----

--=-vdOe3wA8Djl0IpLcy+sU--

