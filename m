From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [RFC] Change ECC algorithm from userspace
Date: Fri, 28 Oct 2011 13:13:54 +0200
Message-ID: <CAAwP0s0TzB2iFzYkjAsN6q-YA9d0MEd7ViOd-UUvbMf_11q8gw@mail.gmail.com>
References: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com>
 <70E876B0EA86DD4BAF101844BC814DFE0BF244FAD1@Cloud.RL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33905 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1J1LOP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Oct 2011 07:14:15 -0400
Received: by ywm3 with SMTP id 3so3555360ywm.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Oct 2011 04:14:15 -0700 (PDT)
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE0BF244FAD1@Cloud.RL.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Povey <Jon.Povey@racelogic.co.uk>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

On Fri, Oct 28, 2011 at 12:33 PM, Jon Povey <Jon.Povey@racelogic.co.uk>=
 wrote:
> linux-mtd-bounces@lists.infradead.org wrote:
>> I want to be able to use 1-bit ECC for the first partition where I
>> save the loader binary and has to be accessed by the ROM boot but us=
e
>> a 4-bit ECC for my rootfs partition.
>>
>> Does anyone have this same issue?
>
> DM355 and DM365 has similar issues as the RBL expects a different OOB=
/ECC
> layout to Linux.
>
>> What is the best approach to store data in a NAND device using
>> different ECC techniques?
>
> What I have done is write a utility that calculates ECC and writes to
> the mtd device in RAW mode. So to rewrite the bootloader I take care =
of
> the ECC and layout at application level without changing the kernel.
>

Hi Jon,

Thanks for your help. I see that both you and Matthieu use the same
approach so I guess that is the common workaround for this problem. I
will do the same.

Is your utility publicly available? It would be great if I can use it
as an starting point.

Thank you and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
