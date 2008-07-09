From: "Ashish Bijlani" <ashish.bijlani@gmail.com>
Subject: initial frame buffer console
Date: Wed, 9 Jul 2008 00:25:31 -0500
Message-ID: <ec55b17e0807082225n6bbbcc10t2963323164821b90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:17260 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYGIFZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2008 01:25:31 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3433050rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Jul 2008 22:25:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm working with N810. I couldn't get serial port working and want to
have initial kernel boot msgs on clcd over fbcon. Can somebody guide
me how to have initial fbcon for kernel boot messages? I want to
provide minimal frame buffer support may be using internal 640k sram.

Thanks,
Ashish
