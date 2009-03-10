From: david.hagood@gmail.com
Subject: What did omap2_disp_get_dss morph into?
Date: Tue, 10 Mar 2009 15:32:19 -0500 (CDT)
Message-ID: <94550a837462d3a60453cb4c0ba075e3.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:45397 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbZCJUc0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 16:32:26 -0400
Received: by ewy25 with SMTP id 25so1419513ewy.37
        for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2009 13:32:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id D54DFC7B8014
	for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2009 15:32:19 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am trying to get the TI accelerated video driver to build against the
current DSS2 kernel image, and I think I am this close || to getting it to
go, but I am missing a pair of functions: omap2_disp_get_dss and
omap2_disp_put_dss.

Obviously, they've changed into something else - what did they morph into?


