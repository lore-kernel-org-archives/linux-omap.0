From: Mike Rapoport <mike@compulab.co.il>
Subject: pm_debug/voltage_off_while_idle has gone?
Date: Wed, 23 Jun 2010 15:24:17 +0300
Message-ID: <4C21FCF1.20600@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:50361 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845Ab0FWMZf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jun 2010 08:25:35 -0400
Received: from mail.linux-boards.com ([192.114.83.142] helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1ORP1K-0007O1-HQ
	for linux-omap@vger.kernel.org; Wed, 23 Jun 2010 07:25:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id B1C7A9A002E
	for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 15:25:33 +0300 (IDT)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
	by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4xaQMQVyfkXD for <linux-omap@vger.kernel.org>;
	Wed, 23 Jun 2010 15:25:33 +0300 (IDT)
Received: from [10.1.1.77] (droid.compulab.local [10.1.1.77])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 8BF3D9A002B
	for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 15:25:33 +0300 (IDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

There used to be 'voltage_off_while_idle' attribute in the PM-enabled kernels 
that allowed to put PMIC into OFF mode.
In the current tip of the linux-omap-pm tree this attribute seem to be gone
Is there possibility to make PMIC enter the OFF mode when suspending to RAM?


-- 
Sincerely yours,
Mike.
