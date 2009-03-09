From: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Subject: How to test regulator driver?
Date: Mon, 9 Mar 2009 20:32:55 +0530
Message-ID: <2ee9e08d0903090802u72426757m8de7669800b5e94b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:38789 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbZCIPDF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 11:03:05 -0400
Received: by qyk28 with SMTP id 28so1124473qyk.33
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2009 08:02:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP List <linux-omap@vger.kernel.org>

Hi,

I want to test my regulator driver by writing a small kernel module.
But I am a little confused as what should be passed as the first
argument of regulator_get(). How would the kernel module know about
the device pointer that needs to be passed to the _get function?

Thanks,
Anuj Aggarwal
