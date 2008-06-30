From: "Arun KS" <getarunks@gmail.com>
Subject: [resend][PATCH 0/3] Adding ethernet support on omap2evm
Date: Mon, 30 Jun 2008 20:34:35 +0530
Message-ID: <dfeb90390806300804h6694c981h751ec9f4c5d5d832@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:43158 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbYF3PEh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 11:04:37 -0400
Received: by ti-out-0910.google.com with SMTP id b6so799175tic.23
        for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 08:04:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

The following set of patches add ethernet support for omap2evm
I have incorporated the comments form Tony and Felipe.

*  0001-OMAP2EVM-Adding-ethernet-support.patch
       This patch modifies the board files for supporting smc9115
*  0002-net-smc911x-Modify-driver-to-also-work-with-omap24xx.patch
       This patch modifies the driver files to add support for
omap24xx platforms
        I will be sent this patch to linux-netdev also.
*  0003-Added-ethernet-driver-support-in-defconfig.patch

Best Regards,
Arun KS
