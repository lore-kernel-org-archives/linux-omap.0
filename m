From: Nick Krause <xerofoify@gmail.com>
Subject: Re: Nokia N900 FB regression?
Date: Tue, 22 Jul 2014 18:16:36 -0400
Message-ID: <CAPDOMVjDRd52C-eDo4_OCaUhNYAXF+DpgV1qbZF3CV6XgohLiQ@mail.gmail.com>
References: <20140722212318.GC2615@drone.musicnaut.iki.fi>
	<CAPDOMVhwSAvbkHwwdM6wkV25MpKfZ=1m_QafFfdCRZtavGuFpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:52318 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089AbaGVWQh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2014 18:16:37 -0400
Received: by mail-vc0-f180.google.com with SMTP id ij19so633129vcb.11
        for <linux-omap@vger.kernel.org>; Tue, 22 Jul 2014 15:16:36 -0700 (PDT)
In-Reply-To: <CAPDOMVhwSAvbkHwwdM6wkV25MpKfZ=1m_QafFfdCRZtavGuFpw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

On Tue, Jul 22, 2014 at 6:02 PM, Nick Krause <xerofoify@gmail.com> wrote:
> On Tue, Jul 22, 2014 at 5:23 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> Hi,
>>
>> Somewhere between 3.16-rc2 and rc6 (I was on holidays...) I noticed
>> the framebuffer stopped working on N900 (nothing on screen).
>>
>> I bisected this to 9188883fd66e9809e93e06d5bbd49cf99a6cdbee (ARM: dts:
>> Enable twl4030 off-idle configuration for selected omaps).
>> With this commit reverted, I can see the Tux again with 3.16-rc6.
>>
>> Any ideas?
>>
>> A.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> I am new to the kernel but I can take a look into this this commit.
> Cheers Nick

+
+       twl_power: power {
+               compatible = "ti,twl4030-power-n900",
"ti,twl4030-power-idle-osc-off";
+               ti,use_poweroff;
+       };
 };
This seems to be the case of no boot. Perhaps compatible functions are
incorrect?
I am new so asking a maintainer may be better but seems the idle function set
here turns off your frame butter. I would also test this on the beagleboard xm
as this patch may affect it too.
Nick
