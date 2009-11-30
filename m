From: Ashwin Bihari <abihari@gmail.com>
Subject: DSS2 Switch between multiple displays
Date: Mon, 30 Nov 2009 14:26:47 -0500
Message-ID: <1f11a5490911301126p1444f93dga1821a67479d0c7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:37720 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbZK3T0l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 14:26:41 -0500
Received: by gxk26 with SMTP id 26so1234840gxk.1
        for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 11:26:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

My system is going to have to support multiple display panels and
switch between them using runtime checks. I've got two displays
currently registered and confirmed with:

# cat displays
lcd e:1 u:1 t:0 h:480/2/2/41 v:272/2/6/10 p:10000 r:0 i:0
lcd e:0 u:1 t:0 h:480/2/2/41 v:800/2/6/10 p:10000 r:0 i:0

Short of adding a new module parameter for me to key off the
panel_name to make the choice, is there some other way already
implemented for me to indicate which display the DSS2 system should
use as the default display panel?

-- Ashwin
