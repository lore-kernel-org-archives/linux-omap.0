From: nicolas schichan <schich_n@epita.fr>
Subject: Re: OMAP850 / HTC Wizard: Keyboard-Kernel-Driver ?
Date: Wed, 12 Jul 2006 18:04:38 +0200
Message-ID: <20060712160438.GA12733@epita.fr>
References: <20060712125827.89035.qmail@web27806.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060712125827.89035.qmail@web27806.mail.ukl.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Omap 850 <omap850@yahoo.de>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 12, 2006 at 02:58:27PM +0200, Omap 850 wrote:
Hello,

> can sombody help me, i search for a way to
> find-out mor about the keyboard on my HTC Wizard / OMAP850 with ARM926 CPU.

If you compiled the zImage with the tornado_defconfig configuration
file, the tornado keypad driver should be available in your
kernel. if you hit some keys, do you see the omap-keypad interrupt
count grow in /proc/interrupts ?

You should also compile tornado-keypad.c with DEBUG defined to have
more kernel messages when keys are pressed.

For some key you will most probably notice changes in more than one
row/col. this makes the handling of some keys quite a pain (on the
tornado, the side keys are subject to this strange behaviour). On the
HTC Tornado, the direction keys (little joystick) are bound to gpios
76 80 81 82 and 83. you may find also some key are handled this way on
the HTC Wizard.

-- 
Nico
