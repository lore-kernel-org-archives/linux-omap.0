From: "Liu, Jason" <Jason.Liu@spansion.com>
Subject: How to make the module tools work on 2.6 kernel and ARM
 platform
Date: Wed, 1 Mar 2006 14:52:17 +0800
Message-ID: <C4B8EE93BC349D4FB908FEA6F478D38210666C@ssuzexmb2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi, All,

I met a problem when I attempted to insmod a xxx.ko,  which was cross =
compiled from Kernel Linux-2.6.10. It showed  "insmod: QM_MODULES: =
Function not implemented".  I guessed that it was because that the =
rootfs was still an old one, of which the module tools(insmod, rmmod, =
lsmod,..) were compiled from linux-2.4.20.
Who could tell me how to get the tools cross-compiled?    or provide =
existed tools (on ARM platform) for me.  I really appreciate your help.

Thanks a lot!!

Jason Liu


=20
