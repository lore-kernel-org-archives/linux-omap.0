From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: Fix for Zero sized arch/arm/mach-integrator/clock.h on distclean
Date: Mon, 26 Jan 2009 17:14:18 -0600
Message-ID: <A24693684029E5489D1D202277BE8944202A97C1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39658 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbZAZXO0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 18:14:26 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

I noticed that when doing distclean on the tree, I keep receiving a changed file when I request a distclean:

saaguirre@x0091359-linux:~/linux-omap-2.6$ git status
# On branch camera-submit-6-nokiafixes
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    arch/arm/mach-integrator/clock.h
#
no changes added to commit (use "git add" and/or "git commit -a")

I noticed that this is because a zero sized file existed in mainline, instead of being adequately deleted.

But I also noticed that there is a fix for this already by Andrew Price:

http://marc.info/?l=linux-kernel&m=123134235028543&w=2

Is it possible to pull this fix into the l-o tree?

Thanks and regards,
Sergio
