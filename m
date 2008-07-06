From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 3/4] Hook start_hnp into ohci struct
Date: Sun, 6 Jul 2008 15:55:22 +0400
Message-ID: <20080706115522.GE28505@doriath.ww600.siemens.net>
References: <20080706102630.GA29934@doriath.ww600.siemens.net> <20080706103050.GB20019@kedavra.cpe.vivax.com.br> <20080706103332.GA28505@doriath.ww600.siemens.net> <20080706110507.GA6615@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:38817 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbYGFLza (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Jul 2008 07:55:30 -0400
Received: by ug-out-1314.google.com with SMTP id h2so965293ugf.16
        for <linux-omap@vger.kernel.org>; Sun, 06 Jul 2008 04:55:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080706110507.GA6615@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Sun, Jul 06, 2008 at 02:05:07PM +0300, Felipe Balbi wrote:
> On Sun, Jul 06, 2008 at 02:33:32PM +0400, Dmitry Baryshkov wrote:
> > Actually the ohci-omap.c:start_hnp does a bit more than just
> > otg_start_hnp(tranceiver). Maybe it should be merged. I dunno.
> 
> Most likely it should be merged, or at least the name should change.

As I'm neither OMAP nor OTG expert, leaving the decision for somebody
with more experience.

-- 
With best wishes
Dmitry

