From: Pavel Machek <pavel@ucw.cz>
Subject: drivers/media/i2c/adp1653.c: does not show as /dev/video* or
 v4l-subdev*
Date: Thu, 28 Apr 2016 10:45:46 +0200
Message-ID: <20160428084546.GA9957@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, sakari.ailus@iki.fi, tuukkat76@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

On n900, probe finishes ok (verified by adding printks), and the
device shows up in /sys, but I  don't get /dev/video* or
/dev/v4l-subdev*.

Other drivers (back and front camera) load ok, and actually work. Any
idea what could be wrong?

Thanks,
								Pavel
