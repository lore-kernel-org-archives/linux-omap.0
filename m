From: Viktor Gal <wiking@maeth.com>
Subject: BRIDGE: DSP-DMA copy failure
Date: Sat, 8 Nov 2008 17:04:51 +0100
Message-ID: <BC7FE67E-F469-4D08-A3DF-F8EF66709E73@maeth.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from info2k1.hu ([78.24.191.128]:59172 "EHLO mail.info2k1.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562AbYKHQ2T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 8 Nov 2008 11:28:19 -0500
Received: from 91.83.9.120.pool.invitel.hu ([91.83.9.120] helo=[192.168.1.173])
	by mail.info2k1.hu with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63 (FreeBSD))
	(envelope-from <wiking@maeth.com>)
	id 1KyqJs-0004OL-Rn
	for linux-omap@vger.kernel.org; Sat, 08 Nov 2008 17:05:52 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

::: i'm trying to use the strmcpy example with option 1, aka 'dsp- 
copy', but i get the following error:

./strmcopy.out 1 a b
Data streaming using DSP-DMA transport.
DSP device detected !!
DSPProcessor_Attach succeeded.
DSPNode_Allocate succeeded.
DSPNode_Connect failed. Status = 0x8000803a
DSPNode_Terminate failed: 0x8000801b
DSPNode_Delete succeeded.
DSPProcessor_Detach succeeded.

I've loaded the bridgedriver module with GT_str="**=01234567"  
argument, the logs can be found here:
http://categorizer.tmit.bme.hu/~wiking/strmcpy-dsp-dma-debug.txt

::: when i try to use 'proc-copy' option the strmcpy just works fine.

::: i was using using the http://4869037.web.fc2.com/tidspbridge-20081021.tgz 
  patch-set, but as far as i can see, there's really not much  
difference to the tidspbridge-20081107.tgz patch-set that was released  
yesterday.

any ideas?

regards,
viktor
