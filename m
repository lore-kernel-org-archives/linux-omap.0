From: "Veda N" <veda74@gmail.com>
Subject: nand booting issue with OMAP2430 SDP
Date: Thu, 26 Jul 2007 19:24:11 +0530
Message-ID: <a5eaedfa0707260654o74e26f46l4990e0c32d1e6687@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi All,
  I am trying to boot linux using the latest kernels in git tree and
linux-2.6.22.

  By default onenand support is enabled. I disabled onenand support and
enabled
  nand support. I use the drivers/mtd/omap- nand-flash.c as my nand driver.

  The kernel crashes on booting. Is the nand driver broken on git tree or
linux-2.6.22.

Regards,
veda
