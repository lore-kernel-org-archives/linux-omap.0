From: Ross Green <rgkernel@gmail.com>
Subject: Re: linux-4.5-rc1 TI pandboard-es wifi wlcore locks and reset
Date: Tue, 2 Feb 2016 16:41:13 +1100
Message-ID: <CANfgCY21zzinD48DOHaZdkGdDWpuAtJN1T8ofmdwM=P4f-7=Yw@mail.gmail.com>
References: <CANfgCY2nHh+vZ=JOimJdKKKs2JgM-c7m+3ePZtS3XhqyXNkDUQ@mail.gmail.com>
	<CANfgCY2zVXrLGv=YDpNvqhhoj5U2kgqZ_VV1EBPVK78grra84Q@mail.gmail.com>
	<20160202043448.GA9514@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160202043448.GA9514@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-wireless@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I have not tried a bisect yet, but I can confirm 4.4 and 4.4.1 work.
4.5-rc1 and 4.5-rc2 don't work.

It appears the tx to device times out and then just goes into reset of
the device to try and recover. A tx to device seems not to work.
although somehow firmware has been loaded to the device. So some types
of tx might work. Strange!

There were quite a few omap and omap4 plus patches that have come
along recently. so the culprit is in there somewhere. These machines
have been rock solid for quite some time.

If I get time, this evening, I'll see if I can give a bisect a try.

Regards,

Ross Green

On Tue, Feb 2, 2016 at 3:34 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Mon, Feb 01, 2016 at 11:38:38PM +1100, Ross Green wrote:
>> On Mon, Jan 25, 2016 at 11:47 PM, Ross Green <rgkernel@gmail.com> wrote:
>> > Just tried the new kernel release on faithful pandaboard es with the
>> > new 4.5-rc1 release.
>> >
>> > There is a problem with the wifi modules once the modules are loaded.
>> > Looks like the wifi firmware gets loaded put no response after that
>> > causing recovery action.
>> >
>> > the kernel 4.4 works quite happily with this board.
>> >
>> > Here is a dmesg dump in the attachment.
>> >
>> > Anyone have any ideas here?
>>
>> Just updated to the latest linux-4.5-rc2 and same result as rc1.
>>
>> The wireless module loads firmware and then stalls causing a reset of
>> the device and then continues to go through a stall and reset cycle.
>>
>> please find enclosed a copy of the dmesg output.
>>
>> Is there anyone else testing a pandaboard with linux-4.5-rc2?
>>
>> Just for completeness also tested the latest linux-4.4.1 kernel and
>> found no problems with the wireless modules.
>
> I can see the same problem with Nokia N950 (which uses spi connected
> wl1271). v4.4 + wl12xx spi DT patches from Uri Mashiach worked, v4.5
>  + the same patches does not work. I currently suspect 133b7326e960
> or 3719c17e1816 to be the culprit. I have not yet verified it, though.
>
> Have you tried to bisect the problem?
>
> -- Sebastian
