From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: RE: [PATCH 01/13] DSPBRIDGE: Replace mem_calloc() by kzalloc() or
 	__vmalloc()
Date: Thu, 13 May 2010 16:56:08 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB0954901ABFC8@dlee01.ent.ti.com>
References: <818EF96F5A7CC84789DD014773DB09548F6481CB@dlee01.ent.ti.com>
 <AANLkTikIZXTq2OAS96Od8h4HFtk0yM3hpXQymT_UYjAO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53030 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab0EMV4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 17:56:12 -0400
In-Reply-To: <AANLkTikIZXTq2OAS96Od8h4HFtk0yM3hpXQymT_UYjAO@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>



> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Thursday, May 13, 2010 2:36 PM
> To: Gomez Castellanos, Ivan
> Cc: linux-omap@vger.kernel.org; Hiroshi DOYU; Ameya Palande; Menon,
> Nishanth
> Subject: Re: [PATCH 01/13] DSPBRIDGE: Replace mem_calloc() by kzalloc=
() or
> __vmalloc()
>=20
> On Fri, Apr 9, 2010 at 2:43 AM, Gomez Castellanos, Ivan
> <ivan.gomez@ti.com> wrote:
> > diff --git a/drivers/dsp/bridge/wmd/ue_deh.c
> b/drivers/dsp/bridge/wmd/ue_deh.c
> > index 75a62b0..6c1b318 100644
> > --- a/drivers/dsp/bridge/wmd/ue_deh.c
> > +++ b/drivers/dsp/bridge/wmd/ue_deh.c
> > @@ -239,8 +239,8 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr=
, u32
> ulEventMask, u32 dwErrInfo)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "bridge=
_deh_notify: DSP_MMUFAULT, fault "
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "addres=
s =3D 0x%x\n", (unsigned
> int)fault_addr);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy_va_addr =3D
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (u32) mem_cal=
loc(sizeof(char) * 0x1000,
> MEM_PAGED);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy_va_addr =3D (u3=
2) kzalloc(sizeof(char) *
> 0x1000,
> > +
> GFP_ATOMIC);
>=20
> sizeof(foo) returns the size of foo in chars, so obviously sizeof(cha=
r) is
> 1.

Yes, this should be removed. I think you sent a patch to change the typ=
e of dummy_va_addr and also removed the sizeof().

I found your patch:
dsp-bridge: deh: fix dummy_va_addr

It can be applied after the discussion on "Fix Kernel memory poison ove=
rwritten after DSP_MMUFAULT" is finished.

Regards,
Ivan

>=20
> --
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
