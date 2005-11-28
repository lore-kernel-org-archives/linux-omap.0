From: "Belanger, Melanie" <melanie.belanger@smisrd.com>
Subject: Building DSPLink.lib for OSK5912 using NON Montavista toolchain a
	nd file system
Date: Mon, 28 Nov 2005 13:11:59 -0500
Message-ID: <FD84200DE4A54C498ACA254C821CE5B678D1AA@mtlexch01.mtl.cmac.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hello,
 
I am trying to develop software for OMAP5912 (OSK5912) without using the
Montavista tools (I downloaded those of TI on 
http://focus.ti.com/docs/general/splashdsp.jhtml?&path=templatedata/cm/splas
hdsp/data/linux_com_downloads#osk). So far, I  have successfully followed
Matthew Percival's Newbie guide instructions to build a Hello world test
application. Then, I  tried to rebuild the rf6_gpp demo application that is
provided on the Spectrum CD that comes with the board. I found out that when
doing this using a NON Montavista toolchain, there are issues of soft and
hard-float gcc options. Montavista  uses the soft-float gcc option (so
DSPLink.lib, as provided on the CD, is soft-float) whereas the rest of the
world seems to use the hard-float option (as it is the standard option on
gcc). I resolved this problem by rebuilding dsplink.lib using the hard-float
option and by modifying the makefiles to use my toolchain, although it is
said on  http://www.arm.linux.org.uk/mailinglists/faq.php#f3 that it is best
to use the soft-float option when there is no real hardware FPU. What is
everyone doing with this problem (soft or hard?), is there a consensus?
 
At the moment, I still have segmentation fault problems when running the
rf6_gpp application I built using the TI toolchain, and using the TI file
system on the board. I am still working on these problems, but has anyone
tried this? 
 
Is there an extension to the Newbie guide that could help me? I couldn't
find one.
 
Thanks!
 
Melanie Belanger, ing. stag. 
SMIS R&D inc. 
melanie.belanger@smisrd.com 
http://www.smisrd.com
