From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:next 21/42] drivers/usb/gadget/function/f_midi.c:836:24: error: 'f_midi_rmidi_free' undeclared
Date: Tue, 15 Aug 2017 13:34:04 +0300
Message-ID: <87bmnh6rxf.fsf@linux.intel.com>
References: <201708151847.uAWmroxX%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201708151847.uAWmroxX%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jerry Zhang <zhangjerry-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
> head:   af982758d0a9e5189e657de2bbab2f65f16c48cc
> commit: b8bd28e32e5fc3ad2d8c80ad3978fabb523a1763 [21/42] usb: gadget: f_m=
idi: Use snd_card_free_when_closed with refcount
> config: i386-randconfig-x075-201733 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout b8bd28e32e5fc3ad2d8c80ad3978fabb523a1763
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>
> All errors (new ones prefixed by >>):
>
>    drivers/usb/gadget/function/f_midi.c: In function 'f_midi_register_car=
d':
>>> drivers/usb/gadget/function/f_midi.c:836:24: error: 'f_midi_rmidi_free'=
 undeclared (first use in this function)
>      rmidi->private_free =3D f_midi_rmidi_free;
>                            ^~~~~~~~~~~~~~~~~
>    drivers/usb/gadget/function/f_midi.c:836:24: note: each undeclared ide=
ntifier is reported only once for each function it appears in
>    At top level:
>    drivers/usb/gadget/function/f_midi.c:1249:13: warning: 'f_midi_rmidi_f=
ree' defined but not used [-Wunused-function]
>     static void f_midi_rmidi_free(struct snd_rawmidi *rmidi)
>                 ^~~~~~~~~~~~~~~~~
>
> vim +/f_midi_rmidi_free +836 drivers/usb/gadget/function/f_midi.c

I'll fix it up locally, thanks

@@ -109,6 +109,7 @@ static inline struct f_midi *func_to_midi(struct usb_fu=
nction *f)
 }
=20
 static void f_midi_transmit(struct f_midi *midi);
+static void f_midi_rmidi_free(struct snd_rawmidi *rmidi);
=20
 DECLARE_UAC_AC_HEADER_DESCRIPTOR(1);
 DECLARE_USB_MIDI_OUT_JACK_DESCRIPTOR(1);

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlmSzh0ACgkQzL64meEa
mQbxIQ//VceCleiAktsDEeT8GIA/SG/2pLKv4wvuZ8V0llzn8t/GDBKq634m3c1E
0Ekn3+2znKEMZV+VqDnAX/v99+LEVCFaMsDbIEkvi/M69ZO2Utlu5oNRtPG0NnNz
sAS5Lnn0GFGttCX062mQ2Cu7+TFZ1HXseGFfGCYYueMqWStn/IgtqVjhvDbiLsL7
3poAZMLKz7uCiD7V3HThMPO2FZgNvGIngPsLuagVSs8v00MYadkV3eCh4TzRt/uK
xD2vGwF8Mc9hysALpZxh5Rljn425wU7aejPCKsKjfaF9y92KhnTeQkWVdHwADiAf
y6EwUmWdKgOWRfW4A/mc2FoZYE5ECMGFtXq9gU110OQ97rIYF1MnsFwJuDYjfdT3
wTWUMazYXMOBvQboHWZlmYsAWl9IID6YLLpsjX9CH1RuaXPZLDfloilhxqxcldI/
g2mEvc1gRNXqe2yVdJPuFd+lP2MSwJ2lDI4wdYe7ZJjLBKQUXg/KOTz9wcxvfl91
N+BofCGBFfQGPcA0lXTLG61GOo6qSmB2GYcEfknKNyhgHnVn+JhQgLsKlmOxOwoy
IfVYB4yQoySXz7PT9PZU5fhbxnRqNejzUcqv8gkD7fNPo25z0ocZDC4nWQm3+UYl
so4Q7OVV3H2iv2KkpqsYyMICur2E5ci8NibQ37ivzxWaYXDnDME=
=qyIr
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
