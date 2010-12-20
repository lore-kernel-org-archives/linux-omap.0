From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Huge ubi or ubifs sync slowdown since 2.6.32
Date: Tue, 21 Dec 2010 11:36:22 +1300
Message-ID: <201012211136.22254.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:60960 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754457Ab0LTWg0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 17:36:26 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org


Hi All

I've been looking into a ubifs performance regression on linux-omap 2.6.37.

My test is pretty simple, copy a 2Mbyte file and sync.

# sync; date; cp 2Mbyte-file foo; sync; date

On 2.6.32 and earler, the time between the two dates was around 3 seconds.
On linux-omap master it is around 14 seconds. Ouch!

At first I thought the problem was due to changes in the OMAP nand drivers, 
but raw randwrite speed is actually a bit faster. This suggest the finger 
should be pointed at ubi or ubifs.

I then thought that perhaps the layout of my ubinized image might be a 
contributing factor so I erased the partition, ubiformatted and ubimkvoled. 
The problem persisted,

Any suggestions as to what might be broken or how to debug this deeper?

Thanks

Charles



