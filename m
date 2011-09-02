From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 02/10] OMAP4: DSS: HDMI: Move pll and video
 configuration
Date: Fri, 02 Sep 2011 08:13:52 +0300
Message-ID: <1314940432.1907.1.camel@deskari>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
	 <1314598500-24005-2-git-send-email-mythripk@ti.com>
	 <1314598500-24005-3-git-send-email-mythripk@ti.com>
	 <1314865665.2169.7.camel@lappyti>
	 <CAP5A+B_Kx+sHj+n3MZRPFMjeh+1u_g_4KbyW5qCdD7SOZyF5Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:36750 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904Ab1IBFN5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 01:13:57 -0400
Received: by fxg9 with SMTP id 9so1529469fxg.0
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 22:13:55 -0700 (PDT)
In-Reply-To: <CAP5A+B_Kx+sHj+n3MZRPFMjeh+1u_g_4KbyW5qCdD7SOZyF5Yw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-09-02 at 10:41 +0530, K, Mythri P wrote:
> Hi,
> 
> On Thu, Sep 1, 2011 at 1:57 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
> >> From: Mythri P K <mythripk@ti.com>
> >>
> >> As the pll and the video configuration info are part of the ip_data those
> >> structures are moved to the ip_data strtucure.Also the functions are modified
> >> accordingly to take care of this movement.
> >
> > structure typoed, and use a space after period.
> >
> >> Signed-off-by: Mythri P K <mythripk@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/hdmi.c |   34 +++++++++++++++-------------------
> >>  drivers/video/omap2/dss/hdmi.h |   18 ++++++++++--------
> >>  2 files changed, 25 insertions(+), 27 deletions(-)

> >> -static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
> >> -                             struct hdmi_pll_info *fmt)
> >> +static int hdmi_pll_program(struct hdmi_ip_data *ip_data)
> >>  {
> >>       u16 r = 0;
> >>       enum hdmi_clk_refsel refsel;
> >> @@ -399,7 +397,7 @@ static int hdmi_pll_program(struct hdmi_ip_data *ip_data,
> >>
> >>       refsel = HDMI_REFSEL_SYSCLK;
> >>
> >> -     r = hdmi_pll_init(ip_data, refsel, fmt->dcofreq, fmt, fmt->regsd);
> >> +     r = hdmi_pll_init(ip_data, refsel);
> >
> > I don't think I quite understood why refsel is not part of the pll info.
> > And if it has to be hardcoded, you could as well do that in
> > hdmi_pll_init().
> >
> Ok , yes that is better.

So, why refsel is not part of the pll info? The HW doesn't support
changing it? If so, is it only for OMAPs or for all SoCs?

 Tomi


