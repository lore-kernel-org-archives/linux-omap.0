From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [Resend] [PATCH 0/3] OMAP2EVM : Touchscreen driver support
Date: Thu, 25 Sep 2008 11:01:35 +0530
Message-ID: <dfeb90390809242231w1c7c5143jee3b54f03ee79415@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:15926 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbYIYFbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 01:31:36 -0400
Received: by rv-out-0506.google.com with SMTP id k40so289524rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 22:31:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Please ignore all the previous patches I have send.
I did some modifications and here are the final series.

Patch 1 : Adds mux settings required for mspi1 and gpio_85.
Patch 2 : Adds support for ads7846 touchscreen driver on omap2evm.
Patch 3 : Updates the defconfig of omap2evm board with mspi.

Now I am using cross-platform GPIO calls instead of the older
OMAP-specific ones.

Thanks,
Arun
