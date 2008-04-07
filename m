From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: DSP Bridge driver for OMAP3 platform
Date: Mon, 7 Apr 2008 18:29:35 -0500
Message-ID: <A8E8DDC23969AE4CB38FFF51016C77820283845D@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41339 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbYDGXaA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 19:30:00 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m37NTtd4010972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Apr 2008 18:30:00 -0500
Received: from dlee70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m37NTsY5027398
	for <linux-omap@vger.kernel.org>; Mon, 7 Apr 2008 18:29:55 -0500 (CDT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

We are pleased to announce the availability of DSP bridge driver for
OMAP3 platform. DSP Bridge driver provides features to control and
communicate with DSP enabling parallel processing for multimedia
acceleration. It enables the applications running on MCU to offload the
processing to DSP. 

Some of the key features of DSP Bridge are listed below.

- Messaging: Ability to exchange fixed size control messages with DSP.
- Dynamic memory management: Ability to dynamically map files to DSP
address space.
- Dynamic loading: Ability to dynamically load new nodes on DSP at run
time.
- Power Management: Static and dynamic power management for DSP.

The information on the following is available at
http://www.openomap.org/pub/dspbridge/

- Driver source
- Documentation
- User side library for user side application is available at:
- Sample applications demonstrating the API usage are available at:

The proposed location for the driver in the kernel tree is
drivers/dsp/dspbridge.

Thank you,
Best regards,
Hari Kanigeri
Texas Instruments
