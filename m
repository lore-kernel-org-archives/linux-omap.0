From: Paul Walmsley <paul@pwsan.com>
Subject: Re: kexec: cpufreq: omap3: hangs in
 dpll3xxx.c::_omap3_dpll_write_clken()
Date: Tue, 11 Dec 2012 20:20:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212112019320.26612@utopia.booyaka.com>
References: <20121211150343.GA4261@luxor.wired.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47201 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2LKUUO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Dec 2012 15:20:14 -0500
In-Reply-To: <20121211150343.GA4261@luxor.wired.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, 11 Dec 2012, Paolo Pisati wrote:

> I've been experiencing solid hangs on my beaglexm with v3.7 after
> kexec:

Does it crash if you boot v3.7 directly from the bootloader, i.e., without 
kexec?


- Paul
