From: "Mohammed, Afzal" <afzal@ti.com>
Subject: Early prints on different UART's for same machine type
Date: Tue, 9 Aug 2011 11:26:17 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DF9E2C1@dbde02.ent.ti.com>
References: <mailman.7147.1312868034.20023.linux-arm-kernel@lists.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41880 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571Ab1HIF4Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 01:56:25 -0400
In-Reply-To: <mailman.7147.1312868034.20023.linux-arm-kernel@lists.infradead.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel-bounces@lists.infradead.org" <linux-arm-kernel-bounces@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nori, Sekhar" <nsekhar@ti.com>

Hi,

This is regarding board with multiple variations using an upcoming SoC from TI.
Variation of the board is detected by reading EEPROM using I2C after
init_machine gets invoked. In one of the variation UART# used is different.
Because of this decompressor logs (and early prints) can't be captured for the
board variant using this different UART#. Our solution for this problem is to
use different mach-id for the board using different UART#. But this solution
seems to be overkill as only to capture decompressor logs, we have to use
a new machine id.

As I2C will not work at the decompressor stage, I2C can't be used to detect
the board type.

As far as I know, ATAG is not parsed in decompressor stage and so ATAG cannot
be used to determine board variant or UART#. Otherwise we will have to add
capability in decompressor to parse ATAG, detect console to be used, and
modify uncompress.h to select proper console for capturing decompressor logs.
This seems a bad solution.

Our bootloader has the capability to detect the board variant.

So the best solution for us so far seems to add a new machine id, if any
better solutions are possible, please let us know.

Regards
Afzal
