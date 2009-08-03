From: Ben Goska <goskab@onid.oregonstate.edu>
Subject: arch/arm/mach-omap* organization
Date: Mon, 03 Aug 2009 15:23:36 -0700
Message-ID: <4A776368.1010503@onid.oregonstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.oregonstate.edu ([128.193.15.36]:46125 "EHLO
	smtp2.oregonstate.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZHCWxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 18:53:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.oregonstate.edu (Postfix) with ESMTP id 595563C592
	for <linux-omap@vger.kernel.org>; Mon,  3 Aug 2009 15:23:37 -0700 (PDT)
Received: from smtp2.oregonstate.edu ([127.0.0.1])
	by localhost (smtp.oregonstate.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kTCqcYBa-YaB for <linux-omap@vger.kernel.org>;
	Mon,  3 Aug 2009 15:23:37 -0700 (PDT)
Received: from [128.193.61.28] (128-193-61-28.public.oregonstate.edu [128.193.61.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp2.oregonstate.edu (Postfix) with ESMTP id 349703C57E
	for <linux-omap@vger.kernel.org>; Mon,  3 Aug 2009 15:23:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Is there a reason why omap2, omap3, and now omap4 files are all packed 
into the mach-omap2 directory?

It seems like it would make more sense for each omap version to have 
it's own directory.

-Ben Goska
