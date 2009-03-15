From: InKi Dae <daeinki@gmail.com>
Subject: I have some questions about DSS.
Date: Sun, 15 Mar 2009 16:13:09 +0900
Message-ID: <90b950fc0903150013u791987b9ifdae04bd7628922d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:16460 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbZCOHNM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 03:13:12 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1427137wah.21
        for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 00:13:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org

I am trying to draw 720P streamming images decoded on LCD.
I really wonder about that.

In case of OMAP34XX, only video1 and video2 layer support color space
conversion, scaling, rotation.
I think that ways using these features are like below.

1. Application -> video1 or 2 device node -> V4L2 Interface -> DSS
Library -> LCD Panel or Digital output.
2. Application -> fb1 or 2 device node -> omafb driver -> DSS Library
-> LCD Panel or Digital output.

Are all of the 1 and 2 case possible to draw 720P streamming images on
LCD Panel in real-time ?
If the case of 1 is impossible, why impossible, and what is the reason
implementing like case 2 ?

If possible, What is the way better ?
Could you please tell me you know and you think ?

Thank you,
- InKi -
