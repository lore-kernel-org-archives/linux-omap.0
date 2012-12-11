From: Paolo Pisati <p.pisati@gmail.com>
Subject: kexec: cpufreq: omap3: hangs in dpll3xxx.c::_omap3_dpll_write_clken()
Date: Tue, 11 Dec 2012 16:03:43 +0100
Message-ID: <20121211150343.GA4261@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59943 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab2LKPDr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Dec 2012 10:03:47 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so2262145eek.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Dec 2012 07:03:46 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I've been experiencing solid hangs on my beaglexm with v3.7 after
kexec:

here is my .config (omap2plus + EHCI/OHCI + CPUFREQ + DEVTMP):

http://people.canonical.com/~ppisati/omap3_cpufreq_kexec/config

here is the diff i added to get some debugging:

http://people.canonical.com/~ppisati/omap3_cpufreq_kexec/dpll-debug.diff

here is a trace of the kexeced kernel:

http://people.canonical.com/~ppisati/omap3_cpufreq_kexec/kexec-boot.txt

Since i'n not familiar with those dplls, can anyone shed some light?
-- 
bye,
p.
