From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: problems compiling latest version of kernel with denx toolkit
Date: Fri, 14 Jul 2006 14:38:40 -0300
Message-ID: <ae36f8040607141038p3698911ck4cd8a281e698ea8@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi someone find a fix for this problem ?
CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/compile.h
  CC      arch/arm/plat-omap/clock.o
arch/arm/plat-omap/clock.c:31: error: static declaration of 'clocks' follow=
s
non-static declaration
include/asm/arch/clock.h:19: error: previous declaration of 'clocks' was
here
arch/arm/plat-omap/clock.c:33: error: static declaration of 'clockfw_lock'
follows non-static declaration
include/asm/arch/clock.h:20: error: previous declaration of 'clockfw_lock'
was here
make[1]: *** [arch/arm/plat-omap/clock.o] Error 1
make: *** [arch/arm/plat-omap] Error 2

the omap is osk 5912


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
