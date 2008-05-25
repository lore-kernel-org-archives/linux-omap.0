From: Radoslaw Szkodzinski <astralstorm@gen2.org>
Subject: 2.6.26-rc3-omap vs N810 and Xomap
Date: Sun, 25 May 2008 20:38:55 +0200
Message-ID: <20080525203855.2f6037f6@gen2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gen2.org ([194.181.7.159]:38619 "EHLO gen2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755624AbYEYSsN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 25 May 2008 14:48:13 -0400
Received: from localhost (host-89-228-135-37.gorzow.mm.pl [89.228.135.37])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by gen2.org (Postfix) with ESMTP id F07011214063
	for <linux-omap@vger.kernel.org>; Sun, 25 May 2008 20:38:59 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I've managed to get 2.6.26-rc3-omap booting (was quite easy actually).
Now I hit a road block - I get everything to start, it boots nicely
(checked with SSH), but fails to display anything except a white screen.
Looks like Xomap can't (re)init framebuffer, or focus isn't transferred
to it.
Any known possible reasons?

AstralStorm
