From: "Amit Verma" <vermanamit@gmail.com>
Subject: Re: Reg: how to run X (with touch) on omap/Setting up console using
	USB - X11 is giving problem!
Date: Fri, 8 Sep 2006 11:43:53 +0530
Message-ID: <5a2ffe1f0609072313y2f392600i5b133850d97a715f@mail.gmail.com>
References: <5a2ffe1f0609070517u48ca316w5a595495e983beed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5a2ffe1f0609070517u48ca316w5a595495e983beed@mail.gmail.com>
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
To: david.cohen@indt.org.br
Cc: linux-omap-open-source@linux.omap.com, h6300-port@handhelds.org
List-Id: linux-omap@vger.kernel.org

Hi

these are the few lines of the 'configure' file. I'm not able to find
out where the problem is.

  17001   # We invoke sed twice because it is the simplest approach to
  17002   # changing $(DEPDIR) to its actual value in the expansion.
  17003   for file in `sed -n '
  17004      /^DEP_FILES = .*\\\\$/ {
  17005       s/^DEP_FILES = //
  17006       :loop
  17007         s/\\\\$//
  17008         p
  17009         n
  17010         /\\\\$/ b loop
  17011        p
  17012      }
  17013     /^DEP_FILES = / s/^DEP_FILES = //p' < "$mf" | \
  17014        sed -e 's/\$(DEPDIR)/'"$DEPDIR"'/g' -e 's/\$U/'"$U"'/g'`; do
  17015     # Make sure the directory exists.
  17016     test -f "$dirpart/$file" && continue
  17017     fdir=`(dirname "$file") 2>/dev/null ||
  17018 $as_expr X"$file" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
  17019          X"$file" : 'X\(//\)[^/]' \| \
  17020          X"$file" : 'X\(//\)$' \| \
  17021          X"$file" : 'X\(/\)' \| \
  17022          .     : '\(.\)' 2>/dev/null ||
  17023 echo X"$file" |
  17024     sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{ s//\1/; q; }
  17025           /^X\(\/\/\)[^/].*/{ s//\1/; q; }
  17026           /^X\(\/\/\)$/{ s//\1/; q; }
  17027           /^X\(\/\).*/{ s//\1/; q; }
  17028           s/.*/./; q'`
  17029     { if $as_mkdir_p; then
  17030     mkdir -p $dirpart/$fdir
  17031   else
  17032     as_dir=$dirpart/$fdir
  17033     as_dirs=
  17034     while test ! -d "$as_dir"; do
  17035       as_dirs="$as_dir $as_dirs"
  17036       as_dir=`(dirname "$as_dir") 2>/dev/null ||
  17037 $as_expr X"$as_dir" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
  17038          X"$as_dir" : 'X\(//\)[^/]' \| \
  17039          X"$as_dir" : 'X\(//\)$' \| \
  17040          X"$as_dir" : 'X\(/\)' \| \
  17041          .     : '\(.\)' 2>/dev/null ||
  17042 echo X"$as_dir" |
  17043     sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{ s//\1/; q; }
  17044           /^X\(\/\/\)[^/].*/{ s//\1/; q; }
  17045           /^X\(\/\/\)$/{ s//\1/; q; }
  17046           /^X\(\/\).*/{ s//\1/; q; }
  17047           s/.*/./; q'`
  17048     done
  17049     test ! -n "$as_dirs" || mkdir $as_dirs
  17050   fi || { { echo "$as_me:$LINENO: error: cannot create
directory $dirpart/$fdir" >&5
  17051 echo "$as_me: error: cannot create directory $dirpart/$fdir" >&2;}
  17052    { (exit 1); exit 1; }; }; }
  17053

--
Thanks!
-Amit


On 9/7/06, Amit Verma <vermanamit@gmail.com> wrote:
> Hi David
>
> I have downloaded the xlibs one by one from the CVS... then i run the
> autogen for all in the order specified. All went fine till X11. there
> the autogen is giving the following error in the generated "configure"
> file :-(
>
>
> /home/guest/xlibs/X11/configure: line 17009: syntax error near
> unexpected token `}'
> /home/guest/xlibs/X11/configure: line 17009: `    }'
>
>
>
> Plz help!
> thanks in advance.
> -Amit Verma
>
>
>
> ---
>
> Re: Setting up console using USB
> This message: [ Message body ] [ Respond ] [ More options ]
> Related messages: [ Next message ] [ Previous message ] [ In reply to
> ] [ Next in thread ] [ Replies ]
> From: lamikr <lamikr_at_cc.jyu.fi>
> Date: Wed, 09 Mar 2005 22:37:23 +0200
>
> Sorry that my reply lasted, but I just noticed that I had first replied
> to wrong mailing list.
>
>
> I think that the MMC device is the iPaqs memory stick and
> that MMC driver work for the omap is available at least in the new 2.6
> kernels.
> If you have MMS driver loaded do you know whether you have been able to
> mount the memory stick?
>
>
> Before buying the 6340 I have still couple of questions. I would really
> appreciate if you could answer
> also to them so that I could really get the whole picture.
>
>
> a) Do I need some special equipments for working or are serial caples,
> etc. with the right connectors coming with
> the h6340. As you have been able to boot it by using c-program I believe
> that the JTAG is not needed.
> b) Which version of kernel your work is based btw, are you using,
> vanilla 2.6 or 2.4 or some heavily patched one?
> c) After getting the device, could you send me the sources you have made
> so far.
> I would also need some instructions for getting started with. So far I
> have only developed one device driver
> and that was for the Windows so I am not very experienced in that area
> but I could learn. And besides
> I read LWN kernel development pages very actively :-)
> d) Are you still able to use the Wince while not hacking with the Linux?
>
>
> I have tried to search from the omap mailing list and found some quite
> interesting mails.
> I copy/pasted them to end of this mail in a hope that they could be
> usefull for you.
>
>
> Mika
> ----------------------------------
>
>
> RE: MMC Interface
>
>
> Problem Solved.
>
>
> Platform: OMAP 1510 Innovator board
>
>
> I upgraded to 2.6.9 Kernel and applied the Linux_2.6.9-omap1 patch from
> www.muru.com/linux/omap
>
>
> Used mknod /dev/mmcb1 b 254 1
>
>
> With MMC card formatted with FAT and inserted in slot
>
>
> mount -t msdos /dev/mmcb1 /mnt/mmc
>
>
> and the card is mounted.
>
>
> If the kernel is not correctly configured you will naturally run into
> problems with mounting. If you have no problems booting but have
> problems mounting your mmc device using this kernel and patch, I suggest
> to look carefully at the kernel configuration as this is likely to be
> the cause.
>
>
> Cheers,
>
>
> Marco
> -----Original Message-----
> From: linux-omap-open-source-bounces_at_linux.omap.com
> [mailto:linux-omap-open-source-bounces_at_linux.omap.com] On Behalf Of
> Marco Candiago
> Sent: Friday, 12 November 2004 10:42 AM
> To: linux-omap-open-source_at_linux.omap.com
> Subject: MMC Interface
>
>
> Dear All,
>
>
>
> I'm trying to mount my MMC card on my OMAP Innovator 1510 development
> board, but not without difficulties.
>
>
>
> Initially I had MMC support compiled into my 2.6.5 kernel, however the
> load script indicated that the MMC driver was not loaded.
>
>
> I then recompiled the kernel so that I could insert the MMC drivers as
> modules:
>
>
> I inserted the following two kernel modules successfully:
>
>
> mmc_block.ko
> mmc_core.ko
>
>
> lsmod gives me:
>
>
> mmc_block 5544 0 - Live 0xbf005000
> mmc_core 12516 1 mmc_block, Live 0xbf000000
>
>
> I followed previously listed instruction to add and mount a block
> device:
>
>
> mknod /dev/mmc0 b 254 0
>
>
> mount /dev/mmc0 /mount/mmc
>
>
> however when I try to mount the device I get a /dev/mmc0 is not a valid
> block device message.
>
>
> Does anyone have any suggestions on how I can troubleshoot this issue?
>
>
> Also in the mmc module directory exists omap.ko which I can not get to
> load. It omap.ko required for mmc functionality?
>
>
>
>
> Thanks,
>
>
> Marco
>
>
>
>
> ------------------------------------
> Re: touch driver on innovator 1510
>
>
> Dear David,
>   In fact, we don't change any code in the driver. Cause we found the
> code will halt while loading the driver. Then we try to put some
> messages in the driver and find this problem. :-(
>
>
> Regard,
> Jeffery Huang
> David Cohen wrote:
>
>
> ext Jeffery Huang wrote:
>
>
> > Hi,
> > We try to use the touch driver from bk tree and got a strange
> > problem. We found that the interrupt will occur while we load it into
> > kernel then system halt. Here is our verify method: we make messages
> > show in omap_ts_handler and found that the process just run to here
> > and then become a unlimited loop to call the function. Does there
> > anyone know how to resolve. Please kindly tell us.
> > Thanks.
> >
> > Regard,
> > Jeffery Huang
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source_at_linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
> Hi,

> I already got this problem too. But it's stoped to happen without any
> change. Do you know how to reproduce this error?
> BR,
>
>
> David Cohen
>
>
> -------------------------------------------
>
>
>
> Hi all,
>
>
> I've updated this tutorial about How to run X on OMAP platform. Here the
> new file.
>
>
> BR,
>
>
> David Cohen
>
>
> ------------------------------------------------------------------------
>
>
> HOW TO MAKE THE OMAP RUN X WITH TOUCHSCREEN SUPPORT
>
>
> This tutorial was made to help everyone that wants to make his OMAP
> run X with the touchscreen. We'll assume that you have a minimal
> experience with Linux and OMAP platform, your OMAP is running a kernel
> that already has a touchscreen driver and this touchscreen use the
> tslib (default for 2.6 kernel) and the root filesystem is on a desktop
> (on the /armfs_debian directory) and is mounted by nfs. And all this
> is already working well.
> In this tutorial, all the commands on part 1 and 2 are made on desktop
> shell and the part 3 is made on OMAP shell.
>
>
> Contents:
> 1 BUILDING THE TSLIB AND XSERVER (AND THEIR DEPENDENCES)
> 1.1 SCRATCHBOX
> 1.2 ZLIB
> 1.3 TSLIB
> 1.4 XLIBS
> 1.5 XSERVER
> 2 COPYING FILES TO THE OMAP FILESYSTEM
> 3 CONFIGURING THE OMAP TO RUNNING X WITH TOUCHSCREEN
> 3.1 SETTING UP KERNEL FOR TOUCHSCREEN SUPPORT
> 3.2 SETTING UP TS.CONF
> 3.3 SETTING UP ENVIRONMENT VARIABLES
> 3.4 CALIBRATING THE TOUCHSCREEN
> 3.5 FINNISHING INSTALATION
> 4 FURTHER READING
> 5 AUTHOR
> 6 CHANGES
>
>
> ----------
> 1 BUILDING THE TSLIB AND XSERVER (AND THEIR DEPENDENCES)
>
>
> The firs step is to build the zlib, tslib, xlibs and Xserver. We will
> use the scratchbox to help us with the cross compiling.
>
>
> -----
> 1.1 SCRATCHBOX
>
>
> If you don't have the scratchbox installed and don't know how to do
> it, you can take a look at the "Setting up the OMAP1710 H3" tutorial.
> Its reference is on the bottom of this turorial (part 4). But if you
> already have the scratchbox, so we need to configure the scratchbox to
> ARM/GLIBC options.
>
>
> Type this command to start a scratchbox shell:
>
>
> $ scratchbox
>
>
> Follow these steps to configure the scratchbox to ARM/GLIBC options:
>
>
> [sbox-: ~] > sbox-config -ct ARM-GLIBC
>
>
> Available compilers:
>        0) arm-gcc-3.3.2-uclibc-snapshot-20040229
>        1) arm-linux-gcc-3.3_3.3.4-glibc-2.3.2.ds1
>        2) host-gcc
>
>
> Enter compiler number: 1
>
>
> Available CPU-transparency methods:
>        sbrsh
>        qemu-arm
>        qemu-ppc
>
>
> Enter method name (qemu-arm): qemu-arm
>
>
> Available devkits:
>        debian
>
>
> Enter list of devkit names (none): debian
>
>
> [sbox-: ~] > sbox-config -st ARM-GLIBC
> [sbox-ARM-GLIBC: ~] > sbox-config -cc
>
>
> -----
> 1.2 ZLIB
>
>
> The zlib is a xlibs dependence. We have to download and install it:
>
>
> [sbox-ARM-GLIBC: ~] > wget http://www.gzip.org/zlib/zlib-1.2.1.tar.bz2
> [sbox-ARM-GLIBC: ~] > tar -xjvf zlib-1.2.1.tar.bz2
> [sbox-ARM-GLIBC: ~] > cd zlib-1.2.1
> [sbox-ARM-GLIBC: ~/zlib-1.2.1] > ./configure --prefix=/usr
> [sbox-ARM-GLIBC: ~/zlib-1.2.1] > make install
> [sbox-ARM-GLIBC: ~/zlib-1.2.1] > cd ..
>
>
> -----
> 1.3 TSLIB
>
>
> We have to download and instaling the tslib following these steps:
>
>
> [sbox-ARM-GLIBC: ~] > cvs -d
> :pserver:cvs_at_pubcvs.arm.linux.org.uk:/mnt/src/cvsroot login
>
>
> Logging in to :pserver:cvs_at_pubcvs.arm.linux.org.uk:2401/mnt/src/cvsroot
> CVS password: <Enter>
>
>
> [sbox-ARM-GLIBC: ~] > cvs -d
> :pserver:cvs_at_pubcvs.arm.linux.org.uk:/mnt/src/cvsroot co tslib
> [sbox-ARM-GLIBC: ~] > cd tslib
>
>
> Now we have to configure and build the tslib:
>
>
> [sbox-ARM-GLIBC: ~/tslib] > ./autogen.sh
> [sbox-ARM-GLIBC: ~/tslib] > ./configure --prefix=/usr --host=arm-linux-gnu
>
>
> Edit the file config.h and comment the line "#define malloc
> rpl_malloc" to avoid this option:
> "#define malloc rpl_malloc" -> "//#define malloc rpl_malloc"
>
>
> [sbox-ARM-GLIBC: ~/tslib] > make
> [sbox-ARM-GLIBC: ~/tslib] > make install
> [sbox-ARM-GLIBC: ~/tslib] > cd ..
>
>
> -----
> 1.4 XLIBS
>
>
> The xlibs are dependences for the Xserver. We have to download and
> instaling it.
>
>
> [sbox-ARM-GLIBC: ~] > cvs -d :pserver:anoncvs_at_freedesktop.org:/cvs/ login
>
>
> Logging in to :pserver:anoncvs_at_freedesktop.org:2401/cvs
> CVS password: <Enter>
>
>
> [sbox-ARM-GLIBC: ~] > cvs -d :pserver:anoncvs_at_freedesktop.org:/cvs/ co xlibs
>
>
> <It will take some time>
>
>
> [sbox-ARM-GLIBC: ~] cd xlibs
>
>
> Now you have to build these libs below:
>
>
> Randr
> Render
> XExtensions
> FixesExt
> DamageExt
> Xproto
> xtrans
> Xfont
> Xau
> CompositeExt
> ResourceExt
> RecordExt
> Xdmcp
> XCalibrateExt
> X11
> Xext
>
>
> All you must to do is repeat the following commands changing the <lib>
> name for one lib in the list, keeping the same order that is displayed
> (from Randr to Xext):
>
>
> [sbox-ARM-GLIBC: ~/xlibs] > cd <lib>
> [sbox-ARM-GLIBC: ~/xlibs/<lib>] > ./autogen.sh --prefix=/usr
> --host=arm-linux-gnu
> [sbox-ARM-GLIBC: ~/xlibs/<lib>] > make install
> [sbox-ARM-GLIBC: ~/xlibs/<lib<] > cd ..
>
>
> -----
> 1.5 XSERVER
>
>
> And finally, follow theses commands to build and install the Xserver
> with framebuffer support. The target will be called Xfbdev.
>
>
> [sbox-ARM-GLIBC: ~] > cvs -d
> :pserver:anoncvs_at_pdx.freedesktop.org:/cvs/xserver login
>
>
> Logging in to :pserver:anoncvs_at_pdx.freedesktop.org:2401/cvs/xserver
> CVS password: <Enter>
>
>
> [sbox-ARM-GLIBC: ~] > cvs -d
> :pserver:anoncvs_at_pdx.freedesktop.org:/cvs/xserver co xserver
>
>
> <It will take some time>
>
>
> [sbox-ARM-GLIBC: ~] > cd xserver
> [sbox-ARM-GLIBC: ~/xserver] > ./autogen.sh
> [sbox-ARM-GLIBC: ~/xserver] > ./configure --prefix=/usr
> --host=arm-linux-gnu --disable-glx --disable-dri --disable-ipv6
> --disable-xglserver --disable-xglxserver --disable-xsdlserver
> --disable-xwinserver --disable-xnestserver
> [sbox-ARM-GLIBC: ~/xserver] > make install
>
>
>
> ----------
> 2 COPYING FILES TO THE OMAP FILESYSTEM
>
>
> In this step, we have to copy some compiled files to the filesystem
> (as it was said before, the root OMAP filesystem is on /armfs_debian).
>
>
> Type this command to exit the scratchbox
>
>
> [sbox-ARM-GLIBC: ~/xserver] > exit
>
>
> Now, we'll copy the libs and the X to the OMAP filesystem
>
>
> $ sudo cp -a /scratchbox/users/<omap_user>/targets/ARM-GLIBC/usr/lib/libts*so*
> /armfs_debian/usr/lib
> $ sudo cp -a /scratchbox/users/<omap_user>/targets/ARM-GLIBC/usr/lib/ts
> /armfs_debian/usr/lib
> $ sudo cp -a /scratchbox/users/<omap_user>/targets/ARM-GLIBC/usr/lib/libX*so*
> /armfs_debian/usr/lib
> $ sudo cp -a /scratchbox/users/<omap_user>/targets/ARM-GLIBC/usr/lib/libfontcache*so*
> /armfs_debian/usr/lib
> $ sudo cp -a /scratchbox/users/<omap_user>/targets/ARM-GLIBC/usr/bin/Xfbdev
> /armfs_debian/usr/X11R6/bin
> $ sudo cp -a /scratchbox/users/<omap_user>/home/<omap_user>/tslib/tests/.libs/ts_calibrate
> /armfs_debian/usr/X11R6/bin
> $ sudo cp -a /scratchbox/users/<omap_user>/home/<omap_user>/tslib/etc/ts.conf
> /armfs_debian/etc/ts.conf
>
>
> ----------
> 3 CONFIGURING THE OMAP TO RUNNING X WITH TOUCHSCREEN
>
>
> The next steps are setting up the ts.conf and environment variables,
> calibrating the touchscreen and finnishing instalation. All those
> steps will be made on OMAP shell.
>
>
> -----
> 3.1 SETTING UP KERNEL FOR TOUCHSCREEN SUPPORT
>
>
> Before building the OMAP linux kernel, type 'make menuconfig' and
> choose some options to enable touchscreen support:
>
>
> Input device support:
>  <*> Event interface
>  ...
>  [*] Touchscreens
>  <*> OMAP touchscreen input driver
>
> -----
> 3.2 SETTING UP TS.CONF
>
>
> The OMAP platform uses the event layer for the touchscreen. So, we
> just need to edit the "/etc/ts.conf" file and uncomment the line "#
> module_raw input":
> "# module_raw input" -> "module_raw input"
>
>
> -----
> 3.3 SETTING UP ENVIRONMENT VARIABLES
>
>
> We need to set up 2 variables: TSLIB_DEVICE and TSLIB_CONFFILE. The
> TSLIB_DEVICE is the device that the tslib will read datas from
> touchscreen, and the TSLIB_CONFFILE is the absolute PATH fot the
> ts.conf:
>
>
> TSLIB_TSDEVICE=/dev/input/event1
> (This is the correct input/eventX for OMAP 1510 and 1710. For others
> platform, you have to test it before set this variable)
> TSLIB_CONFFILE=/etc/ts.conf
> export TSLIB_TSDEVICE TSLIB_CONFFILE
>
>
> We can put it on the /etc/profile and the environment variables will
> always be read at the boot time.
>
>
> -----
> 3.4 CALIBRATING THE TOUCHSCREEN
>
>
> The data sent by the touchscreen device isn't proportional to the lcd.
> So, we need to calibrate it. All we need to do is execute the
> ts_calibrate and follow its instructions on the OMAP's lcd. After
> that, the /etc/pointercal will be create with calibrate data.
>
>
> -----
> 3.5 FINNISHING INSTALATION
>
>
> The last step is make the OMAP Linux knows those libraries that we
> copied before. Just type the ldconfig command:
> # ldconfig
>
>
> And have fun! :) Just type the Xfbdev commmand to run the X.
>
>
>
> ----------
> 4 FURTHER READING
>
>
> - "Setting up the OMAP1710 H3" ->
> http://linux.omap.com/pub/documentation/omap_1710v1.4.txt
>
>
>
> ----------
> 5 AUTHORS
>
>
> 16. Nov 2004
> 10LE - Laboratorio de Linux Embarcado (Embedded Linux Lab)
> David Cohen <david.cohen_at_indt.org.br>
>
>
>
> ----------
> 6 CHANGES
>
>
> 16. Nov 2004 - Carlos Aguiar <carlos.aguiar_at_indt.org.br>
> - Fixed some wrong paths and file names
> 04. Mar 2005 - David Cohen <david.cohen_at_indt.org.br>
> - Added the topic "3.1 SETTING UP KERNEL FOR TOUCHSCREEN SUPPORT"
> - Tested this tutorial on OMAP 1510 and 1710 platform
>
>
>
> ------------------------------------------------------------------------
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source_at_linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>
>
>
>
> ------------
> Mika
> Husam Senussi wrote:
>
>
> Husam Senussi wrote:
>
>
> > No wince is not running in the background, once the C application is
> > loaded it will take over the device and disable MMU so I can have
> > direct access to all registers.
> >
> > So far I can see that I have access to something like MMC device, at
> > less I can see the kernel is setting up the driver, still no luck with
> > the LCD .
> >
> >> From: lamikr <lamikr_at_cc.jyu.fi>
> >> Reply-To: h6300-port_at_handhelds.org
> >> To: h6300-port_at_handhelds.org
> >> Subject: Re: [H6300-port] Setting up console using USB
> >> Date: Tue, 08 Mar 2005 18:39:36 +0200
> >>
> >> That's nice. When you load the linux will it then have full access
> >> for the iPaq hardware or
> >> is the wince still running in the background?
> >>
> >> The omap developer group seems to be very active, have you tried to
> >> ask from there.
> >> They are mostly working with the Intels reference implementations
> >> instead than with the Imap
> >> but maybe they could help as H6300 series devices are based on the
> >> omap 1510 board.
> >>
> >> Mika
> >>
> >>>
> >>> I'm loading linux from wince, I gave up on Haret and instaed I wrote
> >>> small application that loads small C program "bootstarp".
> >>>
> >>> The C application allows you to load the kernel via USB serial
> >>> connection and also to can print to secreen by writting directely to
> >>> the Frame Buffer, that help me with the debugging.
> >>>
> >>>> From: lamikr <lamikr_at_cc.jyu.fi>
> >>>> Reply-To: h6300-port_at_handhelds.org
> >>>> To: h6300-port_at_handhelds.org
> >>>> Subject: Re: [H6300-port] Setting up console using USB
> >>>> Date: Tue, 08 Mar 2005 09:28:55 +0200
> >>>>
> >>>> Hi
> >>>>
> >>>> Have you been able to get the Linux flashed to h6300 and loading
> >>>> automatically during the start-up
> >>>> or are you loading somehow by still using also the wince?
> >>>> I am still not hacking with the H6300 but if that really works then
> >>>> I will buy one and try to start helping.
> >>>>
> >>>> Husam Senussi wrote:
> >>>>
> >>>>> Hi,
> >>>>>
> >>>>> I don't know if theres is other people still looking to port linux
> >>>>> to h6300, so far I manage to load the OS and have the output going
> >>>>> to the LCD screen, I did that by adding small hack to allow printk
> >>>>> to write to Frame buffer because I failed to write to USB.
> >>>>>
> >>>>> I can see from the screen dump I'm getting as far as executing
> >>>>> /sbin/init. which from what I know is the step where I should get
> >>>>> shell prompt, but nothing happening after that.
> >>>>>
> >>>>> Currently I'm trying to get the USB serial console and also OMAP
> >>>>> Frame buffer driver to work so I can replace it with my hack.
> >>>>>
> >>>>> So it will be great if somebody out there can help.
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>
> >>>>> _______________________________________________
> >>>>> H6300-port mailing list
> >>>>> H6300-port_at_handhelds.org
> >>>>> https://www.handhelds.org/mailman/listinfo/h6300-port
> >>>>>
> >>>>
> >>>> _______________________________________________
> >>>> H6300-port mailing list
> >>>> H6300-port_at_handhelds.org
> >>>> https://www.handhelds.org/mailman/listinfo/h6300-port
> >>>
> >>>
> >>>
> >>>
> >>> _______________________________________________
> >>> H6300-port mailing list
> >>> H6300-port_at_handhelds.org
> >>> https://www.handhelds.org/mailman/listinfo/h6300-port
> >>>
> >>
> >> _______________________________________________
> >> H6300-port mailing list
> >> H6300-port_at_handhelds.org
> >> https://www.handhelds.org/mailman/listinfo/h6300-port
> >
> >
> >
> > _______________________________________________
> > H6300-port mailing list
> > H6300-port_at_handhelds.org
> > https://www.handhelds.org/mailman/listinfo/h6300-port
>
