From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 07/13] ARM: OMAP5: l3: Add l3 error handler support for omap5.
Date: Sun, 6 May 2012 13:08:41 +0530
Message-ID: <CAJ7qFSek4h78wHdwdb-h6UZNqUofT03PTm8LN66WQgdKyp5Y+A@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<1336029982-31898-8-git-send-email-r.sricharan@ti.com>
	<20120504225153.GZ5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:34787 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751472Ab2EFHio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 6 May 2012 03:38:44 -0400
Received: by laap9 with SMTP id p9so163230laa.22
        for <linux-omap@vger.kernel.org>; Sun, 06 May 2012 00:38:42 -0700 (PDT)
In-Reply-To: <20120504225153.GZ5613@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

Hi Tony,

>> - =A0 =A0 if (!(cpu_is_omap44xx()))
>> + =A0 =A0 if ((!(cpu_is_omap44xx())) && (!cpu_is_omap54xx()))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>
>> =A0 =A0 =A0 for (i =3D 0; i < L3_MODULES; i++) {
>
> Isn't there some unnecessary parens here?

 You mean in this above for loop?.
 There are multiple statements .

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
