From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [RESEND PATCH 1/2] ARM: OMAP2+: nand: Make board_onenand_init()
 visible to board code
Date: Wed, 9 May 2012 15:30:41 +0200
Message-ID: <CAAwP0s3_9FwetsYsrQbLL45Wb6wyxMdLLQR3b1cPS4AamY0qxg@mail.gmail.com>
References: <1333564586-3259-1-git-send-email-javier@dowhile0.org>
 <CAFqH_52aiDvR_xHY6TUN7igMiq6EqB-Nx9D=sPMCUeUaKLiuQg@mail.gmail.com>
 <CABxcv=kXukrVYOzjrMGoWzi=GTefh8EsXnTwzcahsfLa1a6Kaw@mail.gmail.com> <20120508231653.GP5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51163 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759400Ab2EINbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 09:31:03 -0400
Received: by yenm10 with SMTP id m10so247780yen.19
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 06:31:03 -0700 (PDT)
In-Reply-To: <20120508231653.GP5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Wed, May 9, 2012 at 1:16 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier@dowhile0.org> [120427 02:33]:
>> On Wed, Apr 25, 2012 at 9:59 AM, Enric Balletb=C3=B2 i Serra
>> <eballetbo@gmail.com> wrote:
>> >
>> > Tony, as this is a fix ,may be included ?
>> >
>> > Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> > Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> >
>> > Cheers,
>> > =C2=A0 =C2=A0Enric
>>
>> Hi Tony, Russel:
>>
>> This patch is a requirement for patch:
>>
>> [RESEND PATCH 2/2] OMAP3: igep0020: Add support for Micron NAND Flas=
h
>> storage memory
>>
>> which is really important since newer IGEPv2 boards have changed the=
ir
>> flash memory from OneNAND to NAND.
>>
>> This patch-set is necessary to make the board work, otherwise it
>> doesn't even boot.
>>
>> Could we please include these patches?
>
> Thanks for the patience, applying now into board branch finally.
>
> Regards,
>
> Tony
> --

Hi Tony,

Thanks a lot for applying these patches.

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
