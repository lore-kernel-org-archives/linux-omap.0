From: naga rajan <nagubk82@gmail.com>
Subject: Error while building an DSP application
Date: Sat, 31 Dec 2005 10:31:07 +0530
Message-ID: <7e6cc7550512302101y16fe4815h7b76cb1d2f20a33b@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com, matthew@capgo.com
List-Id: linux-omap@vger.kernel.org

Hi all,



                With reference to the *"Linux DSP Tools Getting Started
Guide*"  released by *Texas Instrument*, I downloaded and installed the
Linux DSP Tools.I followed the document step by step and built the DSP/BIOS
LINK successfully.While perfoming the *step 14* in *section 3.2 Build and
Run Hello World from DSP*, the following error occured.



Login as *"user"*



[sachin@sachin osk5912]$ *gmake clean**
*removing generated configuration files ...
removing object files and binaries ...
[sachin@sachin osk5912]$ *gmake all**
*/opt/ti_dsptools/bios_5_03 /tconf/tconf
-Dconfig.importPath=3D"/opt/ti_dsptools/bios_5_03
;/opt/ti_dsptools/bios_5_03
/ti/bios;/home/sachin/rta_sdk_5_00/ti/bios/rta/examples/dsp/common;.."
hello.tcf
/bin/sh: line 1: /opt/ti_dsptools/bios_5_03: is a directory
gmake: *** [hellocfg.s55] *Error 126*



Login as *"root"*


[root@sachin osk5912]# *gmake clean**
*removing generated configuration files ...
removing object files and binaries ...
[root@sachin osk5912]# *gmake all**
*/opt/ti_dsptools/bios_5_03 /tconf/tconf
-Dconfig.importPath=3D"/opt/ti_dsptools/bios_5_03 ;/opt/ti_dsptools/bios_5_=
03
/ti/bios;/home/sachin/rta_sdk_5_00/ti/bios/rta/examples/dsp/common;.."
hello.tcf
/bin/sh: line 1: /opt/ti_dsptools/bios_5_03: is a directory
gmake: *** [hellocfg.s55] *Error 126*



In the guide, the proceedings are given for *"user"* login and not for *
"root"* login.I like to know the solution as we are interested in developin=
g
the DSP applications with this procedure as reference.



Please provide a solution for this problem.



Wish you a happy new year.



Thanks and regards,

B.Nagarajan,

SANDS.
