From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] USB: twl4030: Enable USB regulators before enabling USB
 charging
Date: Mon, 23 Nov 2009 23:51:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C86348@dbde02.ent.ti.com>
References: <23D0CDE7C386D144A4F26EB0F427F8C074CF85B0@dlee04.ent.ti.com>,<20091123175948.GF22923@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34129 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbZKWSWk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 13:22:40 -0500
In-Reply-To: <20091123175948.GF22923@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren wrote:
> * Aguilar Pena, Leed <leed.aguilar@ti.com> [091119 10:34]:
> > For TWL family of power management ICs, USB charging works only
> > when USB regulators are in enabled state: 3v1, 1v5, 1v8
> >
> > On a USB cable attach, twl4030_phy_resume(twl) function enables
> > the regulators. Enable USB charging, only after all regulators
> > are enabled.
> >
> > Its observed that enabling USB charging before regulators are
> > enabled, causes USB charging to fail.
> >
> > Tested on: Zoom2: omap3430: ES3.1 + TWL5030
> > Needs T2-MADC and T2-BCI drivers which are still not upstreamed.
> 
> This should go to linux-usb list with linux-omap list Cc'd.
> 

It's already in greg's queue.

- Anand