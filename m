From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Multimachine uImage and cpufreq-cpu0/cpufreq-omap2 breakage
Date: Wed, 17 Oct 2012 12:18:22 +0200
Message-ID: <2371665D-9B6F-4163-B3E3-F24F771C10DA@dominion.thruhere.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58616 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab2JQKSH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 06:18:07 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so6206583wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 17 Oct 2012 03:18:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Hi,

I'm currently building 3.7rc1 kernels meant to run on beagleboards (omap3), pandaboards (omap4) and beaglebones (am335x). At the moment I'm only testing it on beaglebone and I noticed a problem with the different cpufreq drivers getting in eachothers way.

I patched in cpufreq-cpu0 support for AM335x and that's was working great. After rebasing to 3.7-rc1 it stopped working because cpufreq-omap2 tried to load, failed and made the cpufreq-cpu0 driver error out. The workaround is simple: only enable on driver.

So my question is: Is this the intended behaviour? I would expect the cpufreq-omap2 driver to not load when booted on am335x using DT, but it is a persistent bugger.

Thanks,

Koen