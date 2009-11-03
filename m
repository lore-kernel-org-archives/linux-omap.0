From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [PATCH 0/6] dspbridge varoius fixes
Date: Tue, 3 Nov 2009 17:15:56 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426AACC5C@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56349 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbZKCXPw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 18:15:52 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3NFvl5020499
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:15:57 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id nA3NFu4c013061
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:15:56 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA3NFui8014218
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 17:15:56 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP <linux-omap@vger.kernel.org>

Here are a few patches that are intended to be included in dspbridge branch:

- omar

---

Ernest Ramos Falcon (1):
  DSPBRIDGE: Report and print errors during OFF transitions

Ernesto Ramos (1):
  DSPBRIDGE: Fix flood of messages from DSP

Fernando Guzman (1):
  DSPBRIDGE: Set vdd1 to OPP3 always in DSP wake up

Fernando Guzman Lugo (1):
  DSPBRIDGE: New state for DSP transition to hibernation

Omar Ramirez Luna (2):
  DSPBRIDGE: Lower power transtion timeout
  DSPBRIDGE: Remove Warning pointer from integer w/o cast

 drivers/dsp/bridge/wmd/_tiomap_util.h   |    7 +++-
 drivers/dsp/bridge/wmd/msg_sm.c         |   11 +++++-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   56 ++++++++++++++++++++----------
 3 files changed, 51 insertions(+), 23 deletions(-)

