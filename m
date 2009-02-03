From: Remith Ravi <remith@mistralsolutions.com>
Subject: USB and SD performance issue
Date: Tue, 3 Feb 2009 16:46:03 +0530
Message-ID: <814dfab70902030316u36fd4912n55b5fa98571cc88c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:60198 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbZBCLQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 06:16:05 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1023134tic.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 03:16:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Recently I have done a performance comparison of OMAP3 'USB OTG Host'
and 'SD' drivers on different Linux Kernels.
The performance of latest git kernel is less comparing to 2.6.22 TI kernel.
Could some one please explain me what cause this performance difference?

The performance is calculated by doing data transfer between RAM and
the storage device (using 'time' command).

The performance details are given below.

1) 2.6.29-rc2 kernel
USB OTG (Host)         Read (4.2 MB/s)		Write (2.6 MB/s)	
SD Card                     Read (3.88 MB/s)		Write (3.1 MB/s)

2) 2.6.28 kernel
USB OTG (Host)         error		                error	
SD Card                     Read  (4.2 MB/s)		Write (3.27 MB/s)

3) 2.6.22 TI kernel
USB OTG (Host)         Read (5.4MB/s)		Write (6.14MB/s)	
SD Card                      Read (6.7MB/s)		Write (6.43MB/s)

Regards,
Remith
