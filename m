From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: new problem - backlight
Date: Tue, 18 Sep 2007 15:25:32 -0300
Message-ID: <ae36f8040709181125h72202517r11acddd9fc9f7e@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

dear fellows, follow the problem that i found compiling with backlight of
OMAP enabled, the problem with devices.c seems to be fixed, but I'll send
the patch only after test the new kernel

 CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
<stdin>:1097:2: warning: #warning syscall fadvise64 not implemented
<stdin>:1265:2: warning: #warning syscall migrate_pages not implemented
<stdin>:1321:2: warning: #warning syscall pselect6 not implemented
<stdin>:1325:2: warning: #warning syscall ppoll not implemented
<stdin>:1365:2: warning: #warning syscall epoll_pwait not implemented
<stdin>:1385:2: warning: #warning syscall fallocate not implemented
  CHK     include/linux/compile.h
  CC [M]  drivers/video/backlight/omap_bl.o
drivers/video/backlight/omap_bl.c: In function 'omapbl_suspend':
drivers/video/backlight/omap_bl.c:79: error: 'struct backlight_device' has
no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_resume':
drivers/video/backlight/omap_bl.c:88: error: 'struct backlight_device' has
no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_set_power':
drivers/video/backlight/omap_bl.c:100: error: 'struct backlight_device' has
no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_update_status':
drivers/video/backlight/omap_bl.c:110: error: 'struct backlight_device' has
no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_get_intensity':
drivers/video/backlight/omap_bl.c:130: error: 'struct backlight_device' has
no member named 'class_dev'
drivers/video/backlight/omap_bl.c: In function 'omapbl_remove':
drivers/video/backlight/omap_bl.c:185: error: 'struct backlight_device' has
no member named 'class_dev'
make[3]: *** [drivers/video/backlight/omap_bl.o] Error 1
make[2]: *** [drivers/video/backlight] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2


--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
