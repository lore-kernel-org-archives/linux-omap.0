From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: Latest git kernel won't build with muru.com N8x0 patch 2
Date: Wed, 25 Jun 2008 16:50:29 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A8708D67141@dlee01.ent.ti.com>
References: <20080625035939.GB3703@swansys> <20080625210514.GA9938@swansys>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:39637 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbYFYVui convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 17:50:38 -0400
In-Reply-To: <20080625210514.GA9938@swansys>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green <greenfreedom10@gmail.com>, Linux-OMAP List <linux-omap@vger.kernel.org>

> >   CC      drivers/cbus/retu-wdt.o
> > drivers/cbus/retu-wdt.c: In function 'retu_wdt_ioctl':
> > drivers/cbus/retu-wdt.c:204: error: implicit declaration of function
> > 'omap_readw'
> > make[2]: *** [drivers/cbus/retu-wdt.o] Error 1
> > make[1]: *** [drivers/cbus] Error 2
> > make: *** [drivers] Error 2


An implicit declaration of function error would imply that you are missing the appropriate header function. Hence, the compiler sees this as a declaration of a new function, instead of a function that has already been defined elsewhere.

> I removed lines 203-205 of drivers/cbus/retu-wdt.c (after patching); it
> seems
> to have fixed the problem for me.


Instead of removing the above lines, try including the header asm/io.h in the file drivers/cbus/retu-wdt.c. For example:

#include <asm/io.h>

Cheers
Jon
