From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/7] input: lm8323: get rid of global pdata pointer
Date: Thu, 16 Oct 2008 00:10:57 -0400
Message-ID: <20081016041057.GC16860@anvil.corenet.prv>
References: <1224020397-2842-1-git-send-email-me@felipebalbi.com> <1224020397-2842-2-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:57079 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYJPELJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 00:11:09 -0400
Received: by gxk9 with SMTP id 9so7828193gxk.13
        for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 21:11:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1224020397-2842-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

Hi Felipe,

On Wed, Oct 15, 2008 at 12:39:51AM +0300, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> pdata is only used during probe to initialize a few fields
> from lm8323 device structure. Moving pdata pointer to probe
> won't harm anybody.
> 

I don't think I have these drivers.  I also think that they should
depend on GPIOLIB (I noticed that OMAP selects GPIOLIB but I think
ecplicit dependency should still be present).

-- 
Dmitry
