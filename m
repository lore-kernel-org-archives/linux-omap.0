From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 7/8] staging: tidspbridge: clean up bridge_mmap()
Date: Tue, 31 Jan 2012 00:12:23 +0100
Message-ID: <3e41ab813d19445abed5478cbb271038bbdc70bf.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
In-Reply-To: <cover.1327964066.git.vjaquez@igalia.com>
References: <cover.1327964066.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

The variable offset is not used but in the debug log, so I don't see re=
ason to
calculate it here.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers=
/staging/tidspbridge/rmgr/drv_interface.c
index 97c40ff..5f810b6 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -257,7 +257,6 @@ err:
 /* This function maps kernel space memory to user space memory. */
 static int bridge_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-	u32 offset =3D vma->vm_pgoff << PAGE_SHIFT;
 	u32 status;
=20
 	DBC_ASSERT(vma->vm_start < vma->vm_end);
@@ -265,8 +264,8 @@ static int bridge_mmap(struct file *filp, struct vm=
_area_struct *vma)
 	vma->vm_flags |=3D VM_RESERVED | VM_IO;
 	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
=20
-	dev_dbg(bridge, "%s: vm filp %p offset %x start %lx end %lx page_prot=
 "
-		"%ulx flags %lx\n", __func__, filp, offset,
+	dev_dbg(bridge, "%s: vm filp %p start %lx end %lx page_prot %ulx "
+		"flags %lx\n", __func__, filp,
 		vma->vm_start, vma->vm_end, vma->vm_page_prot,
 		vma->vm_flags);
=20
--=20
1.7.8.3
