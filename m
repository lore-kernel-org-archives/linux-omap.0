From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH 2/2] Input: ads7846 - configure pendown gpio as input
Date: Thu, 3 Feb 2011 12:06:54 +0530
Message-ID: <e6f09d944e51993b9d5d49b9b18a8140@mail.gmail.com>
References: <1296660646-28168-1-git-send-email-sourav.poddar@ti.com> <AANLkTi=H6bJMv4_FnC9ZNXYFetttp1cOCA97+uJmnMi8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:45578 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709Ab1BCGgz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 01:36:55 -0500
In-Reply-To: <AANLkTi=H6bJMv4_FnC9ZNXYFetttp1cOCA97+uJmnMi8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha Varadarajan <charu@ti.com>, Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org

Varadarajan, Charulatha wrote:
> On Wed, Feb 2, 2011 at 21:00, Sourav Poddar <sourav.poddar@ti.com>
wrote:
> > The ads7846 driver requests a gpio to detect pendown events,
> > but does not configure its direction. Configure this gpio
> > as an input after requesting it.
> >
>
> NACK to this patch too for similar reasons as in patch1 of
> this series.
>

What similar reasons? Felipe's comment about checking for
a return value here is valid. But I don't see your point.

The driver does a gpio_request just two lines above
and does not set the direction. gpio_request does
not set the direction by itself. Maybe it's not essential
and the default is to have direction as input, but
it's quite common to explicitly configure this.

Confused,
Anand
