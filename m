From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH/RFC 1/2] Add Dspbridge driver to OMAP GIT kernel
Date: Fri, 13 Jun 2008 19:01:13 -0500
Message-ID: <A8E8DDC23969AE4CB38FFF51016C778202D975BA@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55728 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757355AbYFNACF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 20:02:05 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Pasam, Vijay" <vpasam@ti.com>


This patch adds the dspbridge driver functionality for OMAP3 platform
to the OMAP GIT kernel. DSP Bridge driver provides features to control 
and communicate with DSP enabling parallel processing for multimedia
acceleration. It enables the applications running on MCU to offload 
the processing to DSP. 

Some of the key features of DSP Bridge are listed below.

- Messaging: Ability to exchange fixed size control messages with DSP.
- Dynamic memory management: Ability to dynamically map files to DSP
address
  space.
- Dynamic loading: Ability to dynamically load new nodes on DSP at run
time.
- Power Management: Static and dynamic power management for DSP.

The patch is available at 
http://www.omapzoom.org/pub/dspbridge/dspbridge_mpu_driver.patch 

The documents for reference can be accessed from 
http://www.omapzoom.org/pub/dspbridge/db_linux_pguide.pdf 
http://www.omapzoom.org/pub/dspbridge/db_linux_rguide.pdf 
http://www.omapzoom.org/pub/dspbridge/Linux_Bridge_Integration_3430.pdf 

Please let me know your comments on how we can work to include the 
Dspbridge driver source code in OMAP GIT tree. 
Please let me know if you need any additional information or questions
on dspbridge.

Thank you,
Best regards,
Hari
