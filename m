From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Mon, 13 May 2013 23:53:02 +0300
Message-ID: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I tested 3.10-rc1 on OMAP1 / Nokia 770, and Retu MFD probe is broken:

[    2.264221] retu-mfd 2-0001: Retu v3.2 found
[    2.281951] retu-mfd 2-0001: Failed to allocate IRQs: -12
[    2.300140] retu-mfd: probe of 2-0001 failed with error -12

The error is coming from regmap code. According to git bisect, it is
caused by:

	commit ede4d7a5b9835510fd1f724367f68d2fa4128453
	Author: Jon Hunter <jon-hunter@ti.com>
	Date:   Fri Mar 1 11:22:47 2013 -0600

	    gpio/omap: convert gpio irq domain to linear mapping

The commit does not anymore revert cleanly, and I haven't yet tried
crafting a manual revert, so any fix proposals/ideas are welcome...

Thanks,

A.
