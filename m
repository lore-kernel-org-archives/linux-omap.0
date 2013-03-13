From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: OMAP baseline test results for v3.9-rc1
Date: Wed, 13 Mar 2013 09:34:01 +0200
Message-ID: <51402BE9.5040402@compulab.co.il>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:40855 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868Ab3CMHeH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 03:34:07 -0400
In-Reply-To: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/12/13 18:40, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.9-rc1.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/

[...]

> Failing tests: needing investigation
> ------------------------------------

[...]

> * CM-T3517: boot hangs with MMC root
>   - Due to missing MMC setup in board file
>   - http://www.spinics.net/lists/arm-kernel/msg211471.html
>   - Longstanding bug

This should have been fixed by:
ff95793 (ARM: OMAP3: cm-t3517: add MMC support)

I also can't find the MMC rootfs boot log on your website.


-- 
Regards,
Igor.
