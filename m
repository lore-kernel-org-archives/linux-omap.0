From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2 4/8] staging: tidspbridge: silence the compiler
Date: Tue, 31 Jan 2012 00:12:20 +0100
Message-ID: <d25cfe1b88f2b749cb31887d551a1c9b0fcde42e.1327964066.git.vjaquez@igalia.com>
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

Silence the warning when compiling drv_interface.c

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
