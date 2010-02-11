From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Moving board patches from DSS2 to linux-omap
Date: Thu, 11 Feb 2010 12:29:45 +0200
Message-ID: <1265884185.2433.239.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45618 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab0BKK1T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 05:27:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, mike@compulab.co.il
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

As discussed previously, board file changes in DSS2 tree cause conflicts
with linux-omap easily. There are currently three board file patches in
DSS2's for-next branch:

722a97e4594b2041bbf18d95a913ba6dfaca87f2 omap3: cm-t35: add DSS2 display support
7a56267e775e469c64521179ccc958c8bb661dbf OMAP: AM3517: Enable DSS2 for AM3517EVM board
40e4e67c6dabcb9897b6823cce2297d6c3e78bbd OMAP: Enable DSS2 for OMAP3EVM board

The problem here is of course that DSS2 tree may contain unmerged panel
drivers, and those board file changes try to use these new panel
drivers.

Now, I don't think there's a perfect solution for this, but I think a
working solution would be to put all board file changes to linux-omap
tree (with the exception of some rare changes that don't compile without
new DSS2 patches), but leave the kernel config unchanged.

This way the board file contains references to new panel drivers, but as
DSS2 nor the panel drivers are enabled in the Kconfig, the board file
code is not used and everything should work as before.

Then either I can have Kconfig patches in my tree, which are less likely
to conflict, or the Kconfig changes can be done after both linux-omap
and dss2 patches have been merged.

How does this sound?

 Tomi

Ps. I haven't actually tried those board file patches on top of
linux-omap, but I don't see anything there that would cause compilation
to fail.


