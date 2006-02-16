From: =?ISO-8859-1?Q?Lu=EDs_Cargnini?= <lvcargnini@gmail.com>
Subject: Re: problems compiling u-Boot 1.1.4 (2)
Date: Thu, 16 Feb 2006 10:14:22 -0200
Message-ID: <ae36f8040602160414s1af05cdcmf64b14448a894ff3@mail.gmail.com>
References: <ae36f8040602151401j4776aaccge3bd4818a95c60c5@mail.gmail.com>
	<20060216.123750.18297871.kaminaga@sm.sony.co.jp>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060216.123750.18297871.kaminaga@sm.sony.co.jp>
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
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

so about toolchain i must recreate the gcc without some options ?

On 2/16/06, Hiroki Kaminaga <kaminaga@sm.sony.co.jp> wrote:
> Hi,
>
> > /root/instramed/u-boot-1.1.4/lib_arm/board.c:236: undefined reference
> > to `flash_init'
> > common/libcommon.a(cmd_bootm.o): In function `do_imls':
> > /root/instramed/u-boot-1.1.4/common/cmd_bootm.c:1160: undefined
> > reference to `flash_info'
> > common/libcommon.a(cmd_flash.o): In function `abbrev_spec':
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:106: undefined
> > reference to `flash_info'
> > common/libcommon.a(cmd_flash.o): In function `addr_spec':
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:195: undefined
> > reference to `flash_info'
> > common/libcommon.a(cmd_flash.o): In function `flash_fill_sect_ranges':
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:278: undefined
> > reference to `flash_info'
> > common/libcommon.a(cmd_flash.o): In function `do_flinfo':
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:292: undefined
> > reference to `flash_print_info'
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:304: undefined
> > reference to `flash_print_info'
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:306: undefined
> > reference to `flash_info'
> > common/libcommon.a(cmd_flash.o): In function `flash_sect_erase':
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:432: undefined
> > reference to `flash_erase'
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:442: undefined
> > reference to `flash_info'
> > common/libcommon.a(cmd_flash.o): In function `do_flerase':
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:385: undefined
> > reference to `flash_erase'
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:401: undefined
> > reference to `flash_info'
> > common/libcommon.a(cmd_flash.o): In function `flash_sect_protect':
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:671: undefined
> > reference to `flash_info'
> > common/libcommon.a(cmd_flash.o): In function `do_protect':
> > /root/instramed/u-boot-1.1.4/common/cmd_flash.c:617: undefined
> > reference to `flash_info'
> > common/libcommon.a(flash.o): In function `addr2info':
> > /root/instramed/u-boot-1.1.4/common/flash.c:122: undefined reference
> > to `flash_info'
> > common/libcommon.a(flash.o): In function `flash_write':
> > /root/instramed/u-boot-1.1.4/common/flash.c:177: undefined reference
> > to `write_buff'
> > make: *** [u-boot] Error 1
> >
> >
> > someone know something about thi error in linker:
>
> I think there are 2 problems:
>
> 1) From u-boot-1.1.4 for OSK5912, flash implementation is moved from
>    board/omap5912osk/flash.c to drivers/cfi_flash.c but omap5912osk.h
>    is not taking this change.
>    -> fix omap5912osk.h (patch for this is posted to u-boot ML)
>    -> this will fix `undefined reference' error
>
> 2) Regarding softfp error, it could be due to your toolchain
>    configuration.
>
> Hope this helps.
>
>
> Best Regards,
>
> HK.
> --
>


--
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
