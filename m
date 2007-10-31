From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: commit 8691f1711eace1ee237a474a31574bdd59efb4c3 breaks build
Date: Thu, 1 Nov 2007 00:13:41 +0200
Message-ID: <31e679430710311513n4030b7a2v272db1bbfd2f03f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>, gadiyar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

commit 8691f1711eace1ee237a474a31574bdd59efb4c3 uses and undefined
macro in arch/arm/plat-omap/dma.c which breaks compilation:

OMAP_DMA4_OCP_SYSCONFIG

Maybe Anand forgot to add one file to his patch ??

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
