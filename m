From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Using DEBUG_LL?
Date: Fri, 26 Feb 2010 08:33:29 -0600
Message-ID: <A24693684029E5489D1D202277BE894453A4FBDB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35606 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964839Ab0BZOdb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 09:33:31 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hi,

Wit the current master branch, I tried enabling DEBUG_LL, and EARLY_PRINTK options,
but I can't see the LL output as usual ("<#>..." kind of thing) on my 3630SDP.

Is there a patch to enable it after the serial cleanup patches?

Regards,
Sergio
