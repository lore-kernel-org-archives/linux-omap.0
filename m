From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: [PATCH 8/8] OMAP: DSS2: OMAPFB: Reduce stack usage
Date: Wed, 11 May 2011 09:11:05 +0300
Message-ID: <1305094265.2097.0.camel@deskari>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
	 ,<1305044656-31512-9-git-send-email-tomi.valkeinen@ti.com>
	 <CA1B555B4D79E3448D96A7C9847C7D9805EFB4C7@008-AM1MPN1-031.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37086 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752174Ab1EKRZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 13:25:27 -0400
In-Reply-To: <CA1B555B4D79E3448D96A7C9847C7D9805EFB4C7@008-AM1MPN1-031.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: aaro.koskinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, 2011-05-10 at 19:08 +0000, aaro.koskinen@nokia.com wrote:
> Hi,
> 
> Tomi Valkeinen [tomi.valkeinen@ti.com]:
> > omapfb_mode_to_timings() had struct fb_info, struct fb_var and struct
> > fb_ops allocated from stack. This caused the stack usage grow quite
> > high.
> >
> > Use kzalloc to allocate the structs instead.
> 
> [...]
> 
> > +       fbi = kzalloc(sizeof(*fbi), GFP_KERNEL);
> > +       var = kzalloc(sizeof(*var), GFP_KERNEL);
> > +       fbops = kzalloc(sizeof(*fbops), GFP_KERNEL);
> > +       fbi->fbops = fbops;
> 
> You should check and prepare for allocation failures.

So I should. Thanks!

 Tomi


