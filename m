From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH RESEND 3/5] ARM: OMAP2+: AM33XX: Add clock entries to
 omap_clk data
Date: Wed, 19 Sep 2012 21:24:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209192124090.5264@utopia.booyaka.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com> <1348089570-16161-4-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57616 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab2ISVYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:24:32 -0400
In-Reply-To: <1348089570-16161-4-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi

On Thu, 20 Sep 2012, AnilKumar Ch wrote:

> Add AM335x cpu0 clock entry to the corresponding clock data
> file. This is useful in getting the correct mpu clock pointer
> to change the cpu frequency in cpufreq driver.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Looks like this one is unrelated to the DTS changes, so I'll queue it 
separately here for 3.7.

- Paul
