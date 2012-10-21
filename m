From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Sun, 21 Oct 2012 17:06:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210211704170.26128@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54549 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191Ab2JURG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Oct 2012 13:06:28 -0400
In-Reply-To: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Sat, 20 Oct 2012, Paul Walmsley wrote:

> Here are some basic OMAP test results for Linux v3.7-rc2.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/

...

> Failing tests: needing investigation
> ------------------------------------
> 
> PM tests:
> 
> * 37xx EVM: CORE not entering dynamic off-idle
>   - Cause unknown; dynamic retention-idle seems to work; system suspend to 
>     off works

Just confirmed that this longstanding bug affects both MMC root and NFS 
root.


- Paul
