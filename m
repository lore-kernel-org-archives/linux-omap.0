From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 13/15] OMAP: GPIO: cleanup _set_gpio_wakeup(), remove ifdefs
Date: Tue, 03 May 2011 09:35:46 -0700
Message-ID: <87aaf3g2sd.fsf@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-14-git-send-email-khilman@ti.com>
	<BANLkTi=z3zk2E5Big5Ot-QXP86gBr=D53w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34130 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753317Ab1ECQfw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 May 2011 12:35:52 -0400
Received: by mail-pz0-f44.google.com with SMTP id 5so114787pzk.3
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 09:35:51 -0700 (PDT)
In-Reply-To: <BANLkTi=z3zk2E5Big5Ot-QXP86gBr=D53w@mail.gmail.com> (Charulatha
	Varadarajan's message of "Tue, 26 Apr 2011 20:14:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
>> Make _set_gpio_wakeup() generic by removing ifdefs. =C2=A0Code for t=
he
>> various SoCs/bank-methods was already the same, except for the
>> non-wakeup GPIO checking. =C2=A0But that flag is set on a per-SoC ba=
sis, so
>> can be used for all SoCs.
>>
>> While here, use pr_err() and remove GPIO bank calculation assumption
>> based on subtracting bank pointers.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>

[...]

>> -#endif
>> - =C2=A0 =C2=A0 =C2=A0 default:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "=
Can't enable GPIO wakeup for method %i\n",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bank->method);
>> + =C2=A0 =C2=A0 =C2=A0 if (bank->non_wakeup_gpios & gpio_bit) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("Unable to=
 modify wakeup on non-wakeup GPIO%d\n", gpio);
>
> use dev_err instead.

Agreed, thanks.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
