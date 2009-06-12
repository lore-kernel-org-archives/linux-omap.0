From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
Date: Sat, 13 Jun 2009 02:13:52 +0300
Message-ID: <94a0d4530906121613t2f8742efwd60bd99431b9358a@mail.gmail.com>
References: <1244767784-22820-1-git-send-email-vikram.pandita@ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0C0115CBC08A@dlee02.ent.ti.com>
	 <20090612063743.GA655@nokia.com>
	 <7A436F7769CA33409C6B44B358BFFF0C0115CBC2F2@dlee02.ent.ti.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F53464BE@dbde02.ent.ti.com>
	 <20090612190139.GC28101@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:24681 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbZFLXNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 19:13:53 -0400
Received: by fg-out-1718.google.com with SMTP id 16so763396fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 16:13:54 -0700 (PDT)
In-Reply-To: <20090612190139.GC28101@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "ext Pandita, Vikram" <vikram.pandita@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Jun 12, 2009 at 10:01 PM, Felipe Balbi<felipe.balbi@nokia.com> =
wrote:
> On Fri, Jun 12, 2009 at 04:50:09PM +0200, ext Pandita, Vikram wrote:
>>
>>
>> >-----Original Message-----
>> >From: Menon, Nishanth
>> >Sent: Friday, June 12, 2009 9:46 AM
>> >To: felipe.balbi@nokia.com
>> >Cc: Pandita, Vikram; linux-omap@vger.kernel.org
>> >Subject: RE: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
>> >
>> >> -----Original Message-----
>> >> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
>> >> Sent: Friday, June 12, 2009 1:38 AM
>> >> To: Menon, Nishanth
>> >> Cc: Pandita, Vikram; linux-omap@vger.kernel.org
>> >> Subject: Re: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
>> >>
>> >> On Fri, Jun 12, 2009 at 03:46:37AM +0200, ext Menon, Nishanth wro=
te:
>> >> >
>> >> > > -----Original Message-----
>> >> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> >> > > owner@vger.kernel.org] On Behalf Of Pandita, Vikram
>> >> > > Sent: Thursday, June 11, 2009 7:50 PM
>> >> > > To: linux-omap@vger.kernel.org
>> >> > > Cc: Pandita, Vikram
>> >> > > Subject: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
>> >> > >
>> >> > >
>> >> > > + =C2=A0 =C2=A0 =C2=A0/* Get IRQ Trigger Flag */
>> >> > > + =C2=A0 =C2=A0 =C2=A0if (up->port.flags & UPF_IRQ_TRIG_RISIN=
G)
>> >> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_flags |=
=3D IRQF_TRIGGER_RISING;
>> >> > > + =C2=A0 =C2=A0 =C2=A0else if (up->port.flags & UPF_IRQ_TRIG_=
=46ALLING)
>> >> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_flags |=
=3D IRQF_TRIGGER_FALLING;
>> >> > > + =C2=A0 =C2=A0 =C2=A0else if (up->port.flags & UPF_IRQ_TRIG_=
HIGH)
>> >> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_flags |=
=3D IRQF_TRIGGER_HIGH;
>> >> > > + =C2=A0 =C2=A0 =C2=A0else if (up->port.flags & UPF_IRQ_TRIG_=
LOW)
>> >> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_flags |=
=3D IRQF_TRIGGER_LOW;
>> >> > > +
>> >> > Blame it on my dislike for nested if elseif, but...
>> >> > irq_flags |=3D
>> >> > =C2=A0(up->port.flags & UPF_IRQ_TRIG_RISING)? IRQF_TRIGGER_RISI=
NG :
>> >> > =C2=A0(up->port.flags & UPF_IRQ_TRIG_FALLING)? IRQF_TRIGGER_FAL=
LING :
>> >> > =C2=A0(up->port.flags & IRQF_TRIGGER_HIGH)? IRQF_TRIGGER_HIGH :
>> >> > =C2=A0(up->port.flags & UPF_IRQ_TRIG_LOW)? IRQF_TRIGGER_LOW : 0=
;
>> >> >
>> >> > Makes sense?
>> >>
>> >> switch (up->port.flags & UPF_IRQ_FLAGS_MASK) {
>> >> case UPF_IRQ_TRIG_RISING:
>> >> =C2=A0 =C2=A0irq_flags |=3D IRQF_TRIGGER_RISING;
>> >> =C2=A0 =C2=A0break;
>> >> case UPF_IRQ_TRIG_FALLING:
>> >> =C2=A0 =C2=A0irq_flags |=3D IRQF_TRIGGER_FALLING;
>> >> =C2=A0 =C2=A0break;
>> >> case UPF_IRQ_TRIG_HIGH:
>> >> =C2=A0 =C2=A0irq_flags |=3D IRQF_TRIGGER_HIGH;
>> >> =C2=A0 =C2=A0break;
>> >> case UPF_IRQ_TRIG_LOW:
>> >> =C2=A0 =C2=A0irq_flags |=3D IRQF_TRIGGER_LOW;
>> >> =C2=A0 =C2=A0break;
>> >> default:
>> >> =C2=A0 =C2=A0printk(KERN_ERR "Unsupported flag\n");
>> >> =C2=A0 =C2=A0return -EINVAL;
>> >> }
>> >>
>> >Better :) infact, if the port.flags =3D UPF_IRQ_TRIG_LOW | UPF_IRQ_=
TRIG_HIGH it might be better to
>> >return -EINVAL, which Felipe's change does :).
>>
>> Needs more investigation as to how current boards using 8250 driver =
do not pass any flag (maybe just SHARED flag) and they still work. Mayb=
e some default taken by request_irq()
>>
>> In short NO_ need to return failure as no flag is a valid use case.
>
> remove the default part:
>
> switch (up->port.flags & UPF_IRQ_FLAGS_MASK) {
> case UPF_IRQ_TRIG_RISING:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_flags |=3D IRQF_TRIGGER_RISING;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0break;

How about?
 irq_flags |=3D IRQF_TRIGGER_RISING; break;

As far as I can tell Linux code-style tries to use as less lines of
code as possible while retaining sane readability.

> case UPF_IRQ_TRIG_FALLING:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_flags |=3D IRQF_TRIGGER_FALLING;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> case UPF_IRQ_TRIG_HIGH:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_flags |=3D IRQF_TRIGGER_HIGH;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> case UPF_IRQ_TRIG_LOW:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_flags |=3D IRQF_TRIGGER_LOW;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> default:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0break;

There's no need for the final break, is it?

> }

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
