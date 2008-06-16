From: "mohammed shareef" <mdshareef@gmail.com>
Subject: ppp on 2.6.18
Date: Mon, 16 Jun 2008 18:06:16 +0530
Message-ID: <a1d91fa0806160536r646577e2n7099431aa934a556@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:50519 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbYFPMgR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2008 08:36:17 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1608688tic.23
        for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 05:36:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>, linux-ppp@vger.kernel.org

Dear all,

i have enabled ppp services when configuring the kernel 2.6.18.

the kernel bootup  of omap5912 osk says this:

PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered

but when i type "pppd -h" in the osk console i get:

# pppd -h
-sh: pppd: not found

please help me in configuring ppp.
thank you,
Shareef
