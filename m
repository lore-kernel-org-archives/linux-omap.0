From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 18:01:50 +0530
Message-ID: <CAJe_ZhfevYJGKEDxmXaBJk3MvvPiFysrvctKqZiD+E1J0DxLsg@mail.gmail.com>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
	<1340869729.5037.7.camel@deskari>
	<CAJe_ZhcWSYhRWSW0v9OqsHRXASsQ8i2P8F8OS+jXkyadoRM9iA@mail.gmail.com>
	<1340878461.5037.30.camel@deskari>
	<CAJe_Zhc_ye1f=hOVd=AJ7rmCQ_vwDtjQOKsufPYmV1o-58jyAA@mail.gmail.com>
	<CAJe_ZhfehDquDcyefb7Z9odH+hfQTFiRAux_iyvAycs9Otovtw@mail.gmail.com>
	<1340881815.5037.53.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55859 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab2F1Mbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 08:31:52 -0400
Received: by lbbgm6 with SMTP id gm6so3038469lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 05:31:50 -0700 (PDT)
In-Reply-To: <1340881815.5037.53.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org

On 28 June 2012 16:40, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Thu, 2012-06-28 at 16:28 +0530, Jassi Brar wrote:
> >
>> Sorry a correction. Reading detect() won't work. I suggest we keep HPD
>> IRQ enabled for the lifetime of the driver.
>
> Ok, I see. But that's not acceptable. It would require us to keep the
> TPD12S015 always powered and enabled. Even if you're not interested in
> using HDMI at all.
>
 I think we need to differentiate between HDMI PHY enable and HDMI
5V+,HPD enable [1]... currently they are clubbed together in
omap_dss_device.platform_enable.  AFAIK, at least with TPD12S015, they
can be controlled independently and PHY enabling is actually the main
source of power consumption if no display is connected.

By 'lifetime' I mean when the end-user selects some option to the
effect of "Automatically detect and configure display over HDMI" ....
and then we simply enable the HDMI 5V+/HPD,   HDMI-PHY would be
enabled only when we actually detect HPD asserted. If a device doesn't
have a port or the user doesn't have a display, neither would be ever
enabled. I mean we should provide a way to make it platform dependent.


 [1]  Thanks to Andy and his crappy TV, he found clubbing enabling PHY
with 5V+ application comes in the way of detecting cheapo displays
that take ~700ms before asserting HPD i.e, making EDID available. See
how we don't leave it to a HDMI display to take it's own time before
asserting HPD - omapdss_hdmi_display_enable/disable pairs don't care
for that.
