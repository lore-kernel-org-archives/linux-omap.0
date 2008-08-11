From: "halli manjunatha" <hallimanju@gmail.com>
Subject: Problem in McSPI (TXS timed out)
Date: Mon, 11 Aug 2008 09:30:15 +0530
Message-ID: <ca6476860808102100o1f63af04y426c68a9be8e1b29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:4326 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbYHKEAQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 00:00:16 -0400
Received: by yx-out-2324.google.com with SMTP id 8so611227yxm.1
        for <linux-omap@vger.kernel.org>; Sun, 10 Aug 2008 21:00:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello All,
              I am working on OMAP3430 with 2.6.24 kernel, In that i
am using McSPI2 for initializing the LCD and serializer, but while
booting am getting the following messages

 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
 In mcspi wakeup callback
display spi2.0: TXS timed out
timeout waiting for frame-done interrupt
omap24xxfb: Options "<NULL>"
omap24xxfb: invalid default video mode


I am not getting where exactly i am doing wrong, please suggest me,



--
Regards
Manjunatha H
