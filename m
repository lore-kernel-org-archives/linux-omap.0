From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC] [PATCH 0/6] Add camera support to the OMAP1
	Amstrad Delta videophone
Date: Sun, 18 Jul 2010 06:18:06 +0200
Message-ID: <201007180618.08266.jkrzyszt@tis.icnet.pl>
Reply-To: Discussion of the Amstrad E3 emailer hardware/software
	<e3-hacking@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e3-hacking-bounces@earth.li>
Content-Disposition: inline
List-Unsubscribe: <http://www.earth.li/cgi-bin/mailman/options/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=unsubscribe>
List-Archive: <http://www.earth.li/pipermail/e3-hacking>
List-Post: <mailto:e3-hacking@earth.li>
List-Help: <mailto:e3-hacking-request@earth.li?subject=help>
List-Subscribe: <http://www.earth.li/cgi-bin/mailman/listinfo/e3-hacking>,
	<mailto:e3-hacking-request@earth.li?subject=subscribe>
Sender: e3-hacking-bounces@earth.li
Errors-To: e3-hacking-bounces@earth.li
To: linux-media@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-omap@vger.kernel.org

This series consists of the following patches:

  1/6	SoC Camera: add driver for OMAP1 camera interface
  2/6	OMAP1: Add support for SoC camera interface
  3/6	SoC Camera: add driver for OV6650 sensor
  4/6	SoC Camera: add support for g_parm / s_parm operations
  5/6	OMAP1: Amstrad Delta: add support for on-board camera
  6/6	OMAP1: Amstrad Delta: add camera controlled LEDS trigger

 arch/arm/mach-omap1/board-ams-delta.c     |   69 +
 arch/arm/mach-omap1/devices.c             |   43
 arch/arm/mach-omap1/include/mach/camera.h |    8
 drivers/media/video/Kconfig               |   20
 drivers/media/video/Makefile              |    2
 drivers/media/video/omap1_camera.c        | 1656 ++++++++++++++++++++++++++++++
 drivers/media/video/ov6650.c              | 1336 ++++++++++++++++++++++++
 drivers/media/video/soc_camera.c          |   18
 include/media/omap1_camera.h              |   16
 include/media/v4l2-chip-ident.h           |    1
 10 files changed, 3169 insertions(+)

Thanks,
Janusz
