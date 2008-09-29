From: "monte L" <montesnl987@gmail.com>
Subject: Power management in omap3430
Date: Mon, 29 Sep 2008 20:43:43 +0530
Message-ID: <cb629f950809290813x26df9a28v295aabfd50840c1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.234]:45643 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYI2PNp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 11:13:45 -0400
Received: by qb-out-0506.google.com with SMTP id f11so1492302qba.17
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 08:13:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I just got hold of omapzoom and am running linux from omapzoom site.

Since I am new to omap, request some guidance on power mgmt:

- Is OMAP PM interface from Paul the current power mgmt framework for omap3430?

- Does it work together with PM QoS or any other framework (I have
read Kevin's comments:
http://marc.info/?l=linux-omap&m=120962073813933&w=2) Is there an
update on this - will they co-exist?

My work involves porting few middleware and applications on to
OMAP3430 platform. I am seeking your help in how to go about handling
power management aspects, which are so elaborate in omap3.

Thanks for your time.

-Monte
