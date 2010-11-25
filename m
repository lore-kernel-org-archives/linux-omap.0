From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH 1/7] [OMAP] gpio: Allow for extended GPIO space
Date: Thu, 25 Nov 2010 08:33:16 -0700
Message-ID: <AANLkTinCxh39iLjVnmc0=VVE8aQahpo9XMjg0B7CiffW@mail.gmail.com>
References: <1279598741-18607-1-git-send-email-darkstar6262@gmail.com>
 <1279598741-18607-2-git-send-email-darkstar6262@gmail.com> <20100802105150.GB12293@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50143 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0KYPdi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 10:33:38 -0500
Received: by wyb28 with SMTP id 28so982688wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 07:33:36 -0800 (PST)
In-Reply-To: <20100802105150.GB12293@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Mon, Aug 2, 2010 at 4:51 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Cory Maccarrone <darkstar6262@gmail.com> [100720 06:59]:
>> This change copies from the s3c24xx the ability for a board to speci=
fy
>> if it wants 64 or 128 more GPIOs in the board space. =C2=A0This is n=
eeded
>> to get the HTC Herald board's extra htcpld gpios to work as actual
>> gpios.
>
> <snip>
>
>> +config OMAP_GPIO_EXTRA
>> + =C2=A0 =C2=A0 int
>> + =C2=A0 =C2=A0 default 128 if OMAP_GPIO_EXTRA128
>> + =C2=A0 =C2=A0 default 64 if OMAP_GPIO_EXTRA64
>> + =C2=A0 =C2=A0 default 0
>> +
>> +config OMAP_GPIO_EXTRA64
>> + =C2=A0 =C2=A0 bool
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 Add an extra 64 gpio numbers to the available=
 GPIO pool. This is
>> + =C2=A0 =C2=A0 =C2=A0 available for boards that need extra gpios fo=
r external devices.
>> +
>> +config OMAP_GPIO_EXTRA128
>> + =C2=A0 =C2=A0 bool
>> + =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 Add an extra 128 gpio numbers to the availabl=
e GPIO pool. This is
>> + =C2=A0 =C2=A0 =C2=A0 available for boards that need extra gpios fo=
r external devices.
>> +
>
> Let's wait on this and the following patch a a little, I believe ther=
e
> are already patches in the works to deal with this for the multi-arm
> support. So this should get solved eventually in a generic way.
>
> Regards,
>
> Tony
>

Has anything happened with this recently?  I haven't been keeping up
too much, and I notice the latest linus-tree kernel still needs these
patches (or something similar) for me to be able to use the htcpld on
herald.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
