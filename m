From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: OMAP baseline test results for v3.8-rc3
Date: Mon, 14 Jan 2013 22:46:54 +0200
Message-ID: <20130114204654.GB18224@blackmetal.musicnaut.iki.fi>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
 <20130114184018.GA18224@blackmetal.musicnaut.iki.fi>
 <20130114191459.GA9402@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130114191459.GA9402@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 14, 2013 at 09:14:59PM +0200, Felipe Balbi wrote:
> On Mon, Jan 14, 2013 at 08:40:18PM +0200, Aaro Koskinen wrote:
> > On Mon, Jan 14, 2013 at 05:59:12PM +0000, Paul Walmsley wrote:
> > > Here are some basic OMAP test results for Linux v3.8-rc3.
> > > Logs and other details at:
> > > 
> > >     http://www.pwsan.com/omap/testlogs/test_v3.8-rc3/20130109222058/
> > > 
> > > 
> > > Test summary
> > > ------------
> > > 
> > > Boot to userspace:
> > >     Pass ( 9/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
> > >   	   	  3730beaglexm, 37xxevm, 4430es2panda, 5912osk,
> > > 		  4460pandaes
> > >     FAIL ( 2/11): am335xbone, cmt3517 
> > 
> > N900 boot is unstable again, I2C issues are back.
> 
> damn!
> 
> > Boot succeeds and fails randomly. Let's see if this can be bisected.
> > The same kernel works on N950.
> 
> fair enough, it might be something related to some errata fix which
> might have been missed. Can you apply this small patch just so I know if
> there is something pending in CNT reg ?

[    0.207946] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.208129] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.209350] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
[    1.218749] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    1.218811] omap_i2c omap_i2c.1: SA 0049 CON 9602 CNT 0004
[    2.234374] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    2.234436] omap_i2c omap_i2c.1: SA 0049 CON 9602 CNT 0004
[    2.234466] twl: Write failed (mod 2, reg 0x12 count 1)
[    3.249999] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    3.250030] omap_i2c omap_i2c.1: SA 0049 CON 9602 CNT 0004
[    3.250061] twl: Write failed (mod 2, reg 0x12 count 1)

> you might also want to try merging my latest i2c patches, which missed
> the merge window, as they might help with this issue too.
> 
> The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:
> 
>   Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-deferred-STP

I could not reproduce the issue with these. Tested around 20 boots.
There's a noticeable delay (over 4 secs!) around where I2C is initialized
and used for the first time, but no errors and the boot completes:

[    0.187530] SCSI subsystem initialized
[    0.188110] usbcore: registered new interface driver usbfs
[    0.188415] usbcore: registered new interface driver hub
[    0.188781] usbcore: registered new device driver usb
[    0.189453] musb-omap2430 musb-omap2430: invalid resource
[    4.296905] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    4.297088] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    4.329010] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
[    4.470123] VUSB1V5: 1500 mV normal standby
[    4.470916] VUSB1V8: 1800 mV normal standby

A.
