From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Sun, 19 Oct 2014 13:48:12 -0700
Message-ID: <CAOesGMhokPjb8eU67t9NFOqPU=dBTuFBJ=aC+99i2UvdX_D8Hw@mail.gmail.com>
References: <20141009210715.GH25729@saruman>
	<20141010135743.GB31348@saruman>
	<20141010162531.GL12379@n2100.arm.linux.org.uk>
	<54388B81.5020306@mentor.com>
	<063D6719AE5E284EB5DD2968C1650D6D174C996E@AcuExch.aculab.com>
	<20141013114307.GO12379@n2100.arm.linux.org.uk>
	<20141014020640.GB25433@kroah.com>
	<20141015212310.GP12379@n2100.arm.linux.org.uk>
	<20141015212513.GA3247@n2100.arm.linux.org.uk>
	<20141019095416.GT12379@n2100.arm.linux.org.uk>
	<20141019152801.GC5189@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141019152801.GC5189@saruman>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nathan Lynch <Nathan_Lynch-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org" <josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org>, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, David Laight <David.Laight-JxhZ9S5GRejQT0dZR+AlfA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Johannes Weiner <hannes-druUgvl0LCNAfugRpC6u6w@public.gmane.org>, Sasha Levin <sasha.levin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 19, 2014 at 8:28 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Sun, Oct 19, 2014 at 10:54:16AM +0100, Russell King - ARM Linux wrote:
>> On Wed, Oct 15, 2014 at 10:25:13PM +0100, Russell King - ARM Linux wrote:
>> > On Wed, Oct 15, 2014 at 10:23:10PM +0100, Russell King - ARM Linux wrote:
>> > > As I said, I have a patch in progress, but it seems that there needed
>> > > to be some discussion about exactly which compiler versions are affected.
>> > > It seems that it's not as trivial as looking at the GCC bug entry.
>> >
>> > ... and in any case, it has been a known bug for well over a year now,
>> > and it seems that it doesn't affect _that_ many people.  So taking some
>> > extra time to get it properly correct is the _right_ thing to do.
>>
>> Well, this is just great.  Pushing out the change which blacklists these
>> compilers takes out Olof's kernel build system...
>>
>> Things are not as trivial as they seem.
>
> Maybe Olof just needs to update his compiler. Olof ?

Yep, doing a run with 4.9.1 to see how it looks. In the past, 4.9 has
been really noisy with warnings, maybe most of them have been fixed by
now.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
