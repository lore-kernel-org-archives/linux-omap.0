From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 4/8] staging: tidspbridge: silence the compiler
Date: Thu,  2 Feb 2012 23:51:08 +0100
Message-ID: <cbdbc287395a2668253a07f6173900357d4ac254.1328222377.git.vjaquez@igalia.com>
References: <d25cfe1b88f2b749cb31887d551a1c9b0fcde42e.1327964066.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d25cfe1b88f2b749cb31887d551a1c9b0fcde42e.1327964066.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

When compiling this report is raised by the compiler:

  CC [M]  drivers/staging/tidspbridge/rmgr/drv_interface.o
drivers/staging/tidspbridge/rmgr/drv_interface.c: In function 'bridge_m=
map':
drivers/staging/tidspbridge/rmgr/drv_interface.c:275:2: warning: format=
 '%lx' expects type 'long unsigned int', but argument 9 has type 'pgpro=
t_t'

This patch fixes that warning message.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers=
/staging/tidspbridge/rmgr/drv_interface.c
index 4316f4e..7a6401a 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -273,8 +273,9 @@ static int bridge_mmap(struct file *filp, struct vm=
_area_struct *vma)
 	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
=20
 	dev_dbg(bridge, "%s: vm filp %p offset %x start %lx end %lx page_prot=
 "
-		"%lx flags %lx\n", __func__, filp, offset,
-		vma->vm_start, vma->vm_end, vma->vm_page_prot, vma->vm_flags);
+		"%ulx flags %lx\n", __func__, filp, offset,
+		vma->vm_start, vma->vm_end, vma->vm_page_prot,
+		vma->vm_flags);
=20
 	status =3D remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 				 vma->vm_end - vma->vm_start,
--=20
1.7.8.3
