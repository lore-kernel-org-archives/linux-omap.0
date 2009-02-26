From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 0/3] GPIO for jack reporting interface
Date: Thu, 26 Feb 2009 01:56:43 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C02@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51018 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbZBZH46 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 02:56:58 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The following patch set implements GPIO support for SoC jack reporting
interface and uses it in SDP3430 machine driver.

The jack detection interface is used in SDP3430 driver to handle headset
events. That requires DAPM machine widgets to be added to the machine
driver before the actual use of the interface. 

ASoC: Add GPIO support for jack reporting interface
ASoC: Add DAPM machine widgets to SDP3430 driver
ASoC: Add headset jack detection for SDP3430 machine driver