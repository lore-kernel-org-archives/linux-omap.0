From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
Date: Fri, 26 Nov 2010 12:16:39 +0200
Message-ID: <AANLkTimS-cSi1B5LdtwhJWhKDuFKOYG1j_p-iQiH=zRe@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
 <1290526740-27624-2-git-send-email-ohad@wizery.com> <20101126045912.GC6598@lixom.net>
 <AANLkTin5Tfcuy0WcHJ22rWC8niwZCj8SZAMKLz0p9jwc@mail.gmail.com> <20101126091832.GE9310@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101126091832.GE9310@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@deeprootsystems.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 26, 2010 at 11:18 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 26, 2010 at 10:53:10AM +0200, Ohad Ben-Cohen wrote:
>> >> +int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsign=
ed long *flags)
>> >> +{
>> >> + =A0 =A0 int ret;
>> >> +
>> >> + =A0 =A0 if (unlikely(!hwlock)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("invalid hwlock\n");
>> >
>> > These kind of errors can get very spammy for buggy drivers.
>>
>> Yeah, but that's the purpose - I want to catch such egregious driver=
s
>> who try to crash the kernel.
>
> That can be better - because you get a backtrace, and it causes peopl=
e
> to report the problem rather than just ignore it. =A0It may also prev=
ent
> the driver author releasing his code (as it won't work on their
> initial testing.)
>
=2E..
>
> If it's "extremely buggy behaviour" then the drivers deserve to crash=
=2E
> Such stuff should cause them not to get out the door. =A0A simple pri=
ntk
> with an error return can just be ignored.

I like this approach too, but recently we had a few privilege
escalation exploits which involved NULL dereference kernel bugs
(process context mapped address 0 despite a positive mmap_min_addr).

Since we can't rely on the oops to always happen, I decided not to
omit the NULL checks.

>
