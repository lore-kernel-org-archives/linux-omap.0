From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
 (try #8)
Date: Thu, 18 Nov 2010 11:11:09 +0200
Message-ID: <1290071469.3431.4.camel@tubuntu>
References: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
	 <1290003526.26444.30.camel@tubuntu>
	 <AANLkTinP=xJ66qTZA4JTXFNH+xqvKWgV-XhExoPr6o-C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:17478 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab0KRJLQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 04:11:16 -0500
In-Reply-To: <AANLkTinP=xJ66qTZA4JTXFNH+xqvKWgV-XhExoPr6o-C@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Bryan Wu <bryan.wu@canonical.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com

On Thu, 2010-11-18 at 10:14 +0800, ext Bryan Wu wrote:
> On Wed, Nov 17, 2010 at 10:18 PM, Tomi Valkeinen

> > Are you also interested in solving the backlight issue? =)
> 
> Yeah, can I start with
> drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c. I plan to move
> the blacklight code to drivers/video/blacklight/ and let sharp_ls to
> use panel-generic-dpi.c driver.

Yes, I think that's a good solution for the panels which have a separate
backlight (ie. all these "dummy" panels"). However, I'm not sure how
that would work for panels with more integrated backlight, for example
Taal. But we don't need to worry about that right now.

 Tomi


