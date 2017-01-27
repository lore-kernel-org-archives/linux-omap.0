From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Fri, 27 Jan 2017 17:47:22 +0200
Message-ID: <87wpdg5wtx.fsf@linux.intel.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com> <87a8anjm5z.fsf@linux.intel.com> <a0cc2705-b1f5-7b6e-d73c-ff9b525eead2@ti.com> <e64bc4ee-1c71-d72c-cdc7-f5857f49a90e@ti.com> <87inp07fkx.fsf@linux.intel.com> <57fbf2b6-3811-3202-0e69-7cf82662d50f@ti.com> <8760l07dfh.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8760l07dfh.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

(hmm, I didn't receive your reply in my intel inbox, only
gmail. Odd. Replying to myself here, but it should be on your reply,
rater).

Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
>> The previous commit c499ff71ff2a281366c6ec7a904c547d806cbcd1 is fine.
>
> okay. Then let's try to figure out what's going on. A diff of regdump
> before and after suspend/resume might start to give some clue about
> what's going on. DWC3 tracepoints should help too. Care to get those?
> BTW, is this dwc3 as host or peripheral?

You don't have any endpoints enabled:

=2DDALEPENA =3D 0x0000000f
+DALEPENA =3D 0x00000000

Your traces are peculiar:

    > irq/451-dwc3-2082  [000] d...   108.215104: dwc3_gadget: Disabling ep=
1in-bulk

okay, let's disable ep1in-bulk

    > irq/451-dwc3-2082  [000] d...   108.215106: dwc3_gadget_ep_cmd: ep1in=
-bulk: cmd 'End Transfer' [198920] params 00000000 00000000 00000000
    > irq/451-dwc3-2082  [000] d...   108.215109: dwc3_readl: addr fa89c200=
 value 00002500
    > irq/451-dwc3-2082  [000] d...   108.215114: dwc3_writel: addr fa89c83=
8 value 00000000
    > irq/451-dwc3-2082  [000] d...   108.215116: dwc3_writel: addr fa89c83=
4 value 00000000
    > irq/451-dwc3-2082  [000] d...   108.215118: dwc3_writel: addr fa89c83=
0 value 00000000
    > irq/451-dwc3-2082  [000] d...   108.215120: dwc3_writel: addr fa89c83=
c value 00030d08
    > irq/451-dwc3-2082  [000] d...   108.215123: dwc3_readl: addr fa89c83c=
 value 00031908
    > irq/451-dwc3-2082  [000] d...   108.215125: dwc3_gadget: Command Comp=
lete --> 1
    > irq/451-dwc3-2082  [000] d...   108.215127: dwc3_gadget: (null): no r=
esource available
    > irq/451-dwc3-2082  [000] d...   108.495119: dwc3_gadget_giveback: ep1=
in-bulk: req ed5cae80 length 0/4096 zsI =3D=3D> -108
    > irq/451-dwc3-2082  [000] d...   108.495123: dwc3_free_request: ep1in-=
bulk: req ed5cae80 length 0/4096 zsI =3D=3D> -108
    > irq/451-dwc3-2082  [000] d...   108.495127: dwc3_readl: addr fa89c720=
 value 00000000

read DALEPENA, already 0x00. How was ep1in-bulk even enabled???

    > irq/451-dwc3-2082  [000] d...   108.495130: dwc3_writel: addr fa89c72=
0 value 00000000

clear bit for ep1in-bulk and write back the 0x00 you read. What gives??
Why is DALEPENA already zero here????=20

    > irq/451-dwc3-2082  [000] d...   108.495135: dwc3_gadget: Disabling ep=
1out-bulk
    > irq/451-dwc3-2082  [000] d...   108.495137: dwc3_gadget_ep_cmd: ep1ou=
t-bulk: cmd 'End Transfer' [133384] params 00000000 00000000 00000000
    > irq/451-dwc3-2082  [000] d...   108.495139: dwc3_readl: addr fa89c200=
 value 00002500
    > irq/451-dwc3-2082  [000] d...   108.495143: dwc3_writel: addr fa89c82=
8 value 00000000
    > irq/451-dwc3-2082  [000] d...   108.495145: dwc3_writel: addr fa89c82=
4 value 00000000
    > irq/451-dwc3-2082  [000] d...   108.495146: dwc3_writel: addr fa89c82=
0 value 00000000
    > irq/451-dwc3-2082  [000] d...   108.495148: dwc3_writel: addr fa89c82=
c value 00020d08
    > irq/451-dwc3-2082  [000] d...   108.495151: dwc3_readl: addr fa89c82c=
 value 00021908
    > irq/451-dwc3-2082  [000] d...   108.495153: dwc3_gadget: Command Comp=
lete --> 1
    > irq/451-dwc3-2082  [000] d...   108.495154: dwc3_gadget: (null): no r=
esource available
    > irq/451-dwc3-2082  [000] d...   108.495258: dwc3_gadget_giveback: ep1=
out-bulk: req ed76d080 length 0/4096 zsI =3D=3D> -108
    > irq/451-dwc3-2082  [000] d...   108.495261: dwc3_free_request: ep1out=
-bulk: req ed76d080 length 0/4096 zsI =3D=3D> -108
    > irq/451-dwc3-2082  [000] d...   108.495264: dwc3_readl: addr fa89c720=
 value 00000000
    > irq/451-dwc3-2082  [000] d...   108.495266: dwc3_writel: addr fa89c72=
0 value 00000000

same thing for ep1out-bulk. When you get a "Disabling epxxxx" message,
we not only clear DALEPENA (which shouldn't be zero, btw!), but we
also clear dep->flags unconditionally. Here's a blame of v4.7 for that
function:

72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  669) st=
atic int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  670) {
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  671)   =
     struct dwc3             *dwc =3D dep->dwc;
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  672)   =
     u32                     reg;
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  673)=20
7eaeac5c0e449 (Felipe Balbi              2015-07-20 14:46:15 -0500  674)   =
     dwc3_trace(trace_dwc3_gadget, "Disabling %s", dep->name);
7eaeac5c0e449 (Felipe Balbi              2015-07-20 14:46:15 -0500  675)=20
624407f96f134 (Sebastian Andrzej Siewior 2011-08-29 13:56:37 +0200  676)   =
     dwc3_remove_requests(dwc, dep);
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  677)=20
687ef9817df7e (Felipe Balbi              2014-04-16 10:30:33 -0500  678)   =
     /* make sure HW endpoint isn't stalled */
687ef9817df7e (Felipe Balbi              2014-04-16 10:30:33 -0500  679)   =
     if (dep->flags & DWC3_EP_STALL)
7a60855972f0d (Felipe Balbi              2014-09-24 14:19:52 -0500  680)   =
             __dwc3_gadget_ep_set_halt(dep, 0, false);
687ef9817df7e (Felipe Balbi              2014-04-16 10:30:33 -0500  681)=20
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  682)   =
     reg =3D dwc3_readl(dwc->regs, DWC3_DALEPENA);
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  683)   =
     reg &=3D ~DWC3_DALEPENA_EP(dep->number);
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  684)   =
     dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  685)=20
879631aa658be (Felipe Balbi              2011-09-30 10:58:47 +0300  686)   =
     dep->stream_capable =3D false;
f9c56cdd3905c (Ido Shayevitz             2012-02-08 13:56:48 +0200  687)   =
     dep->endpoint.desc =3D NULL;
c90bfaece97c1 (Felipe Balbi              2011-11-29 13:11:21 +0200  688)   =
     dep->comp_desc =3D NULL;
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  689)   =
     dep->type =3D 0;
879631aa658be (Felipe Balbi              2011-09-30 10:58:47 +0300  690)   =
     dep->flags =3D 0;
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  691)=20
aa7399744dd02 (Felipe Balbi              2015-07-20 14:48:13 -0500  692)   =
     snprintf(dep->name, sizeof(dep->name), "ep%d%s",
aa7399744dd02 (Felipe Balbi              2015-07-20 14:48:13 -0500  693)   =
                     dep->number >> 1,
aa7399744dd02 (Felipe Balbi              2015-07-20 14:48:13 -0500  694)   =
                     (dep->number & 1) ? "in" : "out");
aa7399744dd02 (Felipe Balbi              2015-07-20 14:48:13 -0500  695)=20
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  696)   =
     return 0;
72246da40f371 (Felipe Balbi              2011-08-19 18:10:58 +0300  697) }


let's keep going, there's more...

    > irq/451-dwc3-2082  [000] d...   108.495280: dwc3_readl: addr fa89c704=
 value 80000000
    > irq/451-dwc3-2082  [000] d...   108.495283: dwc3_writel: addr fa89c70=
4 value 80000000
    > irq/451-dwc3-2082  [000] d...   108.495287: dwc3_readl: addr fa89c700=
 value 004c098c
    > irq/451-dwc3-2082  [000] d...   108.495290: dwc3_writel: addr fa89c70=
0 value 004c0804
    > irq/451-dwc3-2082  [000] d...   108.495292: dwc3_writel: addr fa89c40=
c value 00000004
    > irq/451-dwc3-2082  [000] d...   108.495295: dwc3_readl: addr fa89c408=
 value 80000100
    > irq/451-dwc3-2082  [000] d...   108.495297: dwc3_writel: addr fa89c40=
8 value 00000100
    > irq/451-dwc3-2082  [000] d.H.   108.495342: dwc3_readl: addr fa89c40c=
 value 00000010
    > irq/451-dwc3-2082  [000] d.H.   108.495347: dwc3_readl: addr fa89c408=
 value 00000100
    > irq/451-dwc3-2082  [000] d.H.   108.495349: dwc3_writel: addr fa89c40=
8 value 80000100
    > irq/451-dwc3-2082  [000] d...   108.495374: dwc3_event: event 080311c6
    > irq/451-dwc3-2082  [000] d...   108.495378: dwc3_writel: addr fa89c40=
c value 00000004
    > irq/451-dwc3-2082  [000] d...   108.495381: dwc3_event: event 00000201
    > irq/451-dwc3-2082  [000] d...   108.495383: dwc3_readl: addr fa89c70c=
 value 00006838
    > irq/451-dwc3-2082  [000] d...   108.495385: dwc3_readl: addr fa89c700=
 value 004c0804
    > irq/451-dwc3-2082  [000] d...   108.495388: dwc3_writel: addr fa89c70=
0 value 004c0804
    > irq/451-dwc3-2082  [000] d...   108.495390: dwc3_readl: addr fa89c704=
 value 80000000
    > irq/451-dwc3-2082  [000] d...   108.495392: dwc3_writel: addr fa89c70=
4 value 8c000000
    > irq/451-dwc3-2082  [000] d...   108.495394: dwc3_gadget: Enabling ep0=
out

... Enabling ep0out.

    > irq/451-dwc3-2082  [000] d...   108.495397: dwc3_gadget_ep_cmd: ep0ou=
t: cmd 'Set Endpoint Configuration' [1] params 80000200 00000500 00000000
    > irq/451-dwc3-2082  [000] d...   108.495399: dwc3_readl: addr fa89c200=
 value 00002500
    > irq/451-dwc3-2082  [000] d...   108.495401: dwc3_writel: addr fa89c80=
8 value 80000200
    > irq/451-dwc3-2082  [000] d...   108.495403: dwc3_writel: addr fa89c80=
4 value 00000500
    > irq/451-dwc3-2082  [000] d...   108.495405: dwc3_writel: addr fa89c80=
0 value 00000000
    > irq/451-dwc3-2082  [000] d...   108.495406: dwc3_writel: addr fa89c80=
c value 00000401
    > irq/451-dwc3-2082  [000] d...   108.495409: dwc3_readl: addr fa89c80c=
 value 00000001
    > irq/451-dwc3-2082  [000] d...   108.495411: dwc3_gadget: Command Comp=
lete --> 0

no writes to DALEPENA!

    > irq/451-dwc3-2082  [000] d...   108.495413: dwc3_gadget: Enabling ep0=
in
    > irq/451-dwc3-2082  [000] d...   108.495415: dwc3_gadget_ep_cmd: ep0in=
: cmd 'Set Endpoint Configuration' [1] params 80000200 02000500 00000000
    > irq/451-dwc3-2082  [000] d...   108.495416: dwc3_readl: addr fa89c200=
 value 00002500
    > irq/451-dwc3-2082  [000] d...   108.495419: dwc3_writel: addr fa89c81=
8 value 80000200
    > irq/451-dwc3-2082  [000] d...   108.495420: dwc3_writel: addr fa89c81=
4 value 02000500
    > irq/451-dwc3-2082  [000] d...   108.495423: dwc3_writel: addr fa89c81=
0 value 00000000
    > irq/451-dwc3-2082  [000] d...   108.495425: dwc3_writel: addr fa89c81=
c value 00000401
    > irq/451-dwc3-2082  [000] d...   108.495428: dwc3_readl: addr fa89c81c=
 value 00000001
    > irq/451-dwc3-2082  [000] d...   108.495429: dwc3_gadget: Command Comp=
lete --> 0

nor here! however we disabled ep0/1 on gadget_suspend:

0b0231aa246cb (Felipe Balbi              2014-10-07 10:19:23 -0500 2936) in=
t dwc3_gadget_suspend(struct dwc3 *dwc)
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2937) {
9772b47a4c291 (Roger Quadros             2016-04-12 11:33:29 +0300 2938)   =
     if (!dwc->gadget_driver)
9772b47a4c291 (Roger Quadros             2016-04-12 11:33:29 +0300 2939)   =
             return 0;
9772b47a4c291 (Roger Quadros             2016-04-12 11:33:29 +0300 2940)=20
7b2a0368bbc9b (Felipe Balbi              2013-12-19 13:43:19 -0600 2941)   =
     if (dwc->pullups_connected) {
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2942)   =
             dwc3_gadget_disable_irq(dwc);
7b2a0368bbc9b (Felipe Balbi              2013-12-19 13:43:19 -0600 2943)   =
             dwc3_gadget_run_stop(dwc, true, true);
7b2a0368bbc9b (Felipe Balbi              2013-12-19 13:43:19 -0600 2944)   =
     }
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2945)=20
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2946)   =
     __dwc3_gadget_ep_disable(dwc->eps[0]);
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2947)   =
     __dwc3_gadget_ep_disable(dwc->eps[1]);
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2948)=20
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2949)   =
     dwc->dcfg =3D dwc3_readl(dwc->regs, DWC3_DCFG);
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2950)=20
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2951)   =
     return 0;
7415f17c9560c (Felipe Balbi              2012-04-30 14:56:33 +0300 2952) }

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAliLa4oACgkQzL64meEa
mQZOig/9FH8E6zEuGZPafn5ecX1D4TOC447cH7NF5GvlrI6GUfOWc4fbagY1AsEQ
dh39rsnxrk/jOj3w5yBiYVincwmGI0B/NE0TYjZzDbuSj+IBT0hPvqaa+djJBh8v
F4tTuERGfuv11z4bvqEMWMQnyZk2l5o5jJwcNMYXEJICw9wiWGV4/Q0HqAknF0yi
/+sKz9Mkj3dZhJqU4ROJvbrh2JO7HNJaA0tIuMucC1mQHV2R117Q+X2fSqH491hj
c9iNL2WqvMC7OHque7zx38+l0A9HuaDYtwppo5HnwMyEEt9cvAD5c0bqC4puRNsJ
aNhtdcx7LESE/MNNfJx47zoTTtrxM/9qqBkDVYsN/hJQCo5wUCbBInkr6UcHm1TG
I/rEvTurdHWcEDK5nie3HdJ86KutBZeRpPAm25JRnwpAxMUo3tIegMEGpTgLWKi0
P8JwKra5Jx1ejrm9arU8GPkBz0fCIz1o2EnIUVUiYxmJ1RpJE2NDxZPDeoM8ruM7
KEUJ+Bnwa75Od1OGih2Z6OJYgRjkZ4dwsOStE+VRxF0SWAVUythzCuYGaOqsuXa6
CazikPENo45ecj2yOX/tX6AXiHxGKwml+ndwjr/RzHR3dMFmI5KHgdo9KzTax7BJ
3EVM8JlQlVzaTi0Nj41OjbLuT9++YcZZi4g3Ad/kB5elltGzUSQ=
=J/hm
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
