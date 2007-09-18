From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: problems compiling latest git update
Date: Tue, 18 Sep 2007 13:32:58 -0300
Message-ID: <ae36f8040709180932l2b2afcb2q5be295434272e3c9@mail.gmail.com>
References: <ae36f8040709180700u671ae5fpc8fa4a0a7c8474c0@mail.gmail.com>
	<a0580c510709180718p220404d0jc5eac7b15eeab93a@mail.gmail.com>
	<ae36f8040709180914q54881d2ex90c9ab9ceb0ab967@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040709180914q54881d2ex90c9ab9ceb0ab967@mail.gmail.com>
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
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

OK , after make a super clean (mrproper) the configs back to normal, but th=
e
errors back, I added MMC/SD support in the kenel before compilate it any
IDEA ?

is this normal ?

 CALL    scripts/checksyscalls.sh
<stdin>:1097:2: warning: #warning syscall fadvise64 not implemented
<stdin>:1265:2: warning: #warning syscall migrate_pages not implemented
<stdin>:1321:2: warning: #warning syscall pselect6 not implemented
<stdin>:1325:2: warning: #warning syscall ppoll not implemented
<stdin>:1365:2: warning: #warning syscall epoll_pwait not implemented
<stdin>:1385:2: warning: #warning syscall fallocate not implemented
  CC      scripts/mod/empty.o


well the error comes back:
LD      arch/arm/nwfpe/built-in.o
  CC      arch/arm/plat-omap/common.o
  CC      arch/arm/plat-omap/sram.o
  AS      arch/arm/plat-omap/sram-fn.o
  CC      arch/arm/plat-omap/clock.o
  CC      arch/arm/plat-omap/devices.o
arch/arm/plat-omap/devices.c: In function 'omap_init_mmc':
arch/arm/plat-omap/devices.c:348: error: 'OMAP2_CTRL_BASE' undeclared (firs=
t
use in this function)
arch/arm/plat-omap/devices.c:348: error: (Each undeclared identifier is
reported only once
arch/arm/plat-omap/devices.c:348: error: for each function it appears in.)
make[1]: *** [arch/arm/plat-omap/devices.o] Error 1
make: *** [arch/arm/plat-omap] Error 2


any idea ?

On 9/18/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
>
> I'm doing and mrproper doing from the beginning all the process I cloned
> the git  to make my modifications and test over the  latest tree, and
> redoing everything again to see what happen
>
>
> ----------------------------------------------------------
>



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
