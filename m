From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [Patch v2 1/2] OMAP2PLUS:DSS2: add opt_clock_available in pdata
Date: Tue, 1 Mar 2011 08:37:01 +0200
Message-ID: <1298961421.2011.14.camel@deskari>
References: <1298905363-28871-1-git-send-email-sumit.semwal@ti.com>
	 <1298905363-28871-2-git-send-email-sumit.semwal@ti.com>
	 <1298909028.9809.139.camel@deskari>
	 <AANLkTi=gTJLBeSNxTbteWydru9wnfSNDMi89cS-QB_UC@mail.gmail.com>
	 <1298960399.2011.3.camel@deskari>
	 <AANLkTim2S7La5-ASRqkOUpD0-J1agu2zx_TsPQrEDLzr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36900 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755208Ab1CAGhK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 01:37:10 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p216bALP011599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 00:37:10 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p216b9Qp001781
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 00:37:09 -0600 (CST)
In-Reply-To: <AANLkTim2S7La5-ASRqkOUpD0-J1agu2zx_TsPQrEDLzr@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Semwal, Sumit" <sumit.semwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

On Tue, 2011-03-01 at 00:27 -0600, Semwal, Sumit wrote:
> On Tue, Mar 1, 2011 at 11:49 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Mon, 2011-02-28 at 23:42 -0600, Semwal, Sumit wrote:
> >> On Mon, Feb 28, 2011 at 9:33 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> > On Mon, 2011-02-28 at 09:02 -0600, Semwal, Sumit wrote:
> >> >> Provide a function in pdata to allow dss submodules to check if a given
> >> >> clock is available on a platform as an optional clock.
> >> >>
> >> >> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> >> >> (based on implementation from Senthil)
> >> >>
> >> >> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> >> >> ---
> >> >>  arch/arm/mach-omap2/display.c             |   20 ++++++++++++++++++++
> >> >>  arch/arm/plat-omap/include/plat/display.h |    2 ++
> >> >>  2 files changed, 22 insertions(+), 0 deletions(-)
> >> >>
> >> >> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> >> >> index 5ab6a74..9f4f862 100644
> >> >> --- a/arch/arm/mach-omap2/display.c
> >> >> +++ b/arch/arm/mach-omap2/display.c
> >> >> @@ -42,6 +42,25 @@ static struct omap_device_pm_latency omap_dss_latency[] = {
> >> >>       },
> >> >>  };
> >> >>
> >> >> +static bool opt_clock_available(const char *clk_role)
> >> >> +{
> >> >> +     int i;
> >> >> +     struct omap_hwmod *oh;
> >> >> +
> >> >> +     /* opt_clks are always associated with dss hwmod */
> >> >> +     oh = omap_hwmod_lookup("dss_core");
> >> >> +     if (!oh) {
> >> >> +             pr_err("Could not look up dss_core.\n");
> >> >> +             return -ENODEV;
> >> >
> >> > The function returns a bool. Perhaps the lookup would be better done in
> >> > omap_display_init(), and stored in a static variable.
> >> Yes; I guess I should go with your earlier suggestion - of keeping
> >> this 'oh' as part of pdata, and then use it here.
> >
> > I don't think it needs to be part of pdata. It's internal to this file,
> > and if I'm not mistaken, omap_display_init() is called just once from
> > the current board file. Thus the data could as well be stored in a
> > static variable.
> :) ok, that's correct; though we might need to make 'oh' part of pdata
> based on our adaptation to the reset functionality - but that will
> come later.
> >
> >> > Or if it's clear that this should never happen, BUG_ON(!oh);
> >> Well, multiple people have 'frowned' upon using BUG_ON in dss -
> >> especially because some people might still want their kernel to keep
> >> working despite a display failure?
> >
> > Yes, BUG is an easy, not good, way out =).
> :) hmmm... should I just return 'false' and print out a warning?

>From opt_clock_available() if the hwmod was not found? Well, preferably
opt_clock_available() will never be called, if the hwmod is not found in
omap_display_init(). So omap_display_init() should fail -> DSS driver
refuses to start -> opt_clock_available() is never called.

 Tomi


