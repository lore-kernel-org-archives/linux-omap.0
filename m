From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 0/8] staging: tidspbridge: clean up drv_interface.c
Date: Tue, 31 Jan 2012 00:12:16 +0100
Message-ID: <cover.1327964066.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

I'm trying to learn how to contribute to the kernel and dsp/bridge is
a module that I have used for a while.

These patches are the result of this first effort. It is a clean up of
the file drv_interface.c which is the entry point of the kernel
module.

Thanks

v2:

* Removed changes in lines with pr_* and dbg_*, so Joe Perches could
  apply his patches for the format string without big rebases.
* Reviewed the modifications done by Lindent
* Added a clean up to the function bridge_mmap()
* Added a patch removing a unused global variable (driver_name)
* Added a patch that removes an always-true assert

vmjl

V=C3=ADctor Manuel J=C3=A1quez Leal (8):
  staging: tidspbridge: more readable code
  staging: tidspbridge: remove unused header
  staging: tidspbridge: Lindent to drv_interface.c
  staging: tidspbridge: silence the compiler
  staging: tidspbridge: remove header inclusions
  staging: tidspbridge: remove trivial assert
  staging: tidspbridge: clean up bridge_mmap()
  staging: tidspbridge: use the driver name string

 drivers/staging/tidspbridge/rmgr/drv_interface.c |  348 ++++++++++----=
-------
 drivers/staging/tidspbridge/rmgr/drv_interface.h |   28 --
 2 files changed, 166 insertions(+), 210 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/rmgr/drv_interface.h

--=20
1.7.8.3
