From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config
 option
Date: Fri, 24 Jul 2009 21:00:05 +0300 (EEST)
Message-ID: <20090724.210005.226780464.Hiroshi.DOYU@nokia.com>
References: <1248431051-26340-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E3A8CAD56@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42088 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbZGXSAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 14:00:17 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD56@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, ameya.palande@nokia.com, x0095840@ti.com, omar.ramirez@ti.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config option
Date: Fri, 24 Jul 2009 19:28:47 +0200

> Hi Doyu-san,
> 
> > 
> > "CONFIG_DSP_TRACEBUF" is introduced as a kernel config option to save
> > some amount of unused memory and "#ifndef DSP_TRACEBUF_DISABLED" was
> > not easy to understand.
> >
> 
> I think we just use the Bridge DEBUG flag that is used in Bridge instead of introducing a new flag. 

It might be better if "CONFIG_DSP_TRACEBUF" had the dependecy on
"DEBUG/CONFIG_BRIDGE_DEBUG", but it's not unfortunately.

The problem here is that now all TRACEBUF code is always compiled in
in spite of setting "DEBUG". It doesn't print anything, but just
wastes some memory.

I'll remove a new Kconfig entry and just add the dependency of
"CONFIG_DSP_TRACEBUF" on "CONFIG_BRIDGE_DEBUG".
