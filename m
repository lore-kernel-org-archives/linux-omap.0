From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 0/2] Some more camera syncup patches
Date: Tue, 6 Jan 2009 19:06:00 -0600
Message-ID: <A24693684029E5489D1D202277BE8944163282D6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42860 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758736AbZAGBGI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 20:06:08 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n07162nY023198
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 19:06:07 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n07162bT021065
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 19:06:02 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

Hi,

This 2 patches also syncs up some other features added previously on TI internal tree:

- Preview settings fix: this fixes some gains in order to obtain a much better image in OV sensor.

- Set VPP constraints: This is needes when TI PM is enabled, as this ensures
Proper operation maintaining voltage frequency levels.

Regards,
Sergio
