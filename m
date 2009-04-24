From: Kalle Valo <kalle.valo@iki.fi>
Subject: n800 high idle power consumption
Date: Fri, 24 Apr 2009 07:53:44 +0300
Message-ID: <877i1aejon.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:42665 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbZDXExs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 00:53:48 -0400
Received: by bwz7 with SMTP id 7so899483bwz.37
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 21:53:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello all,

I was testing 2.6.30-rc3-omap1 on n800 and noticed that idle power
consumption is very high, ten times compared to a 2.6.29 I tested few
weeks back. I'm guessing that CPU doesn't sleep at all.

Is this a regression? How should I debug this further?

-- 
Kalle Valo
