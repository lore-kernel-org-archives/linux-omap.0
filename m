From: Mike Rapoport <mike@compulab.co.il>
Subject: How to put TWL/TPS into sleep?
Date: Thu, 21 Jan 2010 13:45:38 +0200
Message-ID: <4B583E62.80603@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:56317 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700Ab0AULqF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jan 2010 06:46:05 -0500
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1NXvUB-00049s-1a
	for linux-omap@vger.kernel.org; Thu, 21 Jan 2010 05:46:03 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id DC5279A034F
	for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 13:46:01 +0200 (IST)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
	by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WaLfwF4yBe39 for <linux-omap@vger.kernel.org>;
	Thu, 21 Jan 2010 13:46:01 +0200 (IST)
Received: from [10.1.1.77] (droid.compulab.local [10.1.1.77])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id AA8DA9A0313
	for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 13:46:01 +0200 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,
I'm trying to achieve maximal power savings on omap3 based system with
TPS65930 PMIC using twl4030_script and twl4030_resconfig. I've tried
different resource mappings and different command sequences in the
sleep/wakeup scripts by to no avail. Moreover, with some resource
definitions and sleep/wakeup scripts the system behaves in a weird ways,
e.g. does not properly respond to hard resets.
Most probably my resource remapping and command sequences are wrong and
this is the reason for system misbehavior.

However, several things are completely unclear to me:
* Does TPS/TWL have defaults for sleep-on and sleep-off transitions?
* What would happen if nSLEEP1 would go low/high and there is no
sleep/wakeup sequence programmed?
* If I have a sleep sequence that disables some power resources, what
would be the state of the other resources?

I've read the TPS TRM several times to now and I still got now clue
about what's going on there :(


-- 
Sincerely yours,
Mike.
