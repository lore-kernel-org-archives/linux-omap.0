From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] twl4030_wdt: Disable watchdog while probing
Date: Wed, 19 May 2010 18:40:31 +0200
Message-ID: <20100519164031.GJ4008@infomag.iguana.be>
References: <7fcfe2bbdbad2e7c330c219fa1e27497a5fd0f89.1274094577.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:9578 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752506Ab0ESQkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 12:40:33 -0400
Content-Disposition: inline
In-Reply-To: <7fcfe2bbdbad2e7c330c219fa1e27497a5fd0f89.1274094577.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org, timo.t.kokkonen@nokia.com, wim@iguana.be

Hi Ameya,

> If we are not able to register then it is better to have watchdog in disabled
> state than noticing a system reboot.
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>

This was added in my linux-2.6-watchdog-next tree.
Will be sent to Linus for mainline inclusion in a couple of days.

Kind regards,
Wim.

