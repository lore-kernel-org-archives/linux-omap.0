From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] serial: Add driver for OMAP UARTs
Date: Tue, 10 Apr 2007 13:07:24 +0300
Message-ID: <461B61DC.6050005@solidboot.com>
References: <9C23CDD79DA20A479D4615857B2E2C47A1A4FB@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47A1A4FB@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Khasim,

Syed Mohammed, Khasim wrote:

> One concern I had here was, as we know OMAP supports multiple (3)
> UART  ports and they can be used for IrDA (UART3), Bluetooth (UART2/1),
 > Serial applications etc. All these drivers should configure/use
> similar register sets. So if we could,
> 
> - make the arch/arm/mach-omap2/serial.c more kind of a generic UART
>   API library that can be used by all UART drivers.
> 	- the UART library should handle overall clock /power management policy.
> 	- Centralized interrupt handler.
> 	- DMA / Polling / Interrupt based read/writes.

It is certainly a good idea.  You probably meant to write 
plat-omap/serial.c, since obviously the implementation shouldn't be 
limited to OMAP2.

I suppose the UART library will not be trivial, though.  I don't know 
what kind of special needs Bluetooth and IrDA have, but for example the 
serial console code needs specific handling for the Magic SysRQ 
characters in the RX loop.  The N800 Bluetooth driver does some funky 
stuff related to PM, as well.

Cheers,
Juha
