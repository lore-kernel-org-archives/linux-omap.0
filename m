From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: kexec: cpufreq: omap3: hangs in
 dpll3xxx.c::_omap3_dpll_write_clken()
Date: Wed, 12 Dec 2012 09:32:57 +0100
Message-ID: <20121212083257.GA4272@luxor.wired.org>
References: <20121211150343.GA4261@luxor.wired.org>
 <alpine.DEB.2.00.1212112019320.26612@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:46717 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab2LLIdB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 03:33:01 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so125934eaa.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Dec 2012 00:32:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1212112019320.26612@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Paolo Pisati <p.pisati@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Tue, Dec 11, 2012 at 08:20:13PM +0000, Paul Walmsley wrote:
> On Tue, 11 Dec 2012, Paolo Pisati wrote:
> 
> > I've been experiencing solid hangs on my beaglexm with v3.7 after
> > kexec:
> 
> Does it crash if you boot v3.7 directly from the bootloader, i.e., without 
> kexec?

nope, works perfectly fine when booted from the bootlader.

-- 
bye,
p.
