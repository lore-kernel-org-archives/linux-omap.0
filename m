From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 2/4] ARM: dts: Add am335x-boneblack-wireless
Date: Tue, 27 Dec 2016 13:21:42 -0600
Message-ID: <CAOCHtYgqvkqZ3ag1EgCj29EB5C58Rf8Mfhp8h_1ECc7G5wZwJA@mail.gmail.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com>
 <20161227175837.28970-2-robertcnelson@gmail.com>
 <CAOCHtYjx+KD3iy1cssjCLN0xjXBGJFZ_e1Qw2zRGbV4=X0+bHg@mail.gmail.com>
 <20161227181429.GY4920@atomide.com> <20161227185645.GZ4920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161227185645.GZ4920@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jason Kridner <jkridner@beagleboard.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 27, 2016 at 12:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [161227 10:15]:
>> * Robert Nelson <robertcnelson@gmail.com> [161227 10:02]:
>> > On Tue, Dec 27, 2016 at 11:58 AM, Robert Nelson <robertcnelson@gmail.com> wrote:
>> > > BeagleBone Black Wireless is clone of the BeagleBone Black (BBB) with the Ethernet
>> > > replaced by a TI wl1835 wireless module.
>> > >
>> > > This board can be indentified by the BWAx value after A335BNLT (BBB) in the at24 eeprom:
>> > > BWAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 57 41 35  |.U3.A335BNLTBWA5|]
>> > >
>> > > http://beagleboard.org/black-wireless
>> > > https://github.com/beagleboard/beaglebone-black-wireless
>> > >
>> > > firmware: https://github.com/beagleboard/beaglebone-black-wireless/tree/master/firmware
>> >
>> > Tony, this firmware should be there shortly, i have a pull request
>> > setup for Jason:
>> >
>> > https://github.com/beagleboard/beaglebone-black-wireless/pull/5
>>
>> OK great, good to have these working out of the box with mainline
>> kernel :)
>
> Hmm so is this firmware file also something that should really be generated
> separately for each board? Or can the same one be used for all BBB black
> wireless and green boards?
>
> See the LKML thread "[PATCH 0/6] wl1251: Fix MAC address for Nokia N900",
> at least with wl1251 the calibration has been done for each n900 device
> during production.

>From what i can tell from TI, it should be good for all wl1835 modules
that use two wifi antenna's.

(that's the magic in: WL1835MOD_INI_C2PC.ini)

We are using the same wl18xx-conf.bin firmware for:

Original CircuitCo (now out of production) wl1835mod cape for BeagleBone Black
updated GateWay Cape from embest (this was meant to replace the wl1835mod cape)

SeeedStudio BeagleBone Green Wireless
BeagleBone Black Wireless

and the upcoming: (jason just sent me the next alpha, so i'll have a
patch after i verify all changes..)
BeagleBone Blue

For FCC testing, this was the same firmware (wl18xx-conf.bin) that
SeeedStudio used when they did the official FCC testing on the Green
Wireless.  I believe GHI Electronics did the same with the BeagleBone
Black Wireless, but i wasn't CC'ed in that email conversation, so i
can't say with 100% certainty..

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
