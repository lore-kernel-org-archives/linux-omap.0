From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix tusb6010 init error and compilation
	warning
Date: Tue, 12 May 2009 10:42:46 -0700
Message-ID: <20090512174246.GR5593@atomide.com>
References: <1240468227-15393-1-git-send-email-jarkko.nikula@nokia.com> <8763gvb8ps.fsf@litku.valot.fi> <20090507081749.97749b2e.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65136 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZELRmx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 13:42:53 -0400
Content-Disposition: inline
In-Reply-To: <20090507081749.97749b2e.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>

* Jarkko Nikula <jhnikula@gmail.com> [090506 22:16]:
> On Thu, 23 Apr 2009 20:06:39 +0300
> Kalle Valo <kalle.valo@iki.fi> wrote:
> 
> > Jarkko Nikula <jarkko.nikula@nokia.com> writes:
> > 
> > > Fix "tusb6010 init error 5, -19" and compilation warning from
> > > function tusb6010_platform_retime "warning: 'sysclk_ps' is used
> > > uninitialized in this function".
> > >
> > > I suppose commit c094ba34b8f780885d029ce3c2715a194b780e5d was meant
> > > to test for zero fclk_ps instead of sysclk_ps.
> > 
> > I was suffering exactly this problem and this patch fixed it. Now usb
> > network works again, thanks a lot for fixing this!
> > 
> > > Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> > > Cc: Roel Kluin <roel.kluin@gmail.com>
> > 
> > Tested-by: Kalle Valo <kalle.valo@iki.fi>
> > 
> Ping? This patch was a fix for 2.6.30-rcX.

Sorry for the delay. Pushed and added to omap-fixes, so we should
still get this in.

Regards,

Tony
