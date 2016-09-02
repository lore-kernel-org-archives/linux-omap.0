From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
Date: Fri, 2 Sep 2016 10:01:01 -0500
Message-ID: <cc8e50a7-a8f5-5ffb-9eae-26a46a8230dc@ti.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
 <dd74f5e1-304f-661e-7fd9-f5f81bcfc55e@ti.com>
 <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>, Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Jason Kridner <jkridner@beagleboard.org>, "beagleboard-x15@googlegroups.com" <beagleboard-x15@googlegroups.com>
List-Id: linux-omap@vger.kernel.org

+ x15 list ( see https://patchwork.kernel.org/patch/9310617/)
On 09/02/2016 08:52 AM, Robert Nelson wrote:
> On Fri, Sep 2, 2016 at 5:41 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> + Robert Nelson
>>
>> On Friday 02 September 2016 02:36 PM, Nishanth Menon wrote:
>>
>> I understand that there are existing users of A2 boards and so we simply
>> cannot remove support for those boards (at least yet).
>>
>> But given the small numbers of A2 boards, its also quite likely that we
>> will not have enough test coverage for those boards. Especially as years
>> pass and there are fewer and fewer people with access to working A2 boards.
>
> I have a A1, A2 and a B1, that i use for testing for
> beagleboard.org...  The A1 use to be ssh-accessible for developers,
> but since moving to my new house, I haven't "yet" got that one setup
> for developers.  Right now i'm using the A2 & B1 for development of
> our default images.
>

That said, A1 was never intended to be supported longer term - there 
were key uart changes and tons of fixes done on top of A1 - and I 
think you might be one of the last few people to use it. That said, 
there were so many "mods" of A1, that we stopped even keeping track of 
it and upstream kernel or bootloader as it exists today wont even boot 
up on the A1. nutshell: lets keep A1 away from the discussion, unless 
we have a strong case for the same.

> Jason Kridner also has a number of boards
>
>> Given that, aren't we increasing the chance of A2 breakage by creating a
>> common file - this essentially necessitates that any change to
>> am57xx-beagle-x15-common.dtsi is also tested on A2.
>>
>> Instead, it seems to be easier for maintenance and safer overall if the
>> older version has a file of its own which can be kept alone.
>>
>> Also, how about renaming the existing dts to am57xx-beagle-x15-reva2.dts
>> and let the production version be called am57xx-beagle-x15.dts? Surely
>> this will cause some inconvenience to A2 users. But there are few users
>> of those and it might be more intuitive for the majority users if the
>> file for production version is without a specific version string
>> attached. Just a thought though, not sure about it myself either.
>
> Nak, let's NOT do that to A2 users.
>
> The am57xx-beagle-x15.dts went mainline in v3.19, u-boot installed on
> devices would need to be updated and this would make bisecting a pain.
> ;)

Yep, that was my rationale of keeping x15.dts as is for A2 users.

I am going to assume that all agree to leaving x15.dts = A2 (I should 
really update the comments to indicate that in the patch for a future 
user), and x15-revb1 to be the new one.


>
> Side note:
>
> A1/A2 boards (most i believe) did not have the eeprom programmed with an ID.

My understanding was, most A2s should have the eeproms programmed esp 
the ones that are available to purchase - but then, even if NOT, the 
default u-boot behavior is to assume "when eeprom not programmed, 
think it is A2".. so we are pretty much covered both ways.

> Where as B1's have a default eeprom for identification:
>
> https://github.com/RobertCNelson/boot-scripts/blob/master/device/x15/X15_B1-eeprom.dump

Cool.. at least I now know where to find them :D

-- 
Regards,
Nishanth Menon
