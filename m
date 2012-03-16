From: Thomas Klute <thomas2.klute@uni-dortmund.de>
Subject: smsc911x on Gumstix Overo/Tobi doesn't work
Date: Fri, 16 Mar 2012 12:32:37 +0100
Message-ID: <4F6324D5.9010106@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:57897 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758693Ab2CPMFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 08:05:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have trouble getting the Ethernet port on a Gumstix Overo with Tobi
expansion board to work with current kernel versions. With the latest
commit from linux-omap git (b8fe1781ec8bed5e086691a827a6ee11facec2aa),
the output from loading the smsc911x driver is as follows:

du14:~# modprobe smsc911x
[  254.843811] smsc911x: Driver version 2008-10-21
[  254.854553] smsc911x: Driver version 2008-10-21
[  254.859588] _regulator_get: smsc911x.1 supply vdd33a not found, using
dummy regulator
[  254.868377] _regulator_get: smsc911x.1 supply vddvario not found,
using dummy regulator

"ip link show" does not show any available Ethernet port.

I know there has been some trouble with changes around smsc911x
regulator support and Gumstix Overo in particular. Am I just missing the
right regulator in my kernel config or is this a bug? I can test patches
in the latter case.

Regards,
Thomas Klute
