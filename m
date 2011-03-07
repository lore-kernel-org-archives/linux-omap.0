From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 4/9] OMAP4 : DSS2 : HDMI: HDMI driver header file
 addition
Date: Mon, 7 Mar 2011 10:54:10 +0200
Message-ID: <1299488050.2281.92.camel@deskari>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
	 <1299224907-11354-5-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59720 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab1CGIyO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 03:54:14 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p278sElf014877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 02:54:14 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p278sE7g021473
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 02:54:14 -0600 (CST)
In-Reply-To: <1299224907-11354-5-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-03-04 at 01:48 -0600, K, Mythri P wrote:
> Adding the hdmi interface driver header file (hdmi.h) to the dss driver.
> Register and timing declaration to be used by the corresponding c file
> is added in this file.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.h |  444 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 444 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/hdmi.h

<snip>

> +struct hdmi_video_format {
> +       enum hdmi_packing_mode  packing_mode;
> +       u32                     y_res;  /* Line per panel */
> +       u32                     x_res;  /* pixel per line */
> +};
> +
> +struct hdmi_video_interface {
> +       int     vsp;    /* Vsync polarity */
> +       int     hsp;    /* Hsync polarity */
> +       int     interlacing;
> +       int     tm;     /* Timing mode */
> +};
> +
> +struct hdmi_video_timing {
> +       u32     hbp;
> +       u32     hfp;
> +       u32     hsw;
> +       u32     vbp;
> +       u32     vfp;
> +       u32     vsw;
> +};
> +
> +struct hdmi_config {
> +       u16     ppl;    /* pixel per line */
> +       u16     lpp;    /* line per panel */
> +       u32     pixel_clock;
> +       u16     hsw;    /* Horizontal sync pulse width */
> +       u16     hfp;    /* Horizontal front porch */
> +       u16     hbp;    /* Horizontal back porch */
> +       u16     vsw;    /* Vertical sync pulse width */
> +       u16     vfp;    /* Vertical front porch */
> +       u16     vbp;    /* Vertical back porch */
> +       u16     interlace;
> +       u16     h_pol;
> +       u16     v_pol;
> +       u16     hdmi_dvi;
> +       u16     video_format;
> +};

I haven't really read through the hdmi code (as it doesn't apply to my
tree), but it looks quite strange to have multiple structs with
overlapping information. And then there's also the struct
omap_video_timings, which contains similar stuff.

So, could the hdmi_config use hdmi_video_timing, hdmi_video_interface
and hdmi_video_format structs? Can omap_video_timings be used here?
Should omap_video_timings be modified somehow to suit HDMI better?

> +
> +struct hdmi_cm {
> +       int     code;
> +       int     mode;
> +};
> +
> +struct hdmi_irq_vector {
> +       u8      pll_recal;
> +       u8      pll_unlock;
> +       u8      pll_lock;
> +       u8      phy_disconnect;
> +       u8      phy_connect;
> +       u8      phy_short_5v;
> +       u8      video_end_fr;
> +       u8      video_vsync;
> +       u8      fifo_sample_req;
> +       u8      fifo_overflow;
> +       u8      fifo_underflow;
> +       u8      ocp_timeout;
> +       u8      core;
> +};

This struct is not used.

 Tomi


