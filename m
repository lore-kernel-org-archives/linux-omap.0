From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 12:23:03 +0200
Message-ID: <1232360583.6481.92.camel@tubuntu>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22018 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144AbZASKXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 05:23:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

Running with latest linux-omap kernel on OMAP3 SDP board, I have problem
with iounmap(). It looks like iounmap() does not properly free large
areas. Below is a test which fails for me in 6-7 loops.

OMAP spesific ioremap code doesn't do much, so I think it's somewhere in
generic ARM code. I looked at the ioremap code and for larger areas the
code uses area sections, and I believe the bug is somewhere there. 

Does this work on other processors?

 Tomi



#include <linux/module.h>
#include <linux/io.h>

static int test_init(void)
{
	const unsigned long paddr = 0x70000000;
	const unsigned long size = 2048 * 2048 * 4;
	void *vaddr;
	int i;

	for (i = 0; i < 200; ++i) {
		vaddr = ioremap(paddr, size);

		if (!vaddr) {
			printk("couldn't ioremap\n");
			break;
		}

		printk("ioremapped to %p\n", vaddr);

		iounmap(vaddr);
	}

	return 0;
}

static void test_exit(void) { }

module_init(test_init);
module_exit(test_exit);



