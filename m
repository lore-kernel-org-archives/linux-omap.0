From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix tusb6010 init error and compilation
 warning
Date: Thu, 7 May 2009 08:17:49 +0300
Message-ID: <20090507081749.97749b2e.jhnikula@gmail.com>
References: <1240468227-15393-1-git-send-email-jarkko.nikula@nokia.com>
	<8763gvb8ps.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:39996 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbZEGFQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 01:16:25 -0400
Received: by ewy24 with SMTP id 24so774664ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 06 May 2009 22:16:25 -0700 (PDT)
In-Reply-To: <8763gvb8ps.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>

On Thu, 23 Apr 2009 20:06:39 +0300
Kalle Valo <kalle.valo@iki.fi> wrote:

> Jarkko Nikula <jarkko.nikula@nokia.com> writes:
> 
> > Fix "tusb6010 init error 5, -19" and compilation warning from
> > function tusb6010_platform_retime "warning: 'sysclk_ps' is used
> > uninitialized in this function".
> >
> > I suppose commit c094ba34b8f780885d029ce3c2715a194b780e5d was meant
> > to test for zero fclk_ps instead of sysclk_ps.
> 
> I was suffering exactly this problem and this patch fixed it. Now usb
> network works again, thanks a lot for fixing this!
> 
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> > Cc: Roel Kluin <roel.kluin@gmail.com>
> 
> Tested-by: Kalle Valo <kalle.valo@iki.fi>
> 
Ping? This patch was a fix for 2.6.30-rcX.


-- 
Jarkko
