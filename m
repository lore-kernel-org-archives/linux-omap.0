From: Somnt <er.somnt@gmail.com>
Subject: SDMA, RAM to RAM transfer issue
Date: Fri, 13 Jun 2008 10:34:36 +0900
Message-ID: <5b1a99070806121834o10ce0a6cxa2b8552d8e1a283c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:36477 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757620AbYFMBel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jun 2008 21:34:41 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2385958ywe.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Jun 2008 18:34:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi! All

I am new to OMAP3430,
I am trying to do DMA transfer from one Memory location to another on RAM.
First Scenario is
I am Allocating 1024bytes (KMALLOC) for both SRC & DEST
and after taking physical address (__pa) of allocated addresses I am
passing it to DMA tarnsfer.

in this case first 64bytes are not reflecting transfer in destination
(DST), rest are fine.

Second case:
I am doing everything else same but allocated size of memory is
X=(64+1024) bytes,
and passed address to DMA is X+64,
in this case eveything is fine, Transfer is complete for 1024bytes.

any body can please shed some light, what is wrong in my approach?
or why in first case tarnsffer is not reflected in first 64 bytes?
is it memory addressing issue or DMA setting issue.
I have tried with different channel but result is same.
Address returned by Kmalloc is on 32/64 byte boundary.

A quick reply will be appreciable!

with wishes
Somz
-
end
