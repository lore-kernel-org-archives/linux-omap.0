From: "Lohithakshan, Ranjith" <ranjithl@ti.com>
Subject: Android Suspend Blockers
Date: Sat, 15 May 2010 14:03:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C558B389@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40648 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861Ab0EOIdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 May 2010 04:33:47 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4F8XhP5002857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 15 May 2010 03:33:46 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4F8XhwA014713
	for <linux-omap@vger.kernel.org>; Sat, 15 May 2010 14:03:43 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Quite a lot of debate on linux-pm whether to accept he Android suspend blocker support (locally called wakelocks in Android) to the mainline. It appears that the linux-omap camp is not all for it.

Android handles the PM slightly differently and they have used wakelocks all over. The Android power driver and wakelock support were two of the main features that I had to pull in from Android repo on top of our 2.6.29 release when I experimented with Android.

You can go through the debate at (and sort by thread)

https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025179.html

Ranjith