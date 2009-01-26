From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] Disable linux-omap version of menelaus
Date: Mon, 26 Jan 2009 13:40:05 -0800
Message-ID: <200901261340.05286.david-b@pacbell.net>
References: <20090122131602.18315.84862.stgit@tikku> <20090123022334.GN7172@atomide.com> <877i4iqp00.fsf@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:43214 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751879AbZAZVkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Jan 2009 16:40:08 -0500
In-Reply-To: <877i4iqp00.fsf@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Monday 26 January 2009, Kalle Valo wrote:
> > I'll also remove drivers/i2c/chips/menelaus.c.
> 
> Thanks. It's nice to see drivers going to upstream.

That driver has been upstream for quite a long time now.
This change was just helping scrub drivers/i2c/chips,
since it's going away.

That means all drivers which the OMAP tree has in that
directory should be pushed upstream, or at least moved
to a better home, soon ... :)

- Dave

