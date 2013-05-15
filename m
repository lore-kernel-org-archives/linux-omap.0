From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: v3.10-rc1: backlight brightness after boot on N900
Date: Wed, 15 May 2013 20:18:45 +0300
Message-ID: <20130515171845.GB3157@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:49745 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759615Ab3EORSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 May 2013 13:18:52 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

Hi,

Is it expected that after boot you get 0 brightness i.e. a seemingly
blank display on N900 with 3.10-rc1?

First thought after seeing a blank display was that the probe
issues are still there, but everything was fine and after setting
/sys/class/backlight/acx565akm/brightness you get a picture.

Just wondering how the initial brightness is determined anyway?

A.
