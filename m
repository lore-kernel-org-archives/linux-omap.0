From: "pramod gurav" <pramodforum@gmail.com>
Subject: bluetooth GPIO on logic zoom omap3430 (labrador) board
Date: Thu, 17 Jul 2008 18:31:15 +0530
Message-ID: <f502236f0807170601w6ec1b260sd2827fc8651fce03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.237]:4909 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbYGQNBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 09:01:18 -0400
Received: by qb-out-0506.google.com with SMTP id p36so7432970qba.17
        for <linux-omap@vger.kernel.org>; Thu, 17 Jul 2008 06:01:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All
I have a omap3430 logic zoom board.
I want to configure bluetooth on it(BRF6300) which will interfaced to UART2.
I gone through the schematics and could find that the BT_SHUTDOWN is
controlled through GPIO.8 coming from TWL4030.
Is that wright? I tried using that GPIO but the hci interface did not respond.
I am using linux-2.6.24 with all bluetooth kernel support.
What is correct GPIO to BT_SHUTDOWN.

Reply is much awaited.
Thanks for time and consideration.


Pramod
