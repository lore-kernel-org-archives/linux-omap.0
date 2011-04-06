From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: What is missing from musb - linux-omap merge?
Date: Wed, 6 Apr 2011 17:51:38 +0300
Message-ID: <20110406175138.eb700a7e.jhnikula@gmail.com>
References: <20110406162334.8dcb5a7d.jhnikula@gmail.com>
	<20110406133439.GH25654@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59628 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756358Ab1DFOuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Apr 2011 10:50:25 -0400
Received: by ewy4 with SMTP id 4so475221ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Apr 2011 07:50:24 -0700 (PDT)
In-Reply-To: <20110406133439.GH25654@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>, Hema HK <hemahk@ti.com>

On Wed, 6 Apr 2011 16:34:40 +0300
Felipe Balbi <balbi@ti.com> wrote:

> Hi,
> 
> On Wed, Apr 06, 2011 at 04:23:34PM +0300, Jarkko Nikula wrote:
> > Hi
> > 
> > I've been trying to hunt why the OMAP3 retention on Nokia N900 went
> > broken in 2.6.39-rc and reason is somewhere around musb code merge with
> > linux-omap code or vise versa.
> > 
> > I bisected this into:
> 
> I guess it's the missing Hema's patch which should be queued already.
> Here it is:
> 
> commit 84cebd52a4b5d590af476869dc5b786fe567c095
> Author: Hema HK <hemahk@ti.com>
> Date:   Thu Mar 17 16:11:58 2011 +0530
> 
>     usb: musb: Fix for merge issue
>     
Yeah, that was missing from the commits I was testing but it was in
where I started bisecting and where I noticed the retention issue so
this don't fix it.

> you might also need the one below:
> 
> commit ee262c660a855864efa78181cf7b7095b6416098
> Author: Hema HK <hemahk@ti.com>
> Date:   Tue Mar 22 16:02:12 2011 +0530
> 
>     usb: musb: Fix the crash issue during reboot
>     
Applies fine to 2.6.39-rc2 but still doesn't fix the retention issue.

-- 
Jarkko
