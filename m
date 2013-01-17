From: Michal Bachraty <michal.bachraty@gmail.com>
Subject: Re: [PATCH] am33xx: cpsw: default to ethernet hwaddr from efuse if not defined in dt
Date: Thu, 17 Jan 2013 15:14:20 +0000 (UTC)
Message-ID: <loom.20130117T105358-639@post.gmane.org>
References: <1358370073-32545-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49764 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755593Ab3AQPTx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jan 2013 10:19:53 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1TvrG8-0006we-HX
	for linux-omap@vger.kernel.org; Thu, 17 Jan 2013 16:20:04 +0100
Received: from dial-95-105-156-13-orange.orange.sk ([95.105.156.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 17 Jan 2013 16:20:04 +0100
Received: from michal.bachraty by dial-95-105-156-13-orange.orange.sk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 17 Jan 2013 16:20:04 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hi Peter,

I made changes to cpsw driver two weeks ago, which add support for reading 
MAC address from CPU and also I posted it to review. 
You can find patch here : https://patchwork.kernel.org/patch/1966481/ 
I will create updated patch next week, depended on reactions. Can you try 
that patch? I'll be glad to hear your 
opinion.

Michal




