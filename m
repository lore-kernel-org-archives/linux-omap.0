From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [RFC PATCH 0/2] omap-serial: A way to implement modem lines through
 GPIO
Date: Thu, 11 Aug 2011 15:46:53 -0400
Message-ID: <4E4431AD.4070305@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:53455 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab1HKTrA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 15:47:00 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1QrbDS-0006sr-25
	for linux-omap@vger.kernel.org; Thu, 11 Aug 2011 15:46:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

At least in the am3505/3517 CPUs, the built-in uarts only expose the=20
RX/TX/RTS/CTS signals. Other signals such as DTR/DSR/RI and DCD,
while very useful when controlling a modem, are not available.

My design has the above mentioned extra signals wired to GPIOs.=20
Controlling them through sysfs is possible, but not convenient as I
needed the standard serial port ioctls to work.

There did not seem to be anything in place to do this so I've come up=20
with the following two patches which I am using for now.

What do you think? Is there a simpler, more obvious solution?
Did anyone attempt doing something to attain a similar goal in the past=
?

Best regards,
Rapha=EBl Ass=E9nat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
