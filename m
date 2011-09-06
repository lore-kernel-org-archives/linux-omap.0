From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 09/10] OMAP4: DSS2: HDMI: Function pointer approach
 to call
Date: Tue, 06 Sep 2011 15:45:26 +0300
Message-ID: <1315313126.16126.3.camel@deskari>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
	 <1314960470-2616-2-git-send-email-mythripk@ti.com>
	 <1314960470-2616-3-git-send-email-mythripk@ti.com>
	 <1314960470-2616-4-git-send-email-mythripk@ti.com>
	 <1314960470-2616-5-git-send-email-mythripk@ti.com>
	 <1314960470-2616-6-git-send-email-mythripk@ti.com>
	 <1314960470-2616-7-git-send-email-mythripk@ti.com>
	 <1314960470-2616-8-git-send-email-mythripk@ti.com>
	 <1314960470-2616-9-git-send-email-mythripk@ti.com>
	 <1314960470-2616-10-git-send-email-mythripk@ti.com>
	 <1315220503.3214.28.camel@deskari>
	 <CAP5A+B__VLN4Vr3v3Q7GXdKoxicTFOFQaTs8-UnoVC+XXRTETA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39071 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754257Ab1IFMpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 08:45:31 -0400
Received: by bkat8 with SMTP id t8so9215919bka.27
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 05:45:28 -0700 (PDT)
In-Reply-To: <CAP5A+B__VLN4Vr3v3Q7GXdKoxicTFOFQaTs8-UnoVC+XXRTETA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2011-09-05 at 23:03 +0530, K, Mythri P wrote:
> Hi,
> 
> On Mon, Sep 5, 2011 at 4:31 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Fri, 2011-09-02 at 16:17 +0530, mythripk@ti.com wrote:
> >> From: Mythri P K <mythripk@ti.com>
> >>
> >> To make the current hdmi DSS driver compatible with future OMAP having
> >> different IP blocks( A combination of different core, PHY, PLL blocks),
> >> Add HDMI hdmi functions as a function pointer in dss_features to abstract
> >> hdmi dss driver IP agnostic, hdmi dss driver  which will now access
> >> generic functions irrespective of underlying IP.
> >>

<snip>

> >> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> >> index 9398dd3..c8891d1 100644
> >> --- a/include/video/omapdss.h
> >> +++ b/include/video/omapdss.h
> >> @@ -21,6 +21,9 @@
> >>  #include <linux/list.h>
> >>  #include <linux/kobject.h>
> >>  #include <linux/device.h>
> >> +#if defined(CONFIG_OMAP4_DSS_HDMI)
> >> +#include <video/ti_hdmi.h>
> >> +#endif
> >>
> >>  #define DISPC_IRQ_FRAMEDONE          (1 << 0)
> >>  #define DISPC_IRQ_VSYNC                      (1 << 1)
> >> @@ -555,6 +558,26 @@ struct omap_dss_driver {
> >>       u32 (*get_wss)(struct omap_dss_device *dssdev);
> >>  };
> >>
> >> +#if defined(CONFIG_OMAP4_DSS_HDMI)
> >> +struct omap_hdmi_ip_ops {
> >> +
> >> +     void (*video_configure)(struct hdmi_ip_data *ip_data);
> >> +
> >> +     int (*phy_enable)(struct hdmi_ip_data *ip_data);
> >> +
> >> +     void (*phy_disable)(struct hdmi_ip_data *ip_data);
> >> +
> >> +     int (*read_edid)(struct hdmi_ip_data *ip_data,
> >> +                     u8 *pedid, u16 max_length);
> >> +
> >> +     int (*pll_enable)(struct hdmi_ip_data *ip_data);
> >> +
> >> +     void (*pll_disable)(struct hdmi_ip_data *ip_data);
> >> +
> >> +     void (*video_enable)(struct hdmi_ip_data *ip_data, bool start);
> >> +};
> >> +#endif
> >> +
> >
> > Hmm, I don't think omapdss.h is the right place for this struct.
> >
> > You've made it omap specific, but similar struct will be needed by other
> > platforms also, right? So would it better be in ti_hdmi.h, and perhaps
> > called ti_hdmi_ip_ops?
> >
> > And actually, ti_hdmi.h contains struct hdmi_ip_data, which contains
> > pointer to struct omap_hdmi_ip_ops, so it's clear something is wrong
> > there.
> >
> > So either the omap_hdmi_ip_ops should be omapdss internal struct, and it
> > shouldn't be in struct hdmi_ip_data, or the ops struct should be generic
> > one in ti_hdmi.h.
> >
> > Did you consider how the code would look if the function pointers were
> > just included into struct hdmi_ip_data, without any ops struct at all?
> >
> I guess moving it to ti_hdmi.h is a good option.. but i would think
> wrapping it in a struct
> would look cleaner ?

You didn't make this change for the v4?

 Tomi


