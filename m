From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Recent git kernels and OSK
Date: Tue, 03 Oct 2006 17:24:21 +0200
Message-ID: <452280A5.5080805@gmail.com>
References: <4521941B.2020102@balister.org> <45226BC5.9050201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45226BC5.9050201@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Philip Balister <philip@balister.org>, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Dirk Behme wrote:
> Philip Balister wrote:
...
>> Has anyone successfully booted a recent git kernel on the OSK?
...
> Just checked it. Seems that recent git on OSK is really broken. Enabling 
> lowlevel debug last thing I get is kernel command line output [3]. On my 
> last working kernel next output would be clock stuff [2]

> Any ideas?

Seems to me that it hangs in arch/arm/mach-omap1/clock.c in 
omap1_clk_init in

...
/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
reg = omap_readw(SOFT_REQ_REG) & (1 << 4);
omap_writew(reg, SOFT_REQ_REG);
if (!cpu_is_omap15xx())
   	omap_writew(0, SOFT_REQ_REG2);
...

If I remove "omap_writew(reg, SOFT_REQ_REG);" in code above 
it goes on booting but then crashes later in clk_disable() 
(as the comment above implies ;) ):

...
Initializing OMAP McBSP system
<6>omap_dsp_init() done
USB: hmc 16, usb0 2 wires
<6>i2c_omap i2c_omap.1: bus 0 rev2.2 at 100 kHz
<2>kernel BUG at arch/arm/plat-omap/clock.c:138!
<1>Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
...

If I'm correct here (not sure, can anybody reproduce this?) 
I really wonder why it may hang in (unchanged) write access 
to SOFT_REQ_REG?

Again, any ideas?

Cheers

Dirk
