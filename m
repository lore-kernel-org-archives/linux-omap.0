From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 0/5] staging: tidspbridge: clean up drv_interface.c
Date: Mon, 23 Jan 2012 22:09:43 +0200
Message-ID: <cover.1327348286.git.vjaquez@igalia.com>
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

I would like to have some review in order to know if I could keep
moving in this direction.

Thanks

vmjl

V=C3=ADctor Manuel J=C3=A1quez Leal (5):
  staging: tidspbridge: more readable code
  staging: tidspbridge: remove unused header
  staging: tidspbridge: Lindent to drv_interface.c
  staging: tidspbridge: silence the compiler
  staging: tidspbridge: remove header inclusions

 drivers/staging/tidspbridge/rmgr/drv_interface.c |  352 +++++++++++---=
--------
 drivers/staging/tidspbridge/rmgr/drv_interface.h |   28 --
 2 files changed, 171 insertions(+), 209 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/rmgr/drv_interface.h

--=20
1.7.8.3
