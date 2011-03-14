From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] omap3: alsa-soc: Remove restrictive check for cpu type
Date: Mon, 14 Mar 2011 16:00:40 +0200
Message-ID: <20110314160040.c15c0c8d.jhnikula@gmail.com>
References: <1300109513-29002-1-git-send-email-premi@ti.com>
	<20110314155542.b60bd852.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60723 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1CNN6h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 09:58:37 -0400
Received: by eyx24 with SMTP id 24so1617597eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 06:58:36 -0700 (PDT)
In-Reply-To: <20110314155542.b60bd852.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

On Mon, 14 Mar 2011 15:55:42 +0200
Jarkko Nikula <jhnikula@gmail.com> wrote:

> On Mon, 14 Mar 2011 19:01:53 +0530
> Sanjeev Premi <premi@ti.com> wrote:
> 
> > Current check for cpu type is too restrictive leading to
> > failures for other silicons in same family.
> > 
> > The problem was found while testing audio playback on
> > AM37x and AM35x processors. But should exist on OMAP36xx
> > as well.
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  sound/soc/omap/omap-mcbsp.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> There are two other cpu_is_omap343x tests as well. Care to check them
> too?
> 
Sorry, only one additional test. I forgot the commit 2686e07 "ASoC:
McBSP: get hw params from McBSP driver" that is coming via linux-omap
and which removes one test.

-- 
Jarkko
