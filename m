From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Wed, 14 Sep 2011 10:14:28 +0300
Message-ID: <1315984468.2172.10.camel@deskari>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
	 <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
	 <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
	 <CAF6AEGuhjZgH9zFuigjfvHGM9r7jSLY2TTCD0LjZbT+Ubrb12A@mail.gmail.com>
	 <CAP5A+B87w6Hir-0+SNnckQaDcO=ixgq-U8pFo2U42dwQgtUrZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:51100 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755562Ab1INHOe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 03:14:34 -0400
In-Reply-To: <CAP5A+B87w6Hir-0+SNnckQaDcO=ixgq-U8pFo2U42dwQgtUrZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Wed, 2011-09-14 at 11:04 +0530, K, Mythri P wrote:
> Hi,
> 
> On Mon, Sep 12, 2011 at 10:16 PM, Rob Clark <robdclark@gmail.com> wrote:
> > On Mon, Sep 12, 2011 at 8:24 AM, K, Mythri P <mythripk@ti.com> wrote:
> >>> +bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
> >>> +{
> >>> +       int r;
> >>> +
> >>> +       void __iomem *base = hdmi_core_sys_base(ip_data);
> >>> +
> >>> +       /* HPD */
> >>> +       r = REG_GET(base, HDMI_CORE_SYS_SYS_STAT, 1, 1);
> >>> +
> >>> +       return r == 1;
> >>> +}
> >>> +
> >> For HPD the probe should also be on the core interrupt first , and the
> >> detect should be dynamic, ie based on the cable connect and disconnect
> >> event.So this approach for HPD is not really the way.
> >> Also that should be based on the GPIO(63) , I am planning to push a
> >> patch on that shortly.
> >
> >
> > Fwiw, we do still need a dssdrv->detect() function from omapdrm
> > driver..  if there is another way to implement that function, such as
> > with a GPIO, that is great.  But somehow or another we need the detect
> > function.  The implementation can always change later.
> Yes we still need a detect , but the implementation would be different
> , from the prior experience with the Hot-plug detection it wad found
> that the interrupt based way to handle HPD was not the best ,but if
> this is just to poll the status then it should be fine.

I'm not sure I understood. First you say the implementation should be
different, but then you say this should be fine. So is this a valid
implementation for detect() or is there a better way to do it?

 Tomi



