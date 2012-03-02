From: Orjan Friberg <of@flatfrog.com>
Subject: Re: Spurious ECC errors with mtd_subpagetest (OMAP3, NAND)
Date: Fri, 2 Mar 2012 17:42:10 +0100
Message-ID: <4F50F862.5030305@flatfrog.com>
References: <4F50F2AB.10209@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:56714
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752020Ab2CBQmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 11:42:13 -0500
In-Reply-To: <4F50F2AB.10209@flatfrog.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 03/02/2012 05:17 PM, Orjan Friberg wrote:
> Hi,
>
> When running the mtd_subpagetest I'm seeing more or less spurious ECC
> corrections.  I.e., one round may show 4 corrections and the next will
> show 7, only some of which are the same as the previous 4.

FWIW

* I'm seeing the same behaviour (i.e. transient ECC errors) when doing 
nanddump on a partition.
* mtd_oobtest fails on "verify failed at <varying address>", and "read 
past end of device".


-- 
Orjan Friberg
FlatFrog Laboratories AB
