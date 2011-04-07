From: Felipe Balbi <balbi@ti.com>
Subject: Re: What is missing from musb - linux-omap merge?
Date: Thu, 7 Apr 2011 14:38:16 +0300
Message-ID: <20110407113815.GA29038@legolas.emea.dhcp.ti.com>
References: <20110406162334.8dcb5a7d.jhnikula@gmail.com>
 <b84bb921d4bb8c258966c77406cc795b@mail.gmail.com>
 <20110407133452.afc188e1.jhnikula@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:33786 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754633Ab1DGLiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 07:38:22 -0400
Received: by mail-ew0-f45.google.com with SMTP id 24so1035416ewy.18
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 04:38:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110407133452.afc188e1.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Hema Kalliguddi <hemahk@ti.com>, OMAP Linux discussion <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

On Thu, Apr 07, 2011 at 01:34:52PM +0300, Jarkko Nikula wrote:
> Hi
> 
> On Thu, 7 Apr 2011 14:38:06 +0530
> Hema Kalliguddi <hemahk@ti.com> wrote:
> 
> > I tried the core retention with v2.6.39-rc1 with OMAP3630Zoom3 board
> > and don't observe any issues. Core is transitioning to retention without
> > any issue,
> > with or without musb driver loaded.
> > 
> > But on OMAP3430SDP I am observing the crash when try to do
> > echo mem > /sys/power/state.
> > 
> > Attached is the fix for this issue and core transitions to retention.
> > 
> Hmm.. suspend/resume are fine on Nokia N900 with and without the patch.
> Patch also didn't fix the idle retention.
> 
> > When you say retention is not working can you please carify what is
> > happening?
> > are you trying in idle path retention or suspend/resume?
> > 
> Sorry not being verbose enough, I was testing the idle retention.
> 
> For me it looks these differencies are explained by different
> bootloaders. As Kevin told they may leave MUSB in a wrong state. Was it
> so that before hwmod conversion the musb did IP reset etc and now this
> feature is missing? So I'm thinking is this problem a regression or
> missing feature after hwmod conversion?

it's possibly a regression. I remember we had softreset before. Should
be fixed.

-- 
balbi
