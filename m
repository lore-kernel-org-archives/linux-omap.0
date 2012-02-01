From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Wed, 1 Feb 2012 12:42:12 +0530
Message-ID: <CAMQu2gw1T_PR5fQAXvD2dxy7zY8WXcBaFAtqnRsZEYhNnFZung@mail.gmail.com>
References: <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <WC20120120085711.330803@terrafix.co.uk> <20120127173029.GA3281@arm.com>
 <4F277A6E.9070107@ti.com> <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com>
 <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
 <20120131095606.GA889@n2100.arm.linux.org.uk> <CAMQu2gwG_JwPMzV0v2hedvDz=HHq0SNbbH+Zapyd8fJt47kjGQ@mail.gmail.com>
 <alpine.LFD.2.02.1201311315420.2759@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:45255 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753550Ab2BAHMd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Feb 2012 02:12:33 -0500
Received: by qcsu28 with SMTP id u28so584048qcs.22
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 23:12:32 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1201311315420.2759@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, Jan 31, 2012 at 11:57 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:

[...]

>> I also understand that patching early common code is going to be tri=
cky
>> and of-course against the single zImage.
>>
>> So the option mentioned by Nicolas and Catalin about 1:1 mapping
>> and configuring the registers in platform specific code was looking
>> a way forward. So was asking more questions about whether this can
>> work in all cases. Specifically for A15.
>
> So far this is apparently your best option. =A0And luckily the code t=
o
> create a 1:1 mapping, turn off MMU, then turn MMU back on and tear do=
wn
> the 1:1 mapping already exists. =A0All you need to do is to insert th=
e
> cache workaround activation in the middle of that instead of shutting
> the CPU down.
>
thanks.

>> As per Catalin's email, it is best to handle those cases before MMU =
is
>> enabled with boot-monitor or pre-load code.
>
> These days bootloaders are turning the MMU on for themselves, so you'=
ll
> need pre-load code for the bootloader already. =A0Either that, or the
> issue is not necessarily _that_ critical in which case you can afford=
 to
> enable your workaround a bit later during the kernel boot.
>
This is indeed a good point.
The mainline u-boot(denx) now a days have MMU support so we need to hav=
e
the necessary WA before that code anyways.

We will attempt the 1:1 mapping option as well but to be 100 % safe for
the previous 3 statges of MMU ON ( 1. Bootloader, 2. De-compressor
and 3. Kernel setup), looks like moving all of this security settings
before all 3 stages is most appropriate.

Thanks for the good discussion.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
