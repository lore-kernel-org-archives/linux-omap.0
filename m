From: "Budhee Jamaich" <budheej@gmail.com>
Subject: powering up the mmc controller on 3430
Date: Sun, 7 Sep 2008 22:19:40 +0300
Message-ID: <57314e840809071219w71ec6e40ja6a8bf8e05a876c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:50001 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbYIGTTl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 15:19:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1266875wfd.4
        for <linux-omap@vger.kernel.org>; Sun, 07 Sep 2008 12:19:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello everyone,

I am upgrading an mmc driver we have from an ancient kernel version
(2.6.14) to a not-so-new (2.6.24).

I have one problem - in 2.6.14 we used the enable_mmc_power function,
which is completely gone in 2.6.24, and i can't seem to find any
reasonable replacement. could you please assist me how can I power up
the mmc controller in 2.6.24 ?

(we have legacy reasons for not using the in-tree mmc driver, which we
will one day resolve, but now i really need to power up the controller
from within our driver..)

Thank you so much
Budhee.
