From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Thu, 2 Feb 2012 15:10:47 +0000
Message-ID: <CAHkRjk4526ubsEJn94gk__07wXx5YjSejcRzLSf5_VALEtvrqA@mail.gmail.com>
References: <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
 <4F277A6E.9070107@ti.com> <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com>
 <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
 <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com>
 <alpine.LFD.2.02.1201311253460.2759@xanadu.home> <CAHkRjk690R951NUDC_erNsBtbmtrM-nPjY2gR=Tf-sW4qXX7ww@mail.gmail.com>
 <20120202144942.GD1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60447 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab2BBPLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 10:11:10 -0500
Received: by qcqw6 with SMTP id w6so1438446qcq.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Feb 2012 07:11:09 -0800 (PST)
In-Reply-To: <20120202144942.GD1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Aneesh V <aneesh@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 2 February 2012 14:49, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 02, 2012 at 02:32:03PM +0000, Catalin Marinas wrote:
>> We could do the same and move the bit enabling to separate repositor=
y :).
>
> We must certainly could do but that doesn't get around the errata
> issues when you have things before the kernel (or before these blobs)
> enabling things like the caches and MMU.

That was my original point - allow such code to be built into a blob
that the boot loader can execute. But I got your point that not all
boot loaders are able to execute two binary images.

> The only answer which assures complete system stability is for the
> earliest reasonable point in the booting sequence to handle the errat=
a,
> before any of the potential errata scenarios occur. =A0For things lik=
e
> working around L2 cache problems, that means before the L2 cache is
> enabled for the first time.
>
> If the boot loader enables the L2 cache, then _it_ has to take care o=
f
> the errata before it enables the L2 cache, and not some blob that it
> loads.
>
> If the boot loader enables the cache, and there are workarounds for b=
uggy
> cache behaviour, then the boot loader has to implement those errata
> itself.

But as it was pointed out already, many of those are very rare
conditions that you can't actually trigger during the boot sequence.
There are other errata that require SMP for example and the boot
loader (or decompressor) doesn't care.

> So, I propose that we rip out all those work-arounds that are just
> 'set this bit in some register' at boot time from the kernel itself
> right now, and reconsider how these are handled.

Just don't remove them until we agree where we should *move* them.
They are still good documentation so far. I would say just disable the
workarounds in the kernel .config until we decide.

> But, having errata for things like DMB being faulty in the kernel aft=
er
> things like the boot loader will _already_ have had to issue DMB
> instructions, or for failing I-cache invalidate after we've already d=
one
> some I-cache invalidates (eg, boot loader or the decompressor) is qui=
te
> absurd.

As I said, most errata are really hard to trigger (but ARM cannot
guarantee that it is impossible, so they need to be published).

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
