From: Orjan Friberg <of@flatfrog.com>
Subject: Re: Spurious ECC errors with mtd_subpagetest (OMAP3, NAND)
Date: Mon, 5 Mar 2012 09:13:28 +0100
Message-ID: <4F5475A8.3050600@flatfrog.com>
References: <4F50F2AB.10209@flatfrog.com>  <CANOLnOM6X=29r7_aMs=z4eiDtw0kvWZ-jSeds_NO0KdZ3E8Ouw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:4399
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755989Ab2CEINh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 03:13:37 -0500
In-Reply-To: <CANOLnOM6X=29r7_aMs=z4eiDtw0kvWZ-jSeds_NO0KdZ3E8Ouw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 03/02/2012 06:17 PM, Grazvydas Ignotas wrote:
> IIRC NAND in mainline was broken for very long time on OMAP3, I think
> it was only fixed in 2.6.39.1.

That seems to be the case; the 2.6.39.1 diff contains the OMAP NAND sub 
page write fix (applied locally).


Anyone else who can testify on the "volatile-ness" of NAND ECC errors?

I.e., are they expected to be more persistent?


Thanks,
Orjan

-- 
Orjan Friberg
FlatFrog Laboratories AB
