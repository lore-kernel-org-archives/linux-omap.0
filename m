From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv4 1/14] OMAP2+: dmtimer: add device names to flck nodes
Date: Tue, 23 Nov 2010 14:13:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03734373C5@dbde02.ent.ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <4CEAA942.9080907@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03734373B9@dbde02.ent.ti.com>
 <4CEB7DFF.9010001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52468 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab0KWInI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 03:43:08 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAN8h4bq000592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 02:43:06 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAN8h3Y7001149
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 14:13:03 +0530 (IST)
In-Reply-To: <4CEB7DFF.9010001@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

Benoit,
> -----Original Message-----
> From: Cousson, Benoit
> Sent: Tuesday, November 23, 2010 2:11 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCHv4 1/14] OMAP2+: dmtimer: add device names to flck
> nodes
>
> On 11/23/2010 9:36 AM, DebBarma, Tarun Kanti wrote:
> > Benoit,
> >> -----Original Message-----
> >> From: Cousson, Benoit
> >> Sent: Monday, November 22, 2010 11:03 PM
> >> To: DebBarma, Tarun Kanti
> >> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> >> Subject: Re: [PATCHv4 1/14] OMAP2+: dmtimer: add device names to flck
> >> nodes
> >>
> >> Hi Tarun,
> >>
> >> On 11/20/2010 3:39 AM, Tarun Kanti DebBarma wrote:
> >>> From: Thara Gopinath<thara@ti.com>
> >>>
> >>> Add device name to OMAP2 dmtimer fclk nodes so that the fclk nodes can
> >> be
> >>> retrieved by doing a clk_get with the corresponding device pointers or
> >>> device names.
> >>>
> >>> Signed-off-by: Thara Gopinath<thara@ti.com>
> >>> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> >>> ---
> >>>    arch/arm/mach-omap2/clock2420_data.c |   58
> >> +++++++++++++++++++++++++++------
> >>>    arch/arm/mach-omap2/clock2430_data.c |   58
> >> +++++++++++++++++++++++++++------
> >>>    arch/arm/mach-omap2/clock3xxx_data.c |   46 ++++++++++++++++++++---
> ---
> >>>    arch/arm/mach-omap2/clock44xx_data.c |   42 ++++++++++++++++++-----
> -
> >>>    4 files changed, 161 insertions(+), 43 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-
> >> omap2/clock2420_data.c
> >>> index 21f8562..d2e90ae 100644
> >>> --- a/arch/arm/mach-omap2/clock2420_data.c
> >>> +++ b/arch/arm/mach-omap2/clock2420_data.c
> >>> @@ -1803,27 +1803,27 @@ static struct omap_clk omap2420_clks[] = {
> >>>           CLK(NULL,       "gpt1_ick",&gpt1_ick,      CK_242X),
> >>>           CLK(NULL,       "gpt1_fck",&gpt1_fck,      CK_242X),
> >>
> >> Why is the timer1 not using a clockdev with device name?
> >> +       CLK("omap-timer.1",     "fck",&gpt1_fck,      CK_242X),
> >>
> >> It is the case for all the other platforms.
> > Ok, this is done at later patch when we switch to platform driver.
> > This is done in this way because gptimer driver would not recognize
> > Clock access using device name until the complete switch-over happens.
> > This is to keep each patch compiled and booting.
>
> OK, I've just the the patch (#12) where it happens. In that case, you
> should just add some disclaimer in the changelog.
OK, sure.
--
Tarun

> >
> >>
> >>>           CLK(NULL,       "gpt2_ick",&gpt2_ick,      CK_242X),
> >>> -       CLK(NULL,       "gpt2_fck",&gpt2_fck,      CK_242X),
> >>> +       CLK("omap-timer.2",     "fck",&gpt2_fck,      CK_242X),
> >>>           CLK(NULL,       "gpt3_ick",&gpt3_ick,      CK_242X),
> >>> -       CLK(NULL,       "gpt3_fck",&gpt3_fck,      CK_242X),
> >>> +       CLK("omap-timer.3",     "fck",&gpt3_fck,      CK_242X),
> >>>           CLK(NULL,       "gpt4_ick",&gpt4_ick,      CK_242X),
> >>> -       CLK(NULL,       "gpt4_fck",&gpt4_fck,      CK_242X),
> >>> +       CLK("omap-timer.4",     "fck",&gpt4_fck,      CK_242X),
> >>>           CLK(NULL,       "gpt5_ick",&gpt5_ick,      CK_242X),
> >>> -       CLK(NULL,       "gpt5_fck",&gpt5_fck,      CK_242X),
> >>> +       CLK("omap-timer.5",     "fck",&gpt5_fck,      CK_242X),
> >>>           CLK(NULL,       "gpt6_ick",&gpt6_ick,      CK_242X),
> >>> -       CLK(NULL,       "gpt6_fck",&gpt6_fck,      CK_242X),
> >>> +       CLK("omap-timer.6",     "fck",&gpt6_fck,      CK_242X),
> >>>           CLK(NULL,       "gpt7_ick",&gpt7_ick,      CK_242X),
> >>> -       CLK(NULL,       "gpt7_fck",&gpt7_fck,      CK_242X),
> >>> +       CLK("omap-timer.7",     "fck",&gpt7_fck,      CK_242X),
> >>>           CLK(NULL,       "gpt8_ick",&gpt8_ick,      CK_242X),
> >>> -       CLK(NULL,       "gpt8_fck",&gpt8_fck,      CK_242X),
> >>> +       CLK("omap-timer.8",     "fck",&gpt8_fck,      CK_242X),
> >>>           CLK(NULL,       "gpt9_ick",&gpt9_ick,      CK_242X),
> >>> -       CLK(NULL,       "gpt9_fck",&gpt9_fck,      CK_242X),
> >>> +       CLK("omap-timer.9",     "fck",&gpt9_fck,      CK_242X),
> >>>           CLK(NULL,       "gpt10_ick",&gpt10_ick,     CK_242X),
> >>> -       CLK(NULL,       "gpt10_fck",&gpt10_fck,     CK_242X),
> >>> +       CLK("omap-timer.10",    "fck",&gpt10_fck,     CK_242X),
> >>>           CLK(NULL,       "gpt11_ick",&gpt11_ick,     CK_242X),
> >>> -       CLK(NULL,       "gpt11_fck",&gpt11_fck,     CK_242X),
> >>> +       CLK("omap-timer.11",    "fck",&gpt11_fck,     CK_242X),
> >>>           CLK(NULL,       "gpt12_ick",&gpt12_ick,     CK_242X),
> >>> -       CLK(NULL,       "gpt12_fck",&gpt12_fck,     CK_242X),
> >>> +       CLK("omap-timer.12",    "fck",&gpt12_fck,     CK_242X),
> >>>           CLK("omap-mcbsp.1", "ick",&mcbsp1_ick,    CK_242X),
> >>>           CLK("omap-mcbsp.1", "fck",&mcbsp1_fck,    CK_242X),
> >>>           CLK("omap-mcbsp.2", "ick",&mcbsp2_ick,    CK_242X),
> >>> @@ -1878,6 +1878,42 @@ static struct omap_clk omap2420_clks[] = {
> >>>           CLK(NULL,       "pka_ick",&pka_ick,       CK_242X),
> >>>           CLK(NULL,       "usb_fck",&usb_fck,       CK_242X),
> >>>           CLK("musb_hdrc",        "fck",&osc_ck,        CK_242X),
> >>> +       CLK("omap-timer.1",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.2",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.3",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.4",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.5",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.6",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.7",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.8",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.9",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.10",    "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.11",    "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.12",    "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.1",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.2",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.3",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.4",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.5",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.6",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.7",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.8",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.9",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.10",    "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.11",    "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.12",    "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.1",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.2",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.3",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.4",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.5",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.6",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.7",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.8",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.9",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.10",    "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.11",    "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.12",    "alt_ck",&alt_ck,        CK_243X),
> >>>    };
> >>>
> >>>    /*
> >>> diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-
> >> omap2/clock2430_data.c
> >>> index e32afcb..7861bf4 100644
> >>> --- a/arch/arm/mach-omap2/clock2430_data.c
> >>> +++ b/arch/arm/mach-omap2/clock2430_data.c
> >>> @@ -1907,27 +1907,27 @@ static struct omap_clk omap2430_clks[] = {
> >>>           CLK(NULL,       "gpt1_ick",&gpt1_ick,      CK_243X),
> >>>           CLK(NULL,       "gpt1_fck",&gpt1_fck,      CK_243X),
> >>>           CLK(NULL,       "gpt2_ick",&gpt2_ick,      CK_243X),
> >>> -       CLK(NULL,       "gpt2_fck",&gpt2_fck,      CK_243X),
> >>> +       CLK("omap-timer.2",     "fck",&gpt2_fck,      CK_243X),
> >>>           CLK(NULL,       "gpt3_ick",&gpt3_ick,      CK_243X),
> >>> -       CLK(NULL,       "gpt3_fck",&gpt3_fck,      CK_243X),
> >>> +       CLK("omap-timer.3",     "fck",&gpt3_fck,      CK_243X),
> >>>           CLK(NULL,       "gpt4_ick",&gpt4_ick,      CK_243X),
> >>> -       CLK(NULL,       "gpt4_fck",&gpt4_fck,      CK_243X),
> >>> +       CLK("omap-timer.4",     "fck",&gpt4_fck,      CK_243X),
> >>>           CLK(NULL,       "gpt5_ick",&gpt5_ick,      CK_243X),
> >>> -       CLK(NULL,       "gpt5_fck",&gpt5_fck,      CK_243X),
> >>> +       CLK("omap-timer.5",     "fck",&gpt5_fck,      CK_243X),
> >>>           CLK(NULL,       "gpt6_ick",&gpt6_ick,      CK_243X),
> >>> -       CLK(NULL,       "gpt6_fck",&gpt6_fck,      CK_243X),
> >>> +       CLK("omap-timer.6",     "fck",&gpt6_fck,      CK_243X),
> >>>           CLK(NULL,       "gpt7_ick",&gpt7_ick,      CK_243X),
> >>> -       CLK(NULL,       "gpt7_fck",&gpt7_fck,      CK_243X),
> >>> +       CLK("omap-timer.7",     "fck",&gpt7_fck,      CK_243X),
> >>>           CLK(NULL,       "gpt8_ick",&gpt8_ick,      CK_243X),
> >>> -       CLK(NULL,       "gpt8_fck",&gpt8_fck,      CK_243X),
> >>> +       CLK("omap-timer.8",     "fck",&gpt8_fck,      CK_243X),
> >>>           CLK(NULL,       "gpt9_ick",&gpt9_ick,      CK_243X),
> >>> -       CLK(NULL,       "gpt9_fck",&gpt9_fck,      CK_243X),
> >>> +       CLK("omap-timer.9",     "fck",&gpt9_fck,      CK_243X),
> >>>           CLK(NULL,       "gpt10_ick",&gpt10_ick,     CK_243X),
> >>> -       CLK(NULL,       "gpt10_fck",&gpt10_fck,     CK_243X),
> >>> +       CLK("omap-timer.10",    "fck",&gpt10_fck,     CK_243X),
> >>>           CLK(NULL,       "gpt11_ick",&gpt11_ick,     CK_243X),
> >>> -       CLK(NULL,       "gpt11_fck",&gpt11_fck,     CK_243X),
> >>> +       CLK("omap-timer.11",    "fck",&gpt11_fck,     CK_243X),
> >>>           CLK(NULL,       "gpt12_ick",&gpt12_ick,     CK_243X),
> >>> -       CLK(NULL,       "gpt12_fck",&gpt12_fck,     CK_243X),
> >>> +       CLK("omap-timer.12",    "fck",&gpt12_fck,     CK_243X),
> >>>           CLK("omap-mcbsp.1", "ick",&mcbsp1_ick,    CK_243X),
> >>>           CLK("omap-mcbsp.1", "fck",&mcbsp1_fck,    CK_243X),
> >>>           CLK("omap-mcbsp.2", "ick",&mcbsp2_ick,    CK_243X),
> >>> @@ -1993,6 +1993,42 @@ static struct omap_clk omap2430_clks[] = {
> >>>           CLK(NULL,       "mdm_intc_ick",&mdm_intc_ick,  CK_243X),
> >>>           CLK("mmci-omap-hs.0", "mmchsdb_fck",&mmchsdb1_fck,
> CK_243X),
> >>>           CLK("mmci-omap-hs.1", "mmchsdb_fck",&mmchsdb2_fck,
> CK_243X),
> >>> +       CLK("omap-timer.1",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.2",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.3",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.4",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.5",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.6",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.7",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.8",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.9",     "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.10",    "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.11",    "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.12",    "32k_ck",&func_32k_ck,   CK_243X),
> >>> +       CLK("omap-timer.1",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.2",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.3",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.4",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.5",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.6",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.7",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.8",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.9",     "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.10",    "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.11",    "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.12",    "sys_ck",&sys_ck,        CK_243X),
> >>> +       CLK("omap-timer.1",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.2",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.3",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.4",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.5",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.6",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.7",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.8",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.9",     "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.10",    "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.11",    "alt_ck",&alt_ck,        CK_243X),
> >>> +       CLK("omap-timer.12",    "alt_ck",&alt_ck,        CK_243X),
> >>>    };
> >>>
> >>>    /*
> >>> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-
> >> omap2/clock3xxx_data.c
> >>> index d85ecd5..41685be 100644
> >>> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> >>> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> >>> @@ -3273,8 +3273,8 @@ static struct omap_clk omap3xxx_clks[] = {
> >>>           CLK(NULL,       "modem_fck",&modem_fck,     CK_343X),
> >>>           CLK(NULL,       "sad2d_ick",&sad2d_ick,     CK_343X),
> >>>           CLK(NULL,       "mad2d_ick",&mad2d_ick,     CK_343X),
> >>> -       CLK(NULL,       "gpt10_fck",&gpt10_fck,     CK_3XXX),
> >>> -       CLK(NULL,       "gpt11_fck",&gpt11_fck,     CK_3XXX),
> >>> +       CLK("omap-timer.10",    "fck",&gpt10_fck,     CK_3XXX),
> >>> +       CLK("omap-timer.11",    "fck",&gpt11_fck,     CK_3XXX),
> >>>           CLK(NULL,       "cpefuse_fck",&cpefuse_fck,   CK_3430ES2 |
> >> CK_AM35XX),
> >>>           CLK(NULL,       "ts_fck",&ts_fck,        CK_3430ES2 |
> >> CK_AM35XX),
> >>>           CLK(NULL,       "usbtll_fck",&usbtll_fck,    CK_3430ES2 |
> >> CK_AM35XX),
> >>> @@ -3380,14 +3380,14 @@ static struct omap_clk omap3xxx_clks[] = {
> >>>           CLK(NULL,       "per_48m_fck",&per_48m_fck,   CK_3XXX),
> >>>           CLK(NULL,       "uart3_fck",&uart3_fck,     CK_3XXX),
> >>>           CLK(NULL,       "uart4_fck",&uart4_fck,     CK_36XX),
> >>> -       CLK(NULL,       "gpt2_fck",&gpt2_fck,      CK_3XXX),
> >>> -       CLK(NULL,       "gpt3_fck",&gpt3_fck,      CK_3XXX),
> >>> -       CLK(NULL,       "gpt4_fck",&gpt4_fck,      CK_3XXX),
> >>> -       CLK(NULL,       "gpt5_fck",&gpt5_fck,      CK_3XXX),
> >>> -       CLK(NULL,       "gpt6_fck",&gpt6_fck,      CK_3XXX),
> >>> -       CLK(NULL,       "gpt7_fck",&gpt7_fck,      CK_3XXX),
> >>> -       CLK(NULL,       "gpt8_fck",&gpt8_fck,      CK_3XXX),
> >>> -       CLK(NULL,       "gpt9_fck",&gpt9_fck,      CK_3XXX),
> >>> +       CLK("omap-timer.2",     "fck",&gpt2_fck,      CK_3XXX),
> >>> +       CLK("omap-timer.3",     "fck",&gpt3_fck,      CK_3XXX),
> >>> +       CLK("omap-timer.4",     "fck",&gpt4_fck,      CK_3XXX),
> >>> +       CLK("omap-timer.5",     "fck",&gpt5_fck,      CK_3XXX),
> >>> +       CLK("omap-timer.6",     "fck",&gpt6_fck,      CK_3XXX),
> >>> +       CLK("omap-timer.7",     "fck",&gpt7_fck,      CK_3XXX),
> >>> +       CLK("omap-timer.8",     "fck",&gpt8_fck,      CK_3XXX),
> >>> +       CLK("omap-timer.9",     "fck",&gpt9_fck,      CK_3XXX),
> >>>           CLK(NULL,       "per_32k_alwon_fck",&per_32k_alwon_fck,
> >> CK_3XXX),
> >>>           CLK(NULL,       "gpio6_dbck",&gpio6_dbck,    CK_3XXX),
> >>>           CLK(NULL,       "gpio5_dbck",&gpio5_dbck,    CK_3XXX),
> >>> @@ -3428,7 +3428,7 @@ static struct omap_clk omap3xxx_clks[] = {
> >>>           CLK(NULL,       "sr2_fck",&sr2_fck,       CK_343X),
> >>>           CLK(NULL,       "sr_l4_ick",&sr_l4_ick,     CK_343X),
> >>>           CLK(NULL,       "secure_32k_fck",&secure_32k_fck, CK_3XXX),
> >>> -       CLK(NULL,       "gpt12_fck",&gpt12_fck,     CK_3XXX),
> >>> +       CLK("omap-timer.12",    "fck",&gpt12_fck,     CK_3XXX),
> >>>           CLK(NULL,       "wdt1_fck",&wdt1_fck,      CK_3XXX),
> >>>           CLK(NULL,       "ipss_ick",&ipss_ick,      CK_AM35XX),
> >>>           CLK(NULL,       "rmii_ck",&rmii_ck,       CK_AM35XX),
> >>> @@ -3441,6 +3441,30 @@ static struct omap_clk omap3xxx_clks[] = {
> >>>           CLK("musb_hdrc",        "fck",&hsotgusb_fck_am35xx,
> >> CK_AM35XX),
> >>>           CLK(NULL,       "hecc_ck",&hecc_ck,       CK_AM35XX),
> >>>           CLK(NULL,       "uart4_ick",&uart4_ick_am35xx,
> CK_AM35XX),
> >>> +       CLK("omap-timer.1",     "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.2",     "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.3",     "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.4",     "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.5",     "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.6",     "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.7",     "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.8",     "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.9",     "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.10",    "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.11",    "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.12",    "32k_ck",&omap_32k_fck,  CK_3XXX),
> >>> +       CLK("omap-timer.1",     "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.2",     "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.3",     "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.4",     "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.5",     "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.6",     "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.7",     "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.8",     "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.9",     "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.10",    "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.11",    "sys_ck",&sys_ck,        CK_3XXX),
> >>> +       CLK("omap-timer.12",    "sys_ck",&sys_ck,        CK_3XXX),
> >>>    };
> >>>
> >>>
> >>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-
> >> omap2/clock44xx_data.c
> >>> index 1599836..d081c10 100644
> >>> --- a/arch/arm/mach-omap2/clock44xx_data.c
> >>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> >>> @@ -2922,16 +2922,16 @@ static struct omap_clk omap44xx_clks[] = {
> >>>           CLK(NULL,       "smartreflex_iva_fck",&smartreflex_iva_fck,
> >> CK_443X),
> >>>           CLK(NULL,       "smartreflex_mpu_fck",&smartreflex_mpu_fck,
> >> CK_443X),
> >>>           CLK(NULL,       "gpt1_fck",&timer1_fck,    CK_443X),
> >>> -       CLK(NULL,       "gpt10_fck",&timer10_fck,   CK_443X),
> >>> -       CLK(NULL,       "gpt11_fck",&timer11_fck,   CK_443X),
> >>> -       CLK(NULL,       "gpt2_fck",&timer2_fck,    CK_443X),
> >>> -       CLK(NULL,       "gpt3_fck",&timer3_fck,    CK_443X),
> >>> -       CLK(NULL,       "gpt4_fck",&timer4_fck,    CK_443X),
> >>> -       CLK(NULL,       "gpt5_fck",&timer5_fck,    CK_443X),
> >>> -       CLK(NULL,       "gpt6_fck",&timer6_fck,    CK_443X),
> >>> -       CLK(NULL,       "gpt7_fck",&timer7_fck,    CK_443X),
> >>> -       CLK(NULL,       "gpt8_fck",&timer8_fck,    CK_443X),
> >>> -       CLK(NULL,       "gpt9_fck",&timer9_fck,    CK_443X),
> >>> +       CLK("omap-timer.10",    "fck",&timer10_fck,   CK_443X),
> >>> +       CLK("omap-timer.11",    "fck",&timer11_fck,   CK_443X),
> >>> +       CLK("omap-timer.2",     "fck",&timer2_fck,    CK_443X),
> >>> +       CLK("omap-timer.3",     "fck",&timer3_fck,    CK_443X),
> >>> +       CLK("omap-timer.4",     "fck",&timer4_fck,    CK_443X),
> >>> +       CLK("omap-timer.5",     "fck",&timer5_fck,    CK_443X),
> >>> +       CLK("omap-timer.6",     "fck",&timer6_fck,    CK_443X),
> >>> +       CLK("omap-timer.7",     "fck",&timer7_fck,    CK_443X),
> >>> +       CLK("omap-timer.8",     "fck",&timer8_fck,    CK_443X),
> >>> +       CLK("omap-timer.9",     "fck",&timer9_fck,    CK_443X),
> >>>           CLK(NULL,       "uart1_fck",&uart1_fck,     CK_443X),
> >>>           CLK(NULL,       "uart2_fck",&uart2_fck,     CK_443X),
> >>>           CLK(NULL,       "uart3_fck",&uart3_fck,     CK_443X),
> >>> @@ -2997,6 +2997,28 @@ static struct omap_clk omap44xx_clks[] = {
> >>>           CLK(NULL,       "uart3_ick",&dummy_ck,      CK_443X),
> >>>           CLK(NULL,       "uart4_ick",&dummy_ck,      CK_443X),
> >>>           CLK("omap_wdt", "ick",&dummy_ck,      CK_443X),
> >>> +       CLK("omap-timer.1",     "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.2",     "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.3",     "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.4",     "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.5",     "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.6",     "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.7",     "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.8",     "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.9",     "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.10",    "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.11",    "32k_ck",&sys_32k_ck,    CK_443X),
> >>> +       CLK("omap-timer.1",     "sys_ck",&sys_clkin_ck,  CK_443X),
> >>> +       CLK("omap-timer.2",     "sys_ck",&sys_clkin_ck,  CK_443X),
> >>> +       CLK("omap-timer.3",     "sys_ck",&sys_clkin_ck,  CK_443X),
> >>> +       CLK("omap-timer.4",     "sys_ck",&sys_clkin_ck,  CK_443X),
> >>> +       CLK("omap-timer.9",     "sys_ck",&sys_clkin_ck,  CK_443X),
> >>> +       CLK("omap-timer.10",    "sys_ck",&sys_clkin_ck,  CK_443X),
> >>> +       CLK("omap-timer.11",    "sys_ck",&sys_clkin_ck,  CK_443X),
> >>> +       CLK("omap-timer.5",     "sys_ck",&syc_clk_div_ck,
> >> CK_443X),
> >>> +       CLK("omap-timer.6",     "sys_ck",&syc_clk_div_ck,
> >> CK_443X),
> >>> +       CLK("omap-timer.7",     "sys_ck",&syc_clk_div_ck,
> >> CK_443X),
> >>> +       CLK("omap-timer.8",     "sys_ck",&syc_clk_div_ck,
> >> CK_443X),
> >>>    };
> >>>
> >>>    int __init omap4xxx_clk_init(void)
> >>> --
> >>> 1.6.0.4
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

