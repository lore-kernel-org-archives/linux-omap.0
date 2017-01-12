From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/3] misc: sram: Introduce protect-exec region type
Date: Thu, 12 Jan 2017 14:52:17 -0600
Message-ID: <20170112205220.26325-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Russell King <linux@arm.linux.org.uk>, Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,
There are several instances when one would want to execute out of on-chip
SRAM, such as PM code on ARM platforms, so once again revisiting this
series to allow that in a generic manner. Seems that having a solution for
allowing SRAM to be mapped as executable will help clean up PM code on several
ARM platforms that are using ARM internal __arm_ioremap_exec API
and also open the door for PM support on new platforms like TI AM335x and
AM437x.

Previously a generic solution was attempted by introducing a memremap
executable API and then calling this from the generic sram driver here [1].
Russell King brought up the point that we should not just be mapping
memory as both writable and executable for security reasons which led to
the solution proposed in this series. 

The generic SRAM driver already has a concept of "partitions" which can be
defined and flagged in the device tree, so this series introduces a new flag,
protect-exec, which indicates the region of SRAM that has been blocked out in
the DT is protected and executable. It will share the same capabilities of the
already present sram "pool" which will allow allocation through the use of the
genalloc framework but also be protected through the use of an "sram_exec_copy"
helper function to handle the copying of data to the space and also the page
attributes. In this context protected means the memory is managed such that
it is *either* writeable and non-executable or read-only and executable through
manipulation of the page attributes.

Unforunately, unlike the previously proposed solution, this is not a drop in
replacement for __arm_ioremap_exec, A large side effect of allocating
executable SRAM as this series does is that it will require rework for some
SRAM code as a lot of the assembly code I have seen makes use of PC relative
memory locations at the end of the code for local variables. This will no
longer be possible if we must maintain the read-only executable status of
the memory. If that's required then SRAM code will need to use pointers to
a separately allocated region of sram that is just a normal writable pool.

As mentioned in previous series I still see several platforms (at-91,
imx6, socfpga, omap3) that could make use of this although some rework may
be required unlike with the last solution, and it will be needed for the
forthcoming TI am335x and am437x PM code as portions of PM code are
moving in to drivers. An example of this in use can be seen at [2] in the 
drivers/memory/ti-emif-sram.c and drivers/soc/ti/pm33xx.c files.

Regards,
Dave

[1] http://www.spinics.net/lists/linux-omap/msg132728.html
[2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.10/sram-exec-copy-pm

Dave Gerlach (3):
  misc: sram: Split sram data structures into local header
  misc: sram: Introduce support code for protect-exec sram type
  misc: sram: Integrate protect-exec reserved sram area type

 Documentation/devicetree/bindings/sram/sram.txt |   6 ++
 drivers/misc/Kconfig                            |   4 +
 drivers/misc/Makefile                           |   1 +
 drivers/misc/sram-exec.c                        | 105 ++++++++++++++++++++++++
 drivers/misc/sram.c                             |  51 +++++-------
 drivers/misc/sram.h                             |  58 +++++++++++++
 include/linux/sram.h                            |  27 ++++++
 7 files changed, 222 insertions(+), 30 deletions(-)
 create mode 100644 drivers/misc/sram-exec.c
 create mode 100644 drivers/misc/sram.h
 create mode 100644 include/linux/sram.h

-- 
2.11.0
