From: "Amit Kucheria" <kucheria.amit@gmail.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: unlock flash device during boot
Date: Fri, 19 Oct 2007 17:07:57 +0300
Message-ID: <52d486620710190707n29a00019u15b9db7196f22f7b@mail.gmail.com>
References: <20071017222526.493688502@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20071017222526.493688502@mvista.com>
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
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 10/18/07, Kevin Hilman <khilman@mvista.com> wrote:
> The bootloader may lock the flash device upon booting.  This requires
> the use of 'flash_unlock' on each partition before using them.
>
> However, when booting from flash the MTD driver is unable to "mark
> space as dirty" since the device is locked.  This results lots of boot
> warnings from the MTD layer.
>
> The MTD driver for OMAP needs to unlock the device during init so
> booting from flash can work without errors.

This patch does fix the copious amounts of the following messages that
I get when I put a jffs2 filesystem on the NOR flash.

"Erase at 0x012e0000 failed immediately: -EROFS. Is the sector locked?
Dec 31 18:00:13 12 user.info ker<5>Write of 68 bytes at 0x0026111c
failed. returned -30, retlen 0
Write of 68 bytes at 0x0026111c failed. returned -30, retlen 0
nel: serial8250.0: ttyS0 at MMIO<5>Not marking the space at 0x0026111c
as dirty because the flash driver returned retlen zero
Not marking the space at 0x0026111c as dirty because the flash driver
returned retlen zero
 0x4806a000 (irq = 72) is a ST16<5>Write of 68 bytes at 0x0026111c
failed. returned -30, retlen 0
Write of 68 bytes at 0x0026111c failed. returned -30, retlen 0
654
<5>Not marking the space at 0x0026111c as dirty because the flash
driver returned retlen zero
Not marking the space at 0x0026111c as dirty because the flash driver
returned retlen zero
<4>Erase at 0x012c0000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x012c0000 failed immediately: -EROFS. Is the sector locked?
<4>Erase at 0x012a0000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x012a0000 failed immediately: -EROFS. Is the sector locked?"

--
Amit Kucheria, Linux developer
