From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/3] OMAP: VRAM: improve VRAM error prints
Date: Wed, 10 Nov 2010 14:04:14 +0200
Message-ID: <1289390654.3297.202.camel@tubuntu>
References: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
	 <20101110115148.GA2120@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:34860 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab0KJMC1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Nov 2010 07:02:27 -0500
In-Reply-To: <20101110115148.GA2120@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Mundt <lethal@linux-sh.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wed, 2010-11-10 at 12:51 +0100, ext Paul Mundt wrote:
> On Wed, Nov 10, 2010 at 11:45:18AM +0200, Tomi Valkeinen wrote:
> > Improve the error prints to give more information about the offending
> > address & size.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> 
> 1-3 queued for .37, thanks.

They were just for review =).

If it's ok to you, I'll pick all OMAP display related patches to my
tree, and send you a pull request when I think they are ready.

But for these three patches it's ok if you already queued them: they are
quite high priority, as the OMAP framebuffer doesn't work at all without
the second patch.

 Tomi


