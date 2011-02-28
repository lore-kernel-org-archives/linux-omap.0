From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/8] OMAP4 : DSS : HDMI: HDMI specific display
 controller and dss change.
Date: Mon, 28 Feb 2011 08:42:07 +0200
Message-ID: <1298875327.2096.25.camel@deskari>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	 <1298643715-21540-4-git-send-email-mythripk@ti.com>
	 <1298798583.1977.13.camel@deskari>
	 <AANLkTi=1xrEzjVA9Z+a2_ZXmhgQTr=08saosGWWdhXaB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41196 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab1B1GmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 01:42:11 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S6gBAD002725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:42:11 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1S6gA1Y008473
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:42:10 -0600 (CST)
In-Reply-To: <AANLkTi=1xrEzjVA9Z+a2_ZXmhgQTr=08saosGWWdhXaB@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-02-28 at 00:21 -0600, K, Mythri P wrote:
> Hi Tomi,
> 
> On Sun, Feb 27, 2011 at 2:53 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Fri, 2011-02-25 at 08:21 -0600, K, Mythri P wrote:
> >> Adding changes to set gamma table bit for TV interface and function to select
> >> between VENC and HDMI.
> >>
> >> Signed-off-by: Mythri P K <mythripk@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/dispc.c |    5 +++++
> >>  drivers/video/omap2/dss/dss.c   |    7 +++++++
> >>  drivers/video/omap2/dss/dss.h   |    2 ++
> >>  3 files changed, 14 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> >> index 6d9bb17..16f1106 100644
> >> --- a/drivers/video/omap2/dss/dispc.c
> >> +++ b/drivers/video/omap2/dss/dispc.c
> >> @@ -1213,6 +1213,11 @@ void dispc_enable_zorder(enum omap_plane plane, bool enable)
> >>       dispc_write_reg(dispc_reg_att[plane], val);
> >>  }
> >>
> >> +void dispc_enable_gamma_table(bool enable)
> >> +{
> >> +     REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
> >> +}
> >> +
> >>  static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
> >>  {
> >>       u32 val;
> >> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> >> index 99de4e1..127d42e 100644
> >> --- a/drivers/video/omap2/dss/dss.c
> >> +++ b/drivers/video/omap2/dss/dss.c
> >> @@ -559,6 +559,13 @@ void dss_set_dac_pwrdn_bgz(bool enable)
> >>       REG_FLD_MOD(DSS_CONTROL, enable, 5, 5); /* DAC Power-Down Control */
> >>  }
> >>
> >> +void dss_select_hdmi_venc(bool hdmi)
> >> +{
> >> +     REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15); /* 0x1 for HDMI, 0x0 VENC */
> >> +     if (hdmi)
> >> +             REG_FLD_MOD(DSS_CONTROL, 0, 9, 8);
> >> +}
> >
> > bool argument for this function is very confusing. Which one is true?
> > Perhaps this could use an enum.
> I have added a comment , 1 is for HDMI and 0 for VENC.

Yes, but I meant the code which calls this function =). Usually boolean
argument is not good if you have to select between x and y. It's
impossible for the reader to know which is which. 

> >
> > I've tried to keep the habit of having the name of the register field in
> > comments to make the code easier to read. For example, /*
> > VENC_HDMI_SWITCH */ for the bit 15.
> I can add this.
> >
> > The bits 8 and 9 are FCK_CLK_SWITCH. Why do you set it here? Looks
> > rather dangerous to change the clock source like that.
> >
> This is to select what would be the clock source to DISPC, HDMI would
> need the DISPC
> to run at the rate of pixel clock (TMDS if deep color is set ) required by HDMI.
> Where as DSI does not have any such constraint( correct me if i am wrong).

Hmm, I don't understand. This selects the DISPC to receive the fck from
PRCM. Why does it matter for HDMI where DISPC gets its clock? Is this
described in the TRM?

> I suppose we can have a patch to select the correct clock source to
> DISPC dynamically
> based on what panels are connected later on ?

Well, something more generic is required, because other parts of the
code could make changes to the fclk source. Here you just set the source
clock register directly and invisibly. You don't even use the function
dss_select_dispc_clk_source(), and so this would mess up the
dss.dispc_clk_source variable.

 Tomi


