From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 07/13] ARM: OMAP5: l3: Add l3 error handler support for omap5.
Date: Tue, 8 May 2012 11:34:05 +0530
Message-ID: <CAJ7qFSdE50KH0YdyiiDccPZ9oduM4ktwXDm+h2OvgXRvmm-LAg@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<1336029982-31898-8-git-send-email-r.sricharan@ti.com>
	<20120504225153.GZ5613@atomide.com>
	<CAJ7qFSek4h78wHdwdb-h6UZNqUofT03PTm8LN66WQgdKyp5Y+A@mail.gmail.com>
	<20120507173430.GC5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47074 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752337Ab2EHGEI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 02:04:08 -0400
Received: by lbbgm6 with SMTP id gm6so5744248lbb.33
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 23:04:06 -0700 (PDT)
In-Reply-To: <20120507173430.GC5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

Tony,

On Mon, May 7, 2012 at 11:04 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * R, Sricharan <r.sricharan@ti.com> [120506 00:42]:
>> Hi Tony,
>>
>> >> - =A0 =A0 if (!(cpu_is_omap44xx()))
>> >> + =A0 =A0 if ((!(cpu_is_omap44xx())) && (!cpu_is_omap54xx()))
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> >>
>> >> =A0 =A0 =A0 for (i =3D 0; i < L3_MODULES; i++) {
>> >
>> > Isn't there some unnecessary parens here?
>>
>> =A0You mean in this above for loop?.
>> =A0There are multiple statements .
>
> No, both the old (!(cpu_is_omap44xx())) and the added one.
>
  oh ok, will remove those extra ones. Thanks.

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
