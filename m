From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH RESEND] Input: omap-keypad: dynamically handle register offsets
Date: Tue, 10 Apr 2012 16:00:34 +0530
Message-ID: <CAKdam55V0oRh34TPgc83Xj2xdk8=Dgaz7-441PFOj94mDZY__g@mail.gmail.com>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
	<20120410092441.GB20616@arwen.pp.htv.fi>
	<CAKdam56-Pu+WJKLUpodTzOzGuGbAHuqZ3F-zVmrAtFM7EDhxpg@mail.gmail.com>
	<20120410101609.GJ20616@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33785 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755355Ab2DJKah convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 06:30:37 -0400
Received: by wera13 with SMTP id a13so4437960wer.37
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 03:30:34 -0700 (PDT)
In-Reply-To: <20120410101609.GJ20616@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Felipe,

On Tue, Apr 10, 2012 at 3:46 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> On Tue, Apr 10, 2012 at 03:37:28PM +0530, Poddar, Sourav wrote:
> > Hi Felipe,
> >
> > On Tue, Apr 10, 2012 at 2:54 PM, Felipe Balbi <balbi@ti.com> wrote:
> >
> > =A0 =A0 On Tue, Apr 03, 2012 at 10:52:26AM +0530, Sourav Poddar wro=
te:
> > =A0 =A0 > +static int kbd_write_irqstatus(struct omap4_keypad *keyp=
ad_data,
> > =A0 =A0 > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 offset, u32 value)
> > =A0 =A0 > +{
> > =A0 =A0 > + =A0 =A0 return __raw_writel(value, keypad_data->base + =
offset);
> > =A0 =A0 > +}
> > =A0 =A0 > +
> > =A0 =A0 > +static int kbd_write_irqenable(struct omap4_keypad *keyp=
ad_data,
> > =A0 =A0 > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 offset, u32 value)
> > =A0 =A0 > +{
> > =A0 =A0 > + =A0 =A0 return __raw_writel(value, keypad_data->base + =
offset);
> > =A0 =A0 > +}
> >
> > =A0 =A0 if this only writes to irqenable, why do you pass offset as=
 an argument?
> > =A0 =A0 likewise for irqstatus.
> >
> >
> > Actually, here the offset is the "irqenable" register addresss offs=
et and
> > "irqstatus" register
> > address offset from the base address.
> > Since, the above two address are different in case of Omap4 and oma=
p5, we are
> > passing an offset
> > depending on the particular revision of the keyboard selected durin=
g probe.
>
> but you already have those in keypad_data->irqenable/irqstatus right =
?

Yes.
>
> Meaning you can access them directly here and save on the arguments:
>
> static int kbd_write_irqenable(struct omap4_keypad *keypad_data, u32 =
value)
> {
> =A0 =A0 return __raw_writel(value, keypad_data->base + keypad_data->i=
rqenable);
> }
>
Thanks a lot for pointing this out. Yes, we should be able to directly =
use
the driver data for the above api.
Will make the necessary change in the next version.
~Sourav
>
>
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
