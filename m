From: Enrico Butera <ebutera@gmail.com>
Subject: Re: OMAP watchdog broken on 37XX?
Date: Sat, 2 Jul 2011 01:04:42 +0200
Message-ID: <BANLkTi=F0wzMXUOUFJ2y9CeRkYckMDyaVA@mail.gmail.com>
References: <BANLkTi=WQzdfOXqYWGe8gFjrn=kHbg-2eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53790 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914Ab1GAXEn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 19:04:43 -0400
Received: by vxb39 with SMTP id 39so2646146vxb.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 16:04:42 -0700 (PDT)
In-Reply-To: <BANLkTi=WQzdfOXqYWGe8gFjrn=kHbg-2eQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Sun, Jun 26, 2011 at 11:52 PM, Daniel Seifert <dseifert@gmx.de> wrote:
> Yes, I experience the same problem. On a 35xx board the watchdog
> worked fine, but on a DM3730 one it just freezes up. Tried with 2.6.35
> and 3.0.0-rc3-g19a1166 (omap2plus defconfig). Has anybody seen a patch
> for this yet?

did you try twl4030_wdt instead of omap_wdt?

Enrico
