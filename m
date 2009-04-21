From: twebb <taliaferro62@gmail.com>
Subject: LCD display orientation on omap
Date: Tue, 21 Apr 2009 09:33:29 -0400
Message-ID: <dbdb2ea60904210633w32f773famfad9f0b2258e849f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:15381 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819AbZDUNda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 09:33:30 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1103690yxj.1
        for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 06:33:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

I'm working on an omap platform that has an LCD display which is
native landscape.  What can I do to make the application come up
initially in portrait mode?  Is this something that can be done in the
omap FB driver, or is there some other preferred mechanism?

Thanks,
twebb
