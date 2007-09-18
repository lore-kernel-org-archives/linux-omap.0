From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: problems compiling latest git update
Date: Tue, 18 Sep 2007 14:32:19 -0300
Message-ID: <ae36f8040709181032i286ccc7atc37a8104de47ced4@mail.gmail.com>
References: <ae36f8040709180700u671ae5fpc8fa4a0a7c8474c0@mail.gmail.com>
	<a0580c510709180718p220404d0jc5eac7b15eeab93a@mail.gmail.com>
	<ae36f8040709180914q54881d2ex90c9ab9ceb0ab967@mail.gmail.com>
	<ae36f8040709180932l2b2afcb2q5be295434272e3c9@mail.gmail.com>
	<46F002C0.60503@googlemail.com>
	<ae36f8040709180959t1d7d2d56v72ac2d116e7cf18e@mail.gmail.com>
	<ae36f8040709181019o661cf3d7g63aea567acf607b2@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040709181019o661cf3d7g63aea567acf607b2@mail.gmail.com>
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

ok Vitorio's producing a patch for devices.c, give me half hour to post it
here.

On 9/18/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
>
> the problem is I have to add the following file
> include/asm-arm/arch-omap/omap24xx.h
> but, the system appears to be testing everytime this clause:
> (mmc->enabled) {
>         if (cpu_is_omap24xx()) {
>             omap_cfg_reg(H18_24XX_MMC_CMD);
>             omap_cfg_reg(H15_24XX_MMC_CLKI);
>             omap_cfg_reg(G19_24XX_MMC_CLKO);
>             omap_cfg_reg(F20_24XX_MMC_DAT0);
>             omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
>             omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
>         } else {
>             omap_cfg_reg(MMC_CMD);
>             omap_cfg_reg(MMC_CLK);
>             omap_cfg_reg(MMC_DAT0);
>             if (cpu_is_omap1710()) {
>                 omap_cfg_reg(M15_1710_MMC_CLKI);
>                 omap_cfg_reg(P19_1710_MMC_CMDDIR);
>                 omap_cfg_reg(P20_1710_MMC_DATDIR0);
>             }
>
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
