From: "Y, Kishore" <kishore.y@ti.com>
Subject: compile break on dss2 branch for zoom3
Date: Thu, 11 Mar 2010 17:10:28 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026EFB4FA5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48210 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757528Ab0CKLkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 06:40:14 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,
	I am unable to compile dss2 tree for zoom3. Commit I am using following commit id

893d461b538e889da350061edaadeb8a9289913c
OMAP: DSS2: quick hack for set mode


Error I see is related to usb:-
drivers/usb/core/hcd.c: In function 'usb_hcd_resume_root_hub':
drivers/usb/core/hcd.c:1892: error: 'pm_wq' undeclared (first use in this function)
drivers/usb/core/hcd.c:1892: error: (Each undeclared identifier is reported only once
drivers/usb/core/hcd.c:1892: error: for each function it appears in.)
make[3]: *** [drivers/usb/core/hcd.o] Error 1
make[2]: *** [drivers/usb/core] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

When I disable usb, build goes through but the board does not bootup with this image. It is stuck at uncompressing linux.


Regards,
Kishore Y
