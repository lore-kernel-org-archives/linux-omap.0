From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: N8x0 to mainline patches
Date: Mon, 13 Jul 2009 09:49:55 -0500
Message-ID: <200907130950.09887.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wsip-70-184-212-11.om.om.cox.net ([70.184.212.11]:45155 "EHLO
	hachi.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846AbZGMPAO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jul 2009 11:00:14 -0400
Received: from tsuruki.localnet (unknown [IPv6:2002:46bb:1a76:0:20e:a6ff:fec4:4e5d])
	by hachi.dashjr.org (Postfix) with ESMTP id 058678B47E4
	for <linux-omap@vger.kernel.org>; Mon, 13 Jul 2009 14:50:14 +0000 (UTC)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I noticed that the patch adding board-n8x0.c seems to be much smaller than the 
older one used in Linux-OMAP. In particular, it lacks the keymaps and such. 
Are those somewhere else now? Was the Linux-OMAP keyboard bug taken into 
consideration for the new keyboard config struct?

Luke
