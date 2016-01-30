From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Sat, 30 Jan 2016 21:14:52 +0100
Message-ID: <20160130201452.GC30429@amd>
References: <20160123121022.GB12497@amd>
 <20160125163332.GT19432@atomide.com>
 <20160126140010.GA29723@amd>
 <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160130200244.GA30429@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On Sat 2016-01-30 21:02:45, Pavel Machek wrote:
> Hi!
> 
> > > ffdffe8d 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200072
> > > 0000000d 48004a28 (fa004a28) cm_idlest3_core
> > > 
> > > cm_idlest1_core changes periodicall often, to 00218072. The rest seems
> > > constant.
> > 
> > For cm_idlest1_core 42 is the answer.. Here you have bits 4 and 5
> > blocking which is for OTG and it's PHY. That's a known issue with
> > musb and setting pm_runtime_irq_safe() on the MUSB parent.
> > 
> > If you do rmmod omap2430 and phy-twl4030usb chances are the LEDs will
> > start going off assuming the McSPI bit goes low with WLAN idling.
> 
> Ok, so I tried to compile kernel without omap2430/phy-twl4030usb
> . That did not help. So I thought, ok, maybe rmmod is needed to
> trigger some powersaving? But that is not exactly easy to do:
> 
> pavel@n900:/my/tui/ofone$ sudo insmod /my/modules/omap2430.ko
> pavel@n900:/my/tui/ofone$ sudo insmod /my/modules/phy-twl4030-usb.ko
> pavel@n900:/my/tui/ofone$ sudo rmmod phy-twl4030-usb.ko
> Error: Module phy_twl4030_usb is in use
> pavel@n900:/my/tui/ofone$
> 
> Any ideas what jumps to use the modules? Charger code?

I tried a kernel without charger code, and no luck, rmmod fails the
same way. dmesg says:
[  111.093078] wlan0: authenticated
[  111.097442] wlan0: associate with 06:27:22:f9:10:6a (try 1/3)
[  111.104553] wlan0: RX AssocResp from 06:27:22:f9:10:6a (capab=0x421
status=0 aid=2)
[  111.104705] wlan0: AP has invalid WMM params (AIFSN=1 for ACI 2),
will use 2
[  111.104736] wlan0: AP has invalid WMM params (AIFSN=1 for ACI 3),
will use 2
[  111.256652] wlan0: associated
[  184.681427] HS USB OTG: no transceiver configured
[  184.681488] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
with status -517
[  184.681976] HS USB OTG: no transceiver configured
[  184.682006] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
with status -517
[  187.690338] twl4030_usb 48070000.i2c:twl@48:twl4030-usb:
Initialized TWL4030 USB module
[  187.698303] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk
combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
[  187.698333] musb-hdrc: MHDRC RTL version 1.400
[  187.698333] musb-hdrc: setup fifo_mode 4
[  187.698394] musb-hdrc: 28/31 max ep, 16384/16384 memory
pavel@n900:/my/tui/ofone$

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
