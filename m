From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: OMAP: Beagle: revision detection
Date: Fri, 13 Aug 2010 07:51:10 -0500
Message-ID: <AANLkTi=xn6A_3fAZObHn+DnMvWPe2HMJWxZOoUUX-iwZ@mail.gmail.com>
References: <1281702070-10525-1-git-send-email-robertcnelson@gmail.com>
	<20100813154454.aca470ee.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56358 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934260Ab0HMMvM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 08:51:12 -0400
Received: by ewy23 with SMTP id 23so1183195ewy.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 05:51:10 -0700 (PDT)
In-Reply-To: <20100813154454.aca470ee.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Fri, Aug 13, 2010 at 7:44 AM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> On Fri, 13 Aug 2010 07:21:08 -0500
> Robert Nelson <robertcnelson@gmail.com> wrote:
>
>> + =A0 =A0 /* Older U-Boot's such as 2009.01-dirty don't have the pin=
s
>> + =A0 =A0 =A0* muxed correctly to use the generic gpio_direction_inp=
ut();
>> + =A0 =A0 =A0*/
>> + =A0 =A0 omap_mux_init_gpio(171, OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 omap_mux_init_gpio(172, OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 omap_mux_init_gpio(173, OMAP_PIN_INPUT_PULLUP);
>> +
>
> Comment (and code) is wrong: gpio_direction_input is still required t=
o
> setup pin direction and letting the gpiolib to setup internal data
> structures properly. I.e. both mux setup and gpio_direction_input are
> required.
>
>
> --
> Jarkko
>

Thanks Jarkko,

I'll add the gpio_direction_input's back.. I assumed those two
functions were similar, and it still works probably by mostly luck..

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
