From: "chandru vijayashankar" <chandru.vijayshankar@gmail.com>
Subject: pad configuration register doubt
Date: Sun, 15 Jun 2008 19:16:37 +0530
Message-ID: <8a5399150806150646v4a194084laec0f3a78fad1413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.225]:51853 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473AbYFONqi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jun 2008 09:46:38 -0400
Received: by qb-out-0506.google.com with SMTP id p36so1978888qba.17
        for <linux-omap@vger.kernel.org>; Sun, 15 Jun 2008 06:46:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,
  In the arch/arm/mach-omap2/mux.c file. i have some doubts of the
structure omap34xx_pins. What is the difference between pullup/pulldown
selection and pullup enable bits in the pad  configuration register
of omap 3430 processor. any help on the different bits in the control
pad configuration register.  why and where they are used. what is the
meaning of input enable or offmode bits and why it is needed.

With Warm Regards,
 chandru
