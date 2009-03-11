From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/2] OMAP: McBSP: Do not enable or disable clocks on
 failed path
Date: Wed, 11 Mar 2009 13:03:16 +0200
Message-ID: <20090311130316.fb9ef9c1.jarkko.nikula@nokia.com>
References: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
	<12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
	<1236582316453-git-send-email-ext-eero.nurkkala@nokia.com>
	<20090310163027.5444259e.jarkko.nikula@nokia.com>
	<1FFEF31EBAA4F64B80D33027D4297760037BE5F663@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48605 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbZCKLDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 07:03:11 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2BB2kxH023945
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 13:03:00 +0200
In-Reply-To: <1FFEF31EBAA4F64B80D33027D4297760037BE5F663@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 10 Mar 2009 19:43:40 +0100
"Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
wrote:

> Good comment... why do I always do everything in such a hurry, without
> thinking any =) 
> Either that or leave clock disabling within the spin_lock covered
> code? (probably risky business)
> 
Didn't check any deeply can clk_disable sleep in any case but anyway
there is no need to cover it with spinlock so better to not hold the
lock while disabling.


Jarkko
