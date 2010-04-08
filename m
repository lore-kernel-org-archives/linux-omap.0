From: "Arce, Abraham" <x0066660@ti.com>
Subject: OMAP4 keypad driver
Date: Wed, 7 Apr 2010 20:16:08 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043CB21399@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55948 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab0DHBQK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 21:16:10 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o381G9Jv003409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 20:16:09 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o381G9B0003013
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 20:16:09 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o381G94A027215
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 20:16:09 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I need some help to figure out the best way to incorporate omap4 keypad in linux omap.

First approach, I have a patch that creates a new file, omap4-keypad.c with the following implementations:

 - Based on matrix keypac logic
 - Using hwmod framework
 - Using threaded irq

Second approach, to change existing omap-keypad.c to matrix keypad

Not clear on the path to follow... Thanks for your comments.

Best Regards
Abraham
