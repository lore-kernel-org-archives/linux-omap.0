From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Wed, 19 Nov 2008 09:34:14 -0800
Message-ID: <200811190934.14552.david-b@pacbell.net>
References: <12266521123866-git-send-email-ext-eero.nurkkala@nokia.com> <200811141116.13682.david-b@pacbell.net> <1227096723.27458.9.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:20576 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752024AbYKSReR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 12:34:17 -0500
In-Reply-To: <1227096723.27458.9.camel@eenurkka-desktop>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

On Wednesday 19 November 2008, Eero Nurkkala wrote:
> On Fri, 2008-11-14 at 11:16 -0800, ext David Brownell wrote:

> > But if the issue is that the 2430 version of the FIFO
> > support works differently, please say so in the patch
> > commend and code...
>
> I checked against 2420, and there was no such register
> avaiable at all.  (no 2430 TRM access)

That code path couldn't be triggered on 2420; just 2430,
which has the FIFO (as evidently needed for highspeed I2C).

My default assumption would be that 2430 works just like
OMAP3 here, but obviously someone should check the 2430
TRM to see its I2C BUFSTAT_REG really works differently.

- Dave
