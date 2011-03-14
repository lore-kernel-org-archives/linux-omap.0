From: "Jan, Sebastien" <s-jan@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Mon, 14 Mar 2011 11:37:37 +0100
Message-ID: <AANLkTi=CKaUAXtLgFOSVmhrHm2Kdt8yUzY2_07Bijqi-@mail.gmail.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com> <1299764643.2017.177.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42238 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752308Ab1CNKhy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 06:37:54 -0400
Received: by mail-qy0-f177.google.com with SMTP id 38so4323253qyl.15
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 03:37:53 -0700 (PDT)
In-Reply-To: <1299764643.2017.177.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Thu, Mar 10, 2011 at 2:44 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> I think this version is good. It works for me, at least =).
>
> Any Panda or Blaze owners reading this want to give this a try?

Tested on my pandaboard, with these patches applied on top of your
dss2 tree: I get a working display on my DVI or my HDMI screen. => I
tested by running the Ubuntu UI.

I have a couple of these traces from times to times (seems linked to
screen saver enabling/disabling the screen):
omapdss DISPC error: timeout waiting for EVSYNC

The best screen resolution is properly selected on both of my screens,
but the frame-buffer is sized to 640x480. So the display works but the
usable surface when going though /dev/fb0 is quite reduced.
Is there a way to get the FB sized according to the screen resolution
(in the init sequence, it appears that the FBs are allocated before
the init of the HDMI)?

Fyi, I have also tested with the patches for DVI support and can get
both outputs working simultaneously (my tree is here:
http://dev.omapzoom.org/?p=sebjan/kernel.git;a=shortlog;h=refs/tags/topic-display-iv1-2.6.38-rc7).
