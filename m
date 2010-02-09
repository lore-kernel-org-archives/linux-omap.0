From: "Premi, Sanjeev" <premi@ti.com>
Subject: omap3evm: Doesn't boot at 4fa42e46
Date: Tue, 9 Feb 2010 21:01:53 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E263A671@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45594 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255Ab0BIPb6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 10:31:58 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o19FVt69031744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 9 Feb 2010 09:31:58 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o19FVtUD000129
	for <linux-omap@vger.kernel.org>; Tue, 9 Feb 2010 21:01:55 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

Just updated my repo to the commit:

commit 4fa42e4679324b0e3c54fb509535eea3923ccb63
Merge: e599f12 c446167
Author: Tony Lindgren <tony@atomide.com>
Date:   Thu Feb 4 20:07:44 2010 -0800

The kernel builds fine; but doesn't boot on the OMAP3EVM.

I have been able to trace the code until rest_init(); but will need to restart debugging.
There seems to be an exception during execution.

Will continue to dig further. This is just an FYI.

Best regards,
Sanjeev
