From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: RE: [Regression?] Removed regulator support in ehci-omap
Date: Tue, 12 Apr 2011 21:50:05 +0530
Message-ID: <bcd954a468e6a07bd673b7d0731e9344@mail.gmail.com>
References: <20110411093214.GA18215@rainbow> <4DA3350E.2060400@gmail.com>
 <BANLkTinDMZ+CyGCmzZu8cSz1L_yFXxm+vg@mail.gmail.com> <112ef82aebc719ef25cde126f2014ebc@mail.gmail.com>
 <20110412040420.GB25239@rainbow>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110412040420.GB25239@rainbow>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: Steve Sakoman <sakoman@gmail.com>, Steve Calfee <stevecalfee@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Dmitry Artamonow [mailto:mad_soft@inbox.ru]
> Sent: Tuesday, April 12, 2011 9:41 AM
> To: Keshava Munegowda
> Cc: Steve Sakoman; Steve Calfee; Felipe Balbi;
linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [Regression?] Removed regulator support in ehci-omap
>
> On 02:18 Tue 12 Apr     , Keshava Munegowda wrote:
> >
> > Sorry guys! I will work on it coming week; currently I am in travel.
> >
> > Well, regulator is not removed, its moved to usbhs core driver in
> > /driver/mfd/omap xx usb xxx host.c
>
> Ah, so EHCI/OHCI common code was moved into drivers/mfd... Good.
> But seems regulators support was lost somewhere during transition - the
> only mentioning about regulators in omap-usb-host.c is "#include" :
>
> mad@macmini:~/kernel-hack/linux-2.6(master)$ grep -i regulator
drivers/mfd/omap-usb-host.c
> #include <linux/regulator/consumer.h>
> mad@macmini:~/kernel-hack/linux-2.6(master)$
>
> --
> Best regards,
> Dmitry "MAD" Artamonow

Thanks ! I will add some time next week!

Keshava Munegowda
