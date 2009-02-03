From: iqbal shareef <iqbalshareef.list@gmail.com>
Subject: Exclusive use of OMAP3 TI ISP Resizer
Date: Tue, 3 Feb 2009 20:36:52 +0530
Message-ID: <c6a924220902030706t54cf015aq802d897c584e17dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:49867 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbZBCPGy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 10:06:54 -0500
Received: by ewy14 with SMTP id 14so2473856ewy.13
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 07:06:53 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

Current TI ISP implementation doesn't allow exclusive use of Resizer,
I mean CCDC->Resizer.

Any specific reason why CCDC->Preview->Resizer path has been taken?
Please share the background of this decision.

My sensor gives only YUV data, but the Preview pipeline is happy only
with RAW Bayer.
Is this a hardware limitation?

Thanks
Iqbal
