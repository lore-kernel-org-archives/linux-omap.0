From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Fri, 12 Jul 2013 12:52:04 +0200
Message-ID: <51DFDFD4.3040900@denx.de>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
 <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com>
 <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com>
 <51DEA7F1.1050902@denx.de> <51DEC2CE.70400@ti.com> <51DED076.3040000@denx.de>
 <51DEF0DE.4050607@denx.de> <51DFC92F.1050701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51DFC92F.1050701@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Roger,

On 07/12/2013 11:15 AM, Roger Quadros wrote:
>>> Good idea. I'm currently using a "dirty" local version. I'll try to
>>> switch to an officially available version tomorrow. And send you the
>>> version/git id.
>>
>> I updated my U-Boot to the following version: Based on mainline git
>> commit ID 225fd8c. Only this patch added:
>>
>> http://patchwork.ozlabs.org/patch/256702/
>>
>> This is needed for USB to work in U-Boot. Otherwise my external USB
>> SMSC95xx will not be detected in U-Boot.
> 
> I can only test on beagle-xm (which is also rev. C2) with integrated SMSC ethernet chip
> as I don't have an external USB-ethernet adapter.

Too bad. This difference in boards makes the tests a bit less
meaningful. Is there really no USB-ethernet adapter somewhere in your
department (perhaps a non-SMSC95xx might serve as well?)? I might
send/order you one if necessary. ;)

> The above commit doesn't work well for beagle-xm,

Why is this? What does happen? Does U-Boot not boot up to the prompt?
Please send me a log.

> so my u-boot is on tag v2013.04
> and you don't need that additional patch.
> 
> Can you please retest on it? Thanks.

Done, please see below.

> You will need to set "usbethaddr" before starting USB else SMSC will not work.
> e.g.
> 	setenv usbethaddr A6:66:4D:B0:69:04

I don't have a beagle-xm, only my beable. And my U-Boot network setup is
already working, thanks.

> Also could you please increase the Linux console message verbosity to debug (8), so that
> all kernel messages are visible in the log? If it spits out something more than what you
> sent last time then do send it to me.

I added "ignore_loglevel" to the cmdline. But I cannot see anything
interesting that has not been there before with "debug" as well.

> Let's first sort out the beagle-xm problem, then we can see about old beagle.

Okay, I tested again with U-Boot v2013.01 plus my SMSC patch. Same
problem. NFS booting/mounting hangs at some time.

Thanks,
Stefan
