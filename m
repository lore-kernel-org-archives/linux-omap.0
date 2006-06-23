From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Error compiling after cg-update
Date: Fri, 23 Jun 2006 18:21:00 -0300
Message-ID: <ae36f8040606231421t190bf34kc704214290678d51@mail.gmail.com>
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

Hi, I've upgrade my kernel source tree.  after that i try to recompilate an=
d
this occur:

arch/arm/plat-omap/clock.c:31: error: static declaration of 'clocks' follow=
s
non-static declaration
include/asm/arch/clock.h:51: error: previous declaration of 'clocks' was
here
arch/arm/plat-omap/clock.c:33: error: static declaration of 'clockfw_lock'
follows non-static declaration
include/asm/arch/clock.h:52: error: previous declaration of 'clockfw_lock'
was here


--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
