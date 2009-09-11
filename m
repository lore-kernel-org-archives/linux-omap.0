From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: V3 - mmc and omap_hsmmc patches
Date: Fri, 11 Sep 2009 10:20:45 +0300
Message-ID: <4AA9FA4D.7060701@nokia.com>
References: <004e01ca3239$14eb9ab0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28589 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbZIKHUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 03:20:50 -0400
In-Reply-To: <004e01ca3239$14eb9ab0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 'Matt Fleming' <matt@console-pimps.org>

Madhusudhan wrote:
> Hi Adrian,
> 
>> [PATCH V3 0/30] mmc and omap_hsmmc patches
> 
> What is the reason for V3? What is the difference between V2 and V3 series?

The reason for V3 is that the SD-only and MMC-only host capability patches were
not wanted.

The difference is that patches originally numbered 0007 and 0027 were dropped
and the rest re-rolled.
i.e.

	Subject: [PATCH V2 7/32] mmc: add host capabilities for SD only and MMC only
	File: 0007-mmc-add-host-capabilities-for-SD-only-and-MMC-only.patch

	Subject: [PATCH V2 27/32] omap_hsmmc: pass host capabilities for SD only and MMC only
	File: 0027-omap_hsmmc-pass-host-capabilities-for-SD-only-and-M.patch

were removed.


