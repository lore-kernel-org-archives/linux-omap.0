From: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
Subject: [PATCH 0/1] omap: Ptr "isr_reg" tracked as NULL was dereferenced
Date: Tue,  5 Oct 2010 12:42:09 +0400
Message-ID: <cover.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com, akpm@linux-foundation.org, zmc@lurian.net, a.j.buxton@gmail.com, ext-eugeny.kuznetsov@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi,

Here is patch which fixes bug in /arch/arm/plat-omap/gpio.c file.
Pointer which may have NULL value in some cases (depend on kernel
configuration and GPIO method) is dereferenced later in code.
If pointer is NULL it mean some kernel bug.

Thanks,
Best Regards,
Evgeny

Evgeny Kuznetsov (1):
  omap: Ptr "isr_reg" tracked as NULL was dereferenced

 arch/arm/plat-omap/gpio.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
