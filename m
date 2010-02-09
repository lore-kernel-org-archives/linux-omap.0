From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 14/17] OMAP: DSS2: move enable/disable/suspend/resume
Date: Tue, 09 Feb 2010 14:12:57 +0200
Message-ID: <1265717577.2433.73.camel@tubuntu.research.nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-9-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-10-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-11-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-12-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-13-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-14-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-15-git-send-email-tomi.valkeinen@nokia.com>
	 <6ed0b2681002090215g4e53851bgb11c5a507bdf6dff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34855 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab0BIMK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 07:10:26 -0500
In-Reply-To: <6ed0b2681002090215g4e53851bgb11c5a507bdf6dff@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, 2010-02-09 at 11:15 +0100, ext Grazvydas Ignotas wrote:
> On Mon, Feb 8, 2010 at 5:57 PM, Tomi Valkeinen <tomi.valkeinen@nokia.com> wrote:
> > Move enable/disable/suspend/resume from omap_dss_device to
> > omap_dss_driver.
> >
> > This is part of a larger patch-set, which moves the control from omapdss
> > driver to the display driver.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > ---
> 
> <snip>
> 
> > diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> > index f297a46..c6e4a7e 100644
> > --- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> > +++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> > @@ -262,18 +262,20 @@ static const struct omap_video_timings tpo_td043_timings = {
> >        .vbp            = 34,
> >  };
> >
> > -static int tpo_td043_enable(struct omap_dss_device *dssdev)
> > +static int generic_panel_power_on(struct omap_dss_device *dssdev)
> 
> I guess you meant tpo_td043_power_on/tpo_td043_power_off?

Yes, copy paste error =)

> I'll try to test your both series later this week.

Thanks.

 Tomi


