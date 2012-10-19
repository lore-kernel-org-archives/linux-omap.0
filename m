From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: Multimachine uImage and cpufreq-cpu0/cpufreq-omap2 breakage
Date: Fri, 19 Oct 2012 06:41:00 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA54B27@DBDE01.ent.ti.com>
References: <2371665D-9B6F-4163-B3E3-F24F771C10DA@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53952 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2JSGlI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 02:41:08 -0400
In-Reply-To: <2371665D-9B6F-4163-B3E3-F24F771C10DA@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Wed, Oct 17, 2012 at 15:48:22, Koen Kooi wrote:
> Hi,
> 
> I'm currently building 3.7rc1 kernels meant to run on beagleboards (omap3), pandaboards (omap4) and beaglebones (am335x). At the moment I'm only testing it on beaglebone and I noticed a problem with the different cpufreq drivers getting in eachothers way.
> 
> I patched in cpufreq-cpu0 support for AM335x and that's was working great. After rebasing to 3.7-rc1 it stopped working because cpufreq-omap2 tried to load, failed and made the cpufreq-cpu0 driver error out. The workaround is simple: only enable on driver.
> 
> So my question is: Is this the intended behaviour? I would expect the cpufreq-omap2 driver to not load when booted on am335x using DT, but it is a persistent bugger.

Hi Koen,

AFAICS regulator_get() should return NULL if there is no "vcc" regulator
node and should not proceed further but its proceeding and doing the
cpufreq_register_driver(), so we are seeing failure for cpu0 driver
after this.

clk_get() should be moved to omap_cpufreq_init to avoid this. (Extra
protection).

Thanks
AnilKumar
