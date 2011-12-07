From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Tue, 06 Dec 2011 16:21:20 -0800
Message-ID: <874nxd5j0f.fsf@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
 (Govindraj R.'s message of "Fri, 11 Nov 2011 15:27:17 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alan Cox <alan@linux.intel.com>, Greg KH <greg@kroah.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Converting uart driver to adapt to pm runtime API's.
> Code re-org + cleanup.
> Moving some functionality from serial.c to omap-serial.c

Alan, can you confirm your Ack's are still valid on the drivers/tty
parts of this series?  It has gone through quite a few changes since
your original ack.

Greg, are you ok with this series merging via the OMAP tree since it is
changing arch/arm/mach-omap2/* code as well as the driver, and should go
together.  If so, with your ack (on the drivers/tty/* parts), I'll
handle this series through the OMAP tree.

Thanks,

Kevin
