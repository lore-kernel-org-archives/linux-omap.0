From: Philip Balister <philip@balister.org>
Subject: Change in mmap driver performance from 2..6.38 to 2.6.39
Date: Mon, 11 Jul 2011 10:21:49 -0400
Message-ID: <4E1B06FD.5090107@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:32768 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753997Ab1GKO2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 10:28:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have a device drier that uses a mmap'd section of memory to expose dma 
buffers to user space. 
(https://github.com/balister/linux-omap-philip/blob/e100-2.6.38/drivers/misc/usrp_e.c).

I have it running on the 2.6.38 and 2.6.39 kernel, but it looks like 
read performance is much slower in the .39 version than the .28 version.

Does anyone know what changed between these two kernel versions and how 
it might fix it?

Thanks,

Philip
