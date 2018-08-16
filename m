From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 7/7] mtd: rawnand: ams-delta: use GPIO API for data
 I/O
Date: Thu, 16 Aug 2018 09:39:49 +0200
Message-ID: <20180816093949.7f59519a@bbrezillon>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
        <20180813223448.21316-1-jmkrzyszt@gmail.com>
        <20180813223448.21316-8-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180813223448.21316-8-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 14 Aug 2018 00:34:48 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Don't readw()/writew() data directly from/to GPIO port which is under
> control of gpio-omap driver, use GPIO API instead.
> 
> Degrade of performance on Amstrad Delta is significant, can be
> recognized as a regression, that's why I'm still submitting this patch
> as RFC.
> 
> The driver should work with any 8+-bit bidirectional GPIO port, not
> only OMAP.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Exceprts fro timestamped boot logs showing performance degrade.
> Before the change:
> [    5.469426] Creating 6 MTD partitions on "ams-delta-nand":
> [    5.480909] 0x000000000000-0x000000380000 : "Kernel"
> [    5.502659] 0x000000380000-0x0000003c0000 : "u-boot"
> [    5.523055] 0x0000003c0000-0x000000400000 : "u-boot params"
> [    5.543612] 0x000000400000-0x000000440000 : "Amstrad LDR"
> [    5.564607] 0x000000440000-0x000001f40000 : "File system"
> [    5.601760] 0x000001f40000-0x000002000000 : "PBL reserved"
> [    5.624369] usbcore: registered new interface driver dm9601
> [    5.636233] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    5.649191] ohci-omap: OHCI OMAP driver
> [    5.660713] ohci ohci: OMAP OHCI
> [    5.671299] ohci ohci: new USB bus registered, assigned bus number 1
> [    5.686862] ohci ohci: irq 54, io mem 0xfffba000
> [    5.785897] hub 1-0:1.0: USB hub found
> [    5.797856] hub 1-0:1.0: 3 ports detected
> [    5.817576] usbcore: registered new interface driver usb-storage
> [    5.832551] ams-delta-serio ams-delta-serio: incomplete constraints, dummy supplies not allowed
> [    5.858588] ams-delta-serio ams-delta-serio: regulator request failed (-19)
> [    5.879312] input: omap-keypad as /devices/platform/omap-keypad/input/input0
> [    5.902490] omap_rtc omap_rtc: already running
> [    5.922929] omap_rtc omap_rtc: registered as rtc0
> [    5.945570] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
> [    5.976712] usbcore: registered new interface driver btusb
> [    6.007348] cx20442-codec cx20442-codec: incomplete constraints, dummy supplies not allowed
> [    6.040575] cx20442-codec cx20442-codec: failed to get POR supply (-19)
> [    6.060916] cx20442-codec cx20442-codec: ASoC: failed to probe component -517
> [    6.083486] ams-delta-audio ams-delta-audio: ASoC: failed to instantiate card -517
> [    6.121850] ams-delta-audio ams-delta-audio: snd_soc_register_card failed (-517)
> [    6.163047] NET: Registered protocol family 17
> [    6.182770] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    6.203517] Bluetooth: BNEP socket layer initialized
> [    6.283017] serial8250 serial8250.1: Linked as a consumer to regulator.1
> [    6.306113] usb 1-1: new full-speed USB device number 2 using ohci
> [    6.328825] clock: disabling unused clocks to save power
> [    6.350426] Skipping reset check for DSP domain clock "dsptim_ck"
> [    6.372272] Skipping reset check for DSP domain clock "dspxor_ck"
> [    6.393712] Skipping reset check for DSP domain clock "dspper_ck"
> [    6.428311] ams-delta-serio ams-delta-serio: Linked as a consumer to regulator.2
> [    6.467801] serio serio0: AMS DELTA keyboard adapter
> [    6.492511] cx20442-codec cx20442-codec: Linked as a consumer to regulator.1
> [    6.527382] ams-delta-audio ams-delta-audio: cx20442-voice <-> omap-mcbsp.1 mapping ok
> [    6.577387] input: AMS_DELTA hook_switch as /devices/platform/ams-delta-audio/sound/card0/input1
> [    6.627497] input: AT Raw Set 2 keyboard as /devices/platform/ams-delta-serio/serio0/input/input2
> [    6.673663] omap_rtc omap_rtc: setting system clock to 2013-02-09 07:22:13 UTC (1360394533)
> [    6.715895] modem_nreset: incomplete constraints, leaving on
> [    6.738677] ALSA device list:
> [    6.758398]   #0: AMS_DELTA
> [    7.036234] dm9601 1-1:1.0 eth0: register 'dm9601' at usb-ohci-1, Davicom DM96xx USB 10/100 Ethernet, 00:60:6e:00:00:11
> [  133.860599] random: crng init done
> [  138.275853] VFS: Mounted root (jffs2 filesystem) on device 31:4.
> 
> After the change:
> [    6.261107] Creating 6 MTD partitions on "ams-delta-nand":
> [    6.272046] 0x000000000000-0x000000380000 : "Kernel"
> [    6.294436] 0x000000380000-0x0000003c0000 : "u-boot"
> [    6.314454] 0x0000003c0000-0x000000400000 : "u-boot params"
> [    6.335353] 0x000000400000-0x000000440000 : "Amstrad LDR"
> [    6.356669] 0x000000440000-0x000001f40000 : "File system"
> [    6.393713] 0x000001f40000-0x000002000000 : "PBL reserved"
> [    6.416771] usbcore: registered new interface driver dm9601
> [    6.428631] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    6.441533] ohci-omap: OHCI OMAP driver
> [    6.452758] ohci ohci: OMAP OHCI
> [    6.463300] ohci ohci: new USB bus registered, assigned bus number 1
> [    6.478817] ohci ohci: irq 54, io mem 0xfffba000
> [    6.580520] hub 1-0:1.0: USB hub found
> [    6.592424] hub 1-0:1.0: 3 ports detected
> [    6.612363] usbcore: registered new interface driver usb-storage
> [    6.627358] ams-delta-serio ams-delta-serio: incomplete constraints, dummy supplies not allowed
> [    6.653296] ams-delta-serio ams-delta-serio: regulator request failed (-19)
> [    6.674219] input: omap-keypad as /devices/platform/omap-keypad/input/input0
> [    6.697910] omap_rtc omap_rtc: already running
> [    6.718376] omap_rtc omap_rtc: registered as rtc0
> [    6.740942] softdog: initialized. soft_noboot=0 soft_margin=60 sec soft_panic=0 (nowayout=0)
> [    6.772085] usbcore: registered new interface driver btusb
> [    6.803187] cx20442-codec cx20442-codec: incomplete constraints, dummy supplies not allowed
> [    6.836386] cx20442-codec cx20442-codec: failed to get POR supply (-19)
> [    6.856730] cx20442-codec cx20442-codec: ASoC: failed to probe component -517
> [    6.879234] ams-delta-audio ams-delta-audio: ASoC: failed to instantiate card -517
> [    6.917325] ams-delta-audio ams-delta-audio: snd_soc_register_card failed (-517)
> [    6.958519] NET: Registered protocol family 17
> [    6.978224] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    6.998989] Bluetooth: BNEP socket layer initialized
> [    7.077593] serial8250 serial8250.1: Linked as a consumer to regulator.1
> [    7.100678] usb 1-1: new full-speed USB device number 2 using ohci
> [    7.123429] clock: disabling unused clocks to save power
> [    7.145074] Skipping reset check for DSP domain clock "dsptim_ck"
> [    7.166983] Skipping reset check for DSP domain clock "dspxor_ck"
> [    7.188434] Skipping reset check for DSP domain clock "dspper_ck"
> [    7.223321] ams-delta-serio ams-delta-serio: Linked as a consumer to regulator.2
> [    7.262882] serio serio0: AMS DELTA keyboard adapter
> [    7.287656] cx20442-codec cx20442-codec: Linked as a consumer to regulator.1
> [    7.322824] ams-delta-audio ams-delta-audio: cx20442-voice <-> omap-mcbsp.1 mapping ok
> [    7.373165] input: AMS_DELTA hook_switch as /devices/platform/ams-delta-audio/sound/card0/input1
> [    7.423520] input: AT Raw Set 2 keyboard as /devices/platform/ams-delta-serio/serio0/input/input2
> [    7.469578] omap_rtc omap_rtc: setting system clock to 2013-02-09 07:34:10 UTC (1360395250)
> [    7.511830] modem_nreset: incomplete constraints, leaving on
> [    7.534812] ALSA device list:
> [    7.554541]   #0: AMS_DELTA
> [    7.971899] dm9601 1-1:1.0 eth0: register 'dm9601' at usb-ohci-1, Davicom DM96xx USB 10/100 Ethernet, 00:60:6e:00:00:11
> [  133.935226] random: crng init done
> [  320.764645] VFS: Mounted root (jffs2 filesystem) on device 31:4.
> 
> I think most of the overhead is in iterations performed both inside and
>  outside get/set array functions:
> - building a mask for get_multiple() and transfering results to value array
>  in gpiod_get_array_value_complex(), then again from the array by a caller, 
> - building a value array by the caller, the building a mask and tranferiing
>  values from array to bitmap for .set_multiple() in
>  gpiod_set_array_value_comples().

Sorry but we need more than just speculations here, and using
bootlog timestamps is clearly not enough to prove any of these
suppositions. You'll have to setup ftrace/perf and trigger read/write
requests (using nanddump/nandwrite) to figure out where the overhead
comes from.

Also, I'd recommend keeping this patch for the series changing the GPIO
API.
