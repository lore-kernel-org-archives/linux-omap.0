From: Dirk Behme <dirk.behme@googlemail.com>
Subject: omap_2430sdp_defconfig modules compilation failures
Date: Sat, 05 May 2007 09:54:40 +0200
Message-ID: <463C3840.9020605@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Trying to compile modules for omap_2430sdp_defconfig fails:

drivers/usb/musb/plat_uds.c fails because MUSB_C_RAM_BITS definition 
is missing. This is because we have no asm/arch/hdrc_cnf.h. Davinci 
tree has this [1], can we take the same?

drivers/usb/musb/omap2430.c fails because missing AE5_2430_USB0HS_STP 
and OMAP243X_HS_BASE defines. Actually no idea here.

Cheers

Dirk

[1] 
http://source.mvista.com/git/gitweb.cgi?p=linux-davinci-2.6.git;a=blob;h=3811ce453158644f4b21616de7e40c9ea735ed55;hb=d77594d597df964f113fb8dfd7fde48981e9c7bb;f=include/asm-arm/arch-davinci/hdrc_cnf.h
