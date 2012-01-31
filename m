From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Tue, 31 Jan 2012 12:10:12 +0000
Message-ID: <CAHkRjk7_giYNk5djA_kevxo0YqvGJBwJydQXvtMy7AKmWv8XEA@mail.gmail.com>
References: <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
 <4F277A6E.9070107@ti.com> <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com>
 <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
 <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com> <20120131101000.GA1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:47730 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab2AaMKe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 07:10:34 -0500
Received: by qafk1 with SMTP id k1so87390qaf.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 04:10:33 -0800 (PST)
In-Reply-To: <20120131101000.GA1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Aneesh V <aneesh@ti.com>

On 31 January 2012 10:10, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 31, 2012 at 09:53:25AM +0000, Catalin Marinas wrote:
>> Maybe we could factor out the CPU-specific settings from proc-v*.S
>> into a separate arch/arm/boot/preload directory. We keep proc-v*.S
>> entirely generic and the implementation-defined bits setting in the
>> preload code. You could have an option to link the preload with the
>> kernel but we could recommend that people run this code from
>> boot-loader before invoking the kernel.
>
> You've seen the resistance from uboot to stuff we do with the kernel,
> this will be no different. =A0There's also quite a number of boot loa=
ders
> out there which aren't capable of running a binary, returning and the=
n
> loading and running the kernel.
>
> Plus, of course, it's far from friendly towards TFTP setups.

=46or platforms that can't/don't want to modify the boot loader, they
could wrap (prepend) the kernel image with the preload code and they
just use that to kexec a distro generic kernel. I know it can go to
3-4 stages boot process on some platforms but you have the advantage
of a generic kernel image. If SoC vendors don't like the lengthier
boot process, they have the option of modifying the boot loader and
include the preload code that the kernel provides (or find a way to
load it together with the kernel at boot-time).

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
