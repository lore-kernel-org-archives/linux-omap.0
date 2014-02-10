From: Nishanth Menon <nm@ti.com>
Subject: Re: OMAP baseline test results for v3.14-rc1
Date: Mon, 10 Feb 2014 12:00:05 -0600
Message-ID: <52F913A5.7040207@ti.com>
References: <alpine.DEB.2.02.1402101733340.30435@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49236 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435AbaBJSAk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Feb 2014 13:00:40 -0500
In-Reply-To: <alpine.DEB.2.02.1402101733340.30435@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On 02/10/2014 11:48 AM, Paul Walmsley wrote:
[...]
> Boot to userspace:
>     FAIL ( 1/10): 2430sdp

Comparing boot logs I reported
http://marc.info/?l=linux-omap&m=139144642318949&w=2 Vs
http://www.pwsan.com/omap/testlogs/test_v3.14-rc1/20140210035354/boot/2430sdp/2430sdp_log.txt

I see that bootargs are different -> I was attempting to boot sdp2430
with nfs boot which seems to work fine for me, I believe you are
attempting mmc boot here.


-- 
Regards,
Nishanth Menon
