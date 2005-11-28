From: naga rajan <nagubk82@gmail.com>
Subject: Problem while building an application with DSP/BIOS version 5.20
Date: Mon, 28 Nov 2005 11:50:30 +0530
Message-ID: <7e6cc7550511272220i494ff69fl480b8547cfdd3a40@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

  Hello everybody,


            Currently I am working in DSP/BIOS part of OSK5912. I downloade=
d
and installed the BIOS5.20 Version in linux environment. I set the config
and other files accordingly. I tried to build the hello world application; =
I
cleaned the configuration and generation files without any problem. While
building the files, I faced the following error,



*  [root@sachin osk5912]# gmake*

/opt/ti_dsptools/cgtools-c5500-v2.56/bin/cl55 -g -pdr -mg -I. -I..
-I/opt/ti_dsptools/bios5.2/bios_5_20_03/packages/ti/bios/include
-I/opt/ti_dsptools/bios5.2/bios_5_20_03/packages/ti/rtdx/include/c5500
-I/opt/ti_dsptools/cgtools-c5500-v2.56/include

-c -ml ../hello.c

/opt/ti_dsptools/cgtools-c5500-v2.56/bin/cl55 -z -c -x -w -I..
-I/opt/ti_dsptools/bios5.2/bios_5_20_03/packages/ti/bios/lib
-I/opt/ti_dsptools/bios5.2/bios_5_20_03/packages/ti/rtdx/lib/c5500
-I/opt/ti_dsptools/bios5.2/bios_5_20_03/packages/ti/psl/lib
-I/opt/ti_dsptools/cgtools-c5500-v2.56/lib -m"hello.map" -o hello.out
hello.obj hellocfg.obj hellocfg_c.obj hellocfg.cmd

<Linking>

>> warning: creating output section .debug_abbrev without SECTIONS
specification

>> warning: creating output section .debug_info without SECTIONS
specification

>> warning: creating output section .debug_line without SECTIONS
specification

>> warning: load address of uninitialized member .sysstack of GROUP_2
ignored

>> warning: load address of uninitialized member .stack of GROUP_2 ignored

>> warning: load address of GROUP_2 ignored; the group has no initialized

            members

>>   error: illegal relocation type 050002 found in section .debug_info,
file


/opt/ti_dsptools/bios5.2/bios_5_20_03/packages/ti/bios/lib/lnkrtdx.a55L

>> Compilation failure

gmake: *** [hello.out] Error 1

rm hello.obj



What could be the problem? Whether any parameters have to be defined in
compiling and linking processes? Please provide a way out for this problem.





                                                            Thanks in
advance




            B.Nagarajan,


            SANDS.
