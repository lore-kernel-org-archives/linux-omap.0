From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Wed, 14 Sep 2011 11:34:42 +0300
Message-ID: <1315989282.2172.36.camel@deskari>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
	 <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
	 <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
	 <CAF6AEGuhjZgH9zFuigjfvHGM9r7jSLY2TTCD0LjZbT+Ubrb12A@mail.gmail.com>
	 <CAP5A+B87w6Hir-0+SNnckQaDcO=ixgq-U8pFo2U42dwQgtUrZQ@mail.gmail.com>
	 <1315984468.2172.10.camel@deskari>
	 <CAP5A+B9uDj4kCowbEKgX1J74zWvBarp64Cn4YVom-a8BYtab4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:52615 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753657Ab1INIer (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 04:34:47 -0400
In-Reply-To: <CAP5A+B9uDj4kCowbEKgX1J74zWvBarp64Cn4YVom-a8BYtab4w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Wed, 2011-09-14 at 13:57 +0530, K, Mythri P wrote:
> On Wed, Sep 14, 2011 at 12:44 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Wed, 2011-09-14 at 11:04 +0530, K, Mythri P wrote:
> >> Hi,
> >>
> >> On Mon, Sep 12, 2011 at 10:16 PM, Rob Clark <robdclark@gmail.com> wrote:
> >> > On Mon, Sep 12, 2011 at 8:24 AM, K, Mythri P <mythripk@ti.com> wrote:
> >> >>> +bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
> >> >>> +{
> >> >>> +       int r;
> >> >>> +
> >> >>> +       void __iomem *base = hdmi_core_sys_base(ip_data);
> >> >>> +
> >> >>> +       /* HPD */
> >> >>> +       r = REG_GET(base, HDMI_CORE_SYS_SYS_STAT, 1, 1);
> >> >>> +
> >> >>> +       return r == 1;
> >> >>> +}
> >> >>> +
> >> >> For HPD the probe should also be on the core interrupt first , and the
> >> >> detect should be dynamic, ie based on the cable connect and disconnect
> >> >> event.So this approach for HPD is not really the way.
> >> >> Also that should be based on the GPIO(63) , I am planning to push a
> >> >> patch on that shortly.
> >> >
> >> >
> >> > Fwiw, we do still need a dssdrv->detect() function from omapdrm
> >> > driver..  if there is another way to implement that function, such as
> >> > with a GPIO, that is great.  But somehow or another we need the detect
> >> > function.  The implementation can always change later.
> >> Yes we still need a detect , but the implementation would be different
> >> , from the prior experience with the Hot-plug detection it wad found
> >> that the interrupt based way to handle HPD was not the best ,but if
> >> this is just to poll the status then it should be fine.
> >
> > I'm not sure I understood. First you say the implementation should be
> > different, but then you say this should be fine. So is this a valid
> > implementation for detect() or is there a better way to do it?
> >
> There is a better way to handle Hot-plug detection and notification..
> But depends on what is the purpose of this function, Ideally a detect

The purpose of the detect function is to return true or false, depending
on whether a (preferably powered-on) monitor is connecter via a cable or
not. So it tells if there's a display that can be used or not.

> would be the case to dynamically detect whether the cable is connected
> on not , But all this function does is to see the state of the HPD bit
> in core state statically.

I don't understand this one. How could this be more dynamic? The
function checks the HPD bit, which (based on my observation) shows the
status whether a display is connected or not.

> So I said if the purpose of this function is only to check for the HPD
> state bit it is fine.

What does HPD bit tell us then?

 Tomi


