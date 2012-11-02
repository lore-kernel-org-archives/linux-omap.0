From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH 0/3] capebus moving omap_devices to mach-omap2
Date: Fri, 2 Nov 2012 11:19:12 +0100
Message-ID: <FED5A9B3-836C-4284-AF61-5D81C65F3634@dominion.thruhere.net>
References: <CA+T6QPk-etCT7EzwGR-tP+JTab_m4Vywh9qgHG_HW-oXKgn_AQ@mail.gmail.com> <509391CA.9040408@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <509391CA.9040408@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Jason Kridner <jkridner@beagleboard.org>, Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "Porter, Matt" <mporter@ti.com>, Russ Dill <russ.dill@gmail.com>, khilman@ti.com
List-Id: linux-omap@vger.kernel.org


Op 2 nov. 2012, om 10:26 heeft "Cousson, Benoit" <b-cousson@ti.com> het volgende geschreven:

> Hi Jason,
> 
> On 11/1/2012 7:50 PM, Jason Kridner wrote:
>> My apologies for starting a new thread, but I don't have this thread
>> in my Inbox.
>> 
>> http://www.spinics.net/lists/linux-omap/msg81034.html
>> 
>> Tony Lindgren wrote:
>> 
>>> * Pantelis Antoniou <panto@xxxxxxxxxxxxxxxxxxxxxxx> [121031 15:02]:
>>>> 
>>>> So when device's node is 'disabled' of_platform_device_create_pdata()
>>>> will not create the device.
>>>> 
>>>> Now, of course it is possible to re-trigger the platform's probe method
>>>> to be called, and in fact I do so in the capebus patches.
>>> 
>>> You should fix this in generic way then rather than working
>>> around it in capebus. The same problem exists changing
>>> between different functionality for the shared pins,
>>> let's say between USB pins and UART pins if you want a
>>> serial debug console on some phone.
>> 
>> The current capebus solution goes a long way to fixing a huge issue
>> for BeagleBone users and I don't understand what seems to be a
>> push-back on principle. On BeagleBone capes, these conflicts cannot be
>> resolved early.
> 
> I don't think there is any push-back on the principle. It is a very valid problem that does not have any solution today.
> 
> The comments are more on the implementation.
> 
>> Do you have suggestions on some more generic method? It seems to me
>> the proposed capebus approach strikes a good balance.
> 
> Well, yeah, that's a generic DT issue, not a beagle-cape issue.
> We should not necessarily handle it by introducing some fake bus and some new binding like spi-dt / i2c-dt that does not mean anything in term of HW.
> 
> DT is about pure HW representation. Introducing some fake hierarchy to make SW life easier is not necessarily the good approach.

I see, pure HW. Let's look at this:

                gpio_keys {
                        compatible = "gpio-keys";
                        pinctrl-names = "default";
                        pinctrl-0 = <&bone_lcd3_cape_keys_00A0_pins>;

                        #address-cells = <1>;
                        #size-cells = <0>;

                        button@1 {
                                debounce_interval = <50>;
                                linux,code = <105>;
                                label = "left";
                                gpios = <&gpio2 16 0x0>;
                                gpio-key,wakeup;
                                autorepeat;
                        };

Is the "linux,code" pure hardware or have there already been exceptions to that rule?

regards,

Koen