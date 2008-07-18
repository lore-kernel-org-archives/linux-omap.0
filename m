From: "pramod gurav" <pramodforum@gmail.com>
Subject: Bluetooth SHUTDOWN GPIO on omap3430 labrador
Date: Fri, 18 Jul 2008 15:20:35 +0530
Message-ID: <f502236f0807180250g67fe94e1ue6e9e3485cd71d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.231]:53049 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbYGRJuh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 05:50:37 -0400
Received: by qb-out-0506.google.com with SMTP id p36so1239460qba.17
        for <linux-omap@vger.kernel.org>; Fri, 18 Jul 2008 02:50:36 -0700 (PDT)
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
