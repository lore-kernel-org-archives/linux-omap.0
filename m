From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 0/3] tty: serial: OMAP: work around broken IP block, driver
Date: Wed, 25 Jan 2012 19:50:32 -0700
Message-ID: <20120126024903.31613.24730.stgit@dusk>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

[ This series is targeted for merging during v3.3-rc ]

Hi

Here's an updated version of OMAP serial bugfix series against v3.3-rc1.
This revision has:

- reduced TX path interrupts by 5x compared to the first version

- a fix for the power management regression in v3.3-rc1 caused by the
  bogus wakeup latency computation

- left the the TX FIFO threshold unchanged - this is left for a 3.4 patch
  series

- improved commit messages

This series is also available via git in git://git.pwsan.com/linux-2.6
in the branch "omap_serial_fixes_3.3rc".

...

On v3.3-rc1, the OMAP serial console doesn't behave properly when
power management is enabled (the default with omap2plus_defconfig).
This seems to be due to one or more silicon bugs in the UART IP block
and a bug in the OMAP serial driver.

This patch series works around these problems.  It's been tested under
the following conditions:

On 35xx Beagleboard
 - in PIO mode
   - with CPUidle enabled
     - with off-mode disabled
     - with off-mode enabled
   - with CPUidle disabled
     - with off-mode disabled
     - with off-mode enabled
 - in DMA mode
   - with CPUidle enabled
     - with off-mode disabled
     - with off-mode enabled
   - with CPUidle disabled
     - with off-mode disabled
     - with off-mode enabled

On N800 (242x)
 - in PIO mode
   - with CPUidle disabled

On 4430 ES2 Pandaboard
 - in PIO mode
   - with CPUidle disabled
 - in DMA mode
   - with CPUidle disabled


- Paul

---

omap_serial_fixes_3.3rc
   text	   data	    bss	    dec	    hex	filename
6592293	 678588	5590684	12861565	 c4407d	vmlinux.orig
6592429	 678588	5590684	12861701	 c44105	vmlinux.patched


Paul Walmsley (3):
      tty: serial: OMAP: use a 1-byte RX FIFO threshold in PIO mode
      tty: serial: OMAP: block idle while the UART is transferring data in PIO mode
      tty: serial: omap-serial: wakeup latency constraint is in microseconds, not milliseconds


 arch/arm/mach-omap2/serial.c     |    8 ++++----
 drivers/tty/serial/omap-serial.c |   30 +++++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 9 deletions(-)
