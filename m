From: Peter Barada <peter.barada@logicpd.com>
Subject: How to keep DM37x GPIO_162 high during off-mode
Date: Tue, 9 Jul 2013 10:51:55 -0400
Message-ID: <51DC238B.2060103@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.logicpd.com ([174.46.170.145]:39443 "HELO
	barracuda.logicpd.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753925Ab3GIPHm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 11:07:42 -0400
Received: from EDPR-EX01.logicpd.com (edpr-ex01.logicpd.com [10.1.18.124]) by barracuda.logicpd.com with ESMTP id PdqsiEfGddQ43TYq (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <linux-omap@vger.kernel.org>; Tue, 09 Jul 2013 09:52:09 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter Barada <peter.barada@logicpd.com>

I'm working with a 3.0.8 kernel in Android ICS and have run into a
problem using wl12xx bluetooth after a suspend/resume cycle.

GPIO_162 in this design is connected to the BT_EN pin of the wl12xx and
needs to be held high to keep the bluetooth core from resetting while
the DM37x goes into off mode.

I've tried muxing the pin using OMAP_PIN_OUTPUT |
OMAP_PIN_OFF_OUTPUT_HIGH, but the pin goes low when the chip goes into
off mode.  If I disable off mode via "echo 0 >
/sys/kernel/debug/pm_debug/enable_off_mode" the pin remains high while
the chip goes into retention and the bluetooth core works after resume.

Any ideas why GPIO_162 would go low during suspend to off mode?

Note I can't move to a newer kernel due to scheduling constraints.

Thanks in advance!

-- 
Peter Barada
peter.barada@logicpd.com

