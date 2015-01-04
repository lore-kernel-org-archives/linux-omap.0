From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.19-rc1
Date: Sun, 4 Jan 2015 18:44:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501041842210.28771@utopia.booyaka.com>
References: <alpine.DEB.2.02.1501030712210.27058@utopia.booyaka.com> <8629693.mvYldWiixb@wuerfel> <alpine.DEB.2.02.1501031955170.27058@utopia.booyaka.com> <8185039.GnfXITBRGF@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43534 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbbADSoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2015 13:44:14 -0500
In-Reply-To: <8185039.GnfXITBRGF@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, kernel-build-reports@lists.linaro.org

On Sun, 4 Jan 2015, Arnd Bergmann wrote:

> So 3.16 was by far the largest increase, almost 10x bigger than the 3.19 increase, but
> others are quite big as well.
> 
> Do you know what happened in 3.16?

It was commit 1413c03893332366e5b4d1e26f942ada25f3e82a ("lockdep: Increase 
static allocations").


- Paul

commit 1413c03893332366e5b4d1e26f942ada25f3e82a
Author: Sasha Levin <sasha.levin@oracle.com>
Date:   Wed Jan 8 14:21:46 2014 -0500

    lockdep: Increase static allocations
    
    Fuzzing a recent kernel with a large configuration hits the static
    allocation limits and disables lockdep.
    
    This patch doubles the limits.
    
    Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
    Signed-off-by: Peter Zijlstra <peterz@infradead.org>
    Link: http://lkml.kernel.org/r/1389208906-24338-1-git-send-email-sasha.levin@oracle.com
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

