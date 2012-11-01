From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Thu, 1 Nov 2012 14:50:17 -0400
Message-ID: <CA+T6QPk-etCT7EzwGR-tP+JTab_m4Vywh9qgHG_HW-oXKgn_AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: b-cousson@ti.com, Koen Kooi <koen@dominion.thruhere.net>, paul@pwsan.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "Porter, Matt" <mporter@ti.com>, Russ Dill <russ.dill@gmail.com>, khilman@ti.com
List-Id: linux-omap@vger.kernel.org

My apologies for starting a new thread, but I don't have this thread
in my Inbox.

http://www.spinics.net/lists/linux-omap/msg81034.html

Tony Lindgren wrote:

>* Pantelis Antoniou <panto@xxxxxxxxxxxxxxxxxxxxxxx> [121031 15:02]:
>>
>> So when device's node is 'disabled' of_platform_device_create_pdata()
>> will not create the device.
>>
>> Now, of course it is possible to re-trigger the platform's probe method
>> to be called, and in fact I do so in the capebus patches.
>
>You should fix this in generic way then rather than working
>around it in capebus. The same problem exists changing
>between different functionality for the shared pins,
>let's say between USB pins and UART pins if you want a
>serial debug console on some phone.

The current capebus solution goes a long way to fixing a huge issue
for BeagleBone users and I don't understand what seems to be a
push-back on principle. On BeagleBone capes, these conflicts cannot be
resolved early.

Do you have suggestions on some more generic method? It seems to me
the proposed capebus approach strikes a good balance.
