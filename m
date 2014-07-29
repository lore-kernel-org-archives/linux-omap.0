From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Tue, 29 Jul 2014 08:50:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407290847210.1626@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com> <20140707080238.GF28884@atomide.com> <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com> <20140729064243.GF29045@atomide.com> <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36980 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaG2IuS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 04:50:18 -0400
In-Reply-To: <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Tue, 29 Jul 2014, Paul Walmsley wrote:

> I should probably read back those writes to autosuspend_delay_ms, just to 
> make sure they are reaching the right destinations. 

Just took a whack at that, looks like the autosuspend_delay_ms files are 
being set correctly:

http://www.pwsan.com/omap/testlogs/test_v3.16-rc7/20140729023831/pm/37xxevm/37xxevm_log.txt

By the way, it's not obvious from the logs, but there's a 'sleep 5' on the 
host between the autosuspend_delay_ms writes and the read of the 
pm_debug/count file...


- Paul
