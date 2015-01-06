From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: 8250: Make ISA ports optional
Date: Tue, 06 Jan 2015 14:13:59 +0100
Message-ID: <9492211.AECobr3jIN@wuerfel>
References: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 05 January 2015 22:09:45 Peter Hurley wrote:
> Some arches have no need to create unprobed 8250 ports; these phantom
> ports are primarily required for ISA ports which have no probe
> mechanism or to provide non-operational ports for userspace to
> configure (via TIOCSSERIAL and TIOCSERCONFIG ioctls).
> 
> Provide CONFIG_SERIAL_8250_PHANTOM_UARTS knob to disable phantom port
> registration; ie., CONFIG_SERIAL_8250_PHANTOM_UARTS=N only registers
> probed ports (ACPI/PNP, "serial8250" platform devices, PCI, etc).
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

The intent is definitely right, but I think a better approach is
possible.

I haven't tried it here, but how about moving the serial8250_init
function into a separate module, along with all the other parts
that are only used for ISA devices, but leaving the actual core
(all exported symbols) in this file?

At the same time, the serial8250_pnp_init/serial8250_pnp_exit calls
can be removed from the serial8250_init function and become
standalone initcalls.

	Arnd
