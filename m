From: ext-eero.nurkkala@nokia.com
Subject: [PATCH 0/3] McBSP: Provide functions for ASoC frame syncronization
Date: Tue, 13 Jan 2009 09:52:12 +0200
Message-ID: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32260 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbZAMHyl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 02:54:41 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0D7sXBF021326
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 01:54:39 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

McBSP along with ASoC has currently an annoying 
feature of switching L and R channels at random.
Perceive this with aplay, having two mono waves
sent to the different channels:
aplay -fdat -c2 -I Side_Left.wav Front_Center.wav
One acknowledges that sometimes L channel is in
place of L, but often times R channel is in place
of L.

This set of patches fixed this problem.
