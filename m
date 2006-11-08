From: <Toshihiro.Kobayashi@nokia.com>
Subject: [PATCH] ARM: OMAP: Fix for mailbox and dsp module
Date: Wed, 8 Nov 2006 20:00:48 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F550321230A@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: linux-omap-open-source@linux.omap.com, hiroshi.doyu@nokia.com
List-Id: linux-omap@vger.kernel.org

Fix to build DSP Gateway as a module.

After this fix, modules regarding mailbox will be built as follows.

arch/arm/mach-omap[12]/mailbox.o -> mailbox_mach.ko
arch/arm/plat-omap/mailbox.o ->mailbox.ko

BR,
Toshihiro Kobayashi
