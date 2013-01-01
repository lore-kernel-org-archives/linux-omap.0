From: <Madhusudhan.Gowda@elektrobit.com>
Subject: Querry on UART wakeup on Linux 3.8-rc1
Date: Tue, 1 Jan 2013 22:07:52 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA803E743F9@fioues07.ebgroup.elektrobit.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpgw2fi.elektrobit.com ([194.136.18.129]:57401 "EHLO
	smtpgw1fi.elektrobit.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752408Ab3AAUH6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jan 2013 15:07:58 -0500
Received: from encgw2fi.ebgroup.elektrobit.com (encgw2fi.ebgroup.elektrobit.com [172.16.0.99])
	by smtpgw1fi.elektrobit.com (8.13.8/8.13.8) with ESMTP id r01K7uSM016315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-omap@vger.kernel.org>; Tue, 1 Jan 2013 22:07:56 +0200
Received: from fioues07.ebgroup.elektrobit.com (fioues07.ebgroup.elektrobit.com [172.16.33.117])
	by encgw2fi.ebgroup.elektrobit.com (Postfix) with ESMTP
	for <linux-omap@vger.kernel.org>; Tue,  1 Jan 2013 22:07:56 +0200 (EET)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I tried to wakeup OMAP430 ES2.1 Panda from static suspend retention
using console uart2, it doesn't wakeup.
But could configure GPIO_121 button to wake up from retention fine.

On the serial uart side I have manually enabled wakeup by
echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup

I could see the wakeup enable bit (1<<14)  of  uart irrx pad register is
being set properly before it does static suspend fine.

Should I need to do any more thing to get it work?

Thanks,
Gowda
