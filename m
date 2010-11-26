From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Sat, 27 Nov 2010 00:18:55 +0200
Message-ID: <AANLkTi=h3gPN63NKKJ4wjumKNx9qDtxCKvOSbtRkr1wx@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
 <1290526740-27624-2-git-send-email-ohad@wizery.com> <20101126045912.GC6598@lixom.net>
 <AANLkTin5Tfcuy0WcHJ22rWC8niwZCj8SZAMKLz0p9jwc@mail.gmail.com>
 <20101126091832.GE9310@n2100.arm.linux.org.uk> <AANLkTimS-cSi1B5LdtwhJWhKDuFKOYG1j_p-iQiH=zRe@mail.gmail.com>
 <20101126104548.GG9310@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61779 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab0KZWTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 17:19:16 -0500
In-Reply-To: <20101126104548.GG9310@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@deeprootsystems.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Nov 26, 2010 at 12:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 26, 2010 at 12:16:39PM +0200, Ohad Ben-Cohen wrote:
>> On Fri, Nov 26, 2010 at 11:18 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Nov 26, 2010 at 10:53:10AM +0200, Ohad Ben-Cohen wrote:
>> >> >> +int __hwspin_trylock(struct hwspinlock *hwlock, int mode, uns=
igned long *flags)
>> >> >> +{
>> >> >> + =A0 =A0 int ret;
>> >> >> +
>> >> >> + =A0 =A0 if (unlikely(!hwlock)) {
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("invalid hwlock\n");
>> >> >
>> >> > These kind of errors can get very spammy for buggy drivers.
>> >>
>> >> Yeah, but that's the purpose - I want to catch such egregious dri=
vers
>> >> who try to crash the kernel.
>> >
>> > That can be better - because you get a backtrace, and it causes pe=
ople
>> > to report the problem rather than just ignore it. =A0It may also p=
revent
>> > the driver author releasing his code (as it won't work on their
>> > initial testing.)
>> >
>> ...
>> >
>> > If it's "extremely buggy behaviour" then the drivers deserve to cr=
ash.
>> > Such stuff should cause them not to get out the door. =A0A simple =
printk
>> > with an error return can just be ignored.
>>
>> I like this approach too, but recently we had a few privilege
>> escalation exploits which involved NULL dereference kernel bugs
>> (process context mapped address 0 despite a positive mmap_min_addr).
>
> That's not a concern on ARM.

Good point, thanks. The problem is that we can't rely on that in a
generic interface.

I remember a recent discussion where you suggested to have a
conditional check that will be compiled out on architectures where we
can rely on NULL dereference to produce an oops; something like that
can be handy here.

But then there's the other (quite reasonable) claim that says we
shouldn't crash the machine because of a non fatal bug: if a crappy
driver messes up, the user (not the developer) will most probably
prefer the machine to keep running with degraded functionality rather
than boot.

=2E.. which gets us back to pr_err.

> at virtual address 0 does not rely on mmap_min_addr - in fact, we can=
't
> use this as it's tuneable to enforce this requirement.
>
> It's highly illegal on ARM - as ARM CPUs without vector remap place t=
he
> hardware vectors at virtual address 0, and as such allowing the user =
to
> map a page there will take the system down. =A0So we have this code i=
n the
> mmap path:
>
> #define arch_mmap_check(addr, len, flags) \
> =A0 =A0 =A0 =A0(((flags) & MAP_FIXED && (addr) < FIRST_USER_ADDRESS) =
? -EINVAL : 0)
>
> which prevents any attempt what so ever, irrespective of the mmap_min=
_addr
> setting, to create a userspace induced mapping at address 0.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
