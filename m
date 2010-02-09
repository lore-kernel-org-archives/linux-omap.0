From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 14/17] OMAP: DSS2: move enable/disable/suspend/resume
Date: Tue, 9 Feb 2010 12:15:39 +0200
Message-ID: <6ed0b2681002090215g4e53851bgb11c5a507bdf6dff@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:60355 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab0BIKPl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 05:15:41 -0500
In-Reply-To: <1265644661-3694-15-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, Feb 8, 2010 at 5:57 PM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> Move enable/disable/suspend/resume from omap_dss_device to
> omap_dss_driver.
>
> This is part of a larger patch-set, which moves the control from omap=
dss
> driver to the display driver.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---

<snip>

> diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/dr=
ivers/video/omap2/displays/panel-tpo-td043mtea1.c
> index f297a46..c6e4a7e 100644
> --- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> +++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> @@ -262,18 +262,20 @@ static const struct omap_video_timings tpo_td04=
3_timings =3D {
> =A0 =A0 =A0 =A0.vbp =A0 =A0 =A0 =A0 =A0 =A0=3D 34,
> =A0};
>
> -static int tpo_td043_enable(struct omap_dss_device *dssdev)
> +static int generic_panel_power_on(struct omap_dss_device *dssdev)

I guess you meant tpo_td043_power_on/tpo_td043_power_off?

I'll try to test your both series later this week.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
