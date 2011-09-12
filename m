From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Mon, 12 Sep 2011 19:18:01 +0300
Message-ID: <1315844281.2177.36.camel@deskari>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
	 <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
	 <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:54795 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751730Ab1ILQSG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 12:18:06 -0400
In-Reply-To: <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Mon, 2011-09-12 at 18:54 +0530, K, Mythri P wrote:
> Hi Tomi,
> 
> On Mon, Sep 12, 2011 at 2:43 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > Implement detect() by checking the hot plug detect status.
> >
> > The implementation is not very good, as it always turns on the HDMI
> > output to get the detection working. HDMI driver needs improvements so
> > that we could enable only core parts of it.
> >
> > Cc: Mythri P K <mythripk@ti.com>
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---

<snip>

> > +bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
> > +{
> > +       int r;
> > +
> > +       void __iomem *base = hdmi_core_sys_base(ip_data);
> > +
> > +       /* HPD */
> > +       r = REG_GET(base, HDMI_CORE_SYS_SYS_STAT, 1, 1);
> > +
> > +       return r == 1;
> > +}
> > +
> For HPD the probe should also be on the core interrupt first , and the
> detect should be dynamic, ie based on the cable connect and disconnect
> event.So this approach for HPD is not really the way.

This is not for the event, this is for polling. There is currently no
hot plug event mechanism in the DSS.

Do we get an interrupt when the driver is loaded and the cable is
already connected? And do you plan to keep the plugged in/out state
stored somewhere, or how do you implement detect()?

> Also that should be based on the GPIO(63) , I am planning to push a
> patch on that shortly.

What is gpio 63? What does the HDMI_CORE_SYS_STAT HDP bit tell us then?

 Tomi


