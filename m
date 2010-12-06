From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/2] ARM: implement support for read-mostly sections
Date: Mon, 6 Dec 2010 17:51:39 +0000
Message-ID: <AANLkTincr7dbFuXmAFo2S-mGe6FoR0V4cFp+6XVSmF3J@mail.gmail.com>
References: <20101205114257.GD9138@n2100.arm.linux.org.uk>
	<E1PPCzx-0004yo-MJ@rmk-PC.arm.linux.org.uk>
	<AANLkTin5HiPRd=SF_kdvEnZjV7C3J+6MXKQL02zKKtp=@mail.gmail.com>
	<20101205230434.GI9138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32982 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0LFRvk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 12:51:40 -0500
Received: by iwn9 with SMTP id 9so474875iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 09:51:40 -0800 (PST)
In-Reply-To: <20101205230434.GI9138@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 5 December 2010 23:04, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Dec 05, 2010 at 10:18:27PM +0000, Catalin Marinas wrote:
>> On 5 December 2010 11:43, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlin=
ux.lds.S
>> > index cead889..1581f6d 100644
>> > --- a/arch/arm/kernel/vmlinux.lds.S
>> > +++ b/arch/arm/kernel/vmlinux.lds.S
>> > @@ -167,6 +167,7 @@ SECTIONS
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NOSAVE_DATA
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CACHELINE_A=
LIGNED_DATA(32)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 READ_MOSTLY_DAT=
A(32)
>>
>> Should we change the alignments to 64?
>
> When we have some way to tell vmlinux.lds.S what the cache line size =
is.

I haven't tried but can we not use CONFIG_ARM_L1_CACHE_SHIFT?

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
