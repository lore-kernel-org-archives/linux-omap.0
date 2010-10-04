From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCHv2 0/3] iovmm: fixes for iovmm module
Date: Mon,  4 Oct 2010 16:02:14 -0500
Message-ID: <1286226137-1233-1-git-send-email-x0095840@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi.DOYU@nokia.com, david.cohen@nokia.com
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, Fernando Guzman Lugo <x0095840@ti.com>
List-Id: linux-omap@vger.kernel.org

iovmm: fixes for iovmm module

Version 2:
* Removed "iovmm: fixes for iovmm module" that patch was already
  sent.
* Modified "iovmm: fix roundup for next area and end check for the
  last area" patch, base on Davin Cohen's comments and rename it
  to a proper name that describes what it is doing now.

Fernando Guzman Lugo (3):
  iovmm: no gap checking for fixed address
  iovmm: add superpages support to fixed da address
  iovmm: replace __iounmap with omap_iounmap

 arch/arm/plat-omap/iovmm.c |   67 ++++++++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 27 deletions(-)
