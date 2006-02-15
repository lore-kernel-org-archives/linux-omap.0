From: =?ISO-8859-1?Q?Lu=EDs_Cargnini?= <lvcargnini@gmail.com>
Subject: problems compiling u-boot-1.1.4
Date: Wed, 15 Feb 2006 19:06:44 +0000
Message-ID: <ae36f8040602151106w52a5baa0v115d1c4982332a85@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hi i've downloaded the u-boot-1.1.4 and did the following:
shark u-boot-1.1.4 # make omap5912osk_config
Configuring for omap5912osk board...
shark u-boot-1.1.4 # make
....
make[1]: Leaving directory `/root/instramed/u-boot-1.1.4/post/cpu'
arm-linux-gcc -Wa,-gstabs -D__ASSEMBLY__ -g  -Os =20
-fno-strict-aliasing  -fno-common -ffixed-r8 -msoft-float=20
-D__KERNEL__ -DTEXT_BASE=3D0x11080000
-I/root/instramed/u-boot-1.1.4/include -fno-builtin -ffreestanding
-nostdinc -isystem /usr/lib/gcc/i686-pc-linux-gnu/4.0.2/include -pipe=20
-DCONFIG_ARM -D__ARM__ -march=3Darmv4 -mabi=3Dapcs-gnu -c -o
cpu/arm926ejs/start.o
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S: Assembler messages:
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:169: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:335: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:336: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:341: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:342: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:347: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:348: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:353: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:354: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:359: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:360: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:384: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:385: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:390: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
/root/instramed/u-boot-1.1.4/cpu/arm926ejs/start.S:391: Error:
undefined symbol CFG_GBL_DATA_SIZE used as an immediate value
make: *** [cpu/arm926ejs/start.o] Error 1

i finded thie variable inside included/configs/omap*.h (another config
omap files)
someone know how to fix this ??

--
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
