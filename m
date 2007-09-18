From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: problems compiling latest git update
Date: Tue, 18 Sep 2007 18:54:24 +0200
Message-ID: <46F002C0.60503@googlemail.com>
References: <ae36f8040709180700u671ae5fpc8fa4a0a7c8474c0@mail.gmail.com>	<a0580c510709180718p220404d0jc5eac7b15eeab93a@mail.gmail.com>	<ae36f8040709180914q54881d2ex90c9ab9ceb0ab967@mail.gmail.com>
	<ae36f8040709180932l2b2afcb2q5be295434272e3c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <ae36f8040709180932l2b2afcb2q5be295434272e3c9@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lvcargnini@gmail.com
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Lu=EDs Cargnini wrote:
> OK , after make a super clean (mrproper) the configs back to normal, bu=
t the

Clean omap_osk_5912_defconfig compiles and boots fine with recent git=20
(41283eed64c3279f62f...).

> errors back, I added MMC/SD support in the kenel before compilate it an=
y
> IDEA ?

>   CC      arch/arm/plat-omap/devices.o
> arch/arm/plat-omap/devices.c: In function 'omap_init_mmc':
> arch/arm/plat-omap/devices.c:348: error: 'OMAP2_CTRL_BASE' undeclared (=
first
> use in this function)
> arch/arm/plat-omap/devices.c:348: error: (Each undeclared identifier is
> reported only once
> arch/arm/plat-omap/devices.c:348: error: for each function it appears i=
n.)
> make[1]: *** [arch/arm/plat-omap/devices.o] Error 1
> make: *** [arch/arm/plat-omap] Error 2
>=20
> any idea ?

Maybe anything with

http://linux.omap.com/pipermail/linux-omap-open-source/2007-August/011159=
.html

?

Dirk
