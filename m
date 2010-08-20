From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v5 1/3] ARM: OMAP: Beagle: revision detection
Date: Thu, 19 Aug 2010 21:33:37 -0500
Message-ID: <AANLkTimixBcvEfUHVKOCWdVSr6WLb7n_YMeP77E4VuUJ@mail.gmail.com>
References: <1282147013-508-1-git-send-email-robertcnelson@gmail.com>
	<20100819095329.3c39a8a9.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57555 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab0HTCdi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 22:33:38 -0400
Received: by eyg5 with SMTP id 5so1821582eyg.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Aug 2010 19:33:37 -0700 (PDT)
In-Reply-To: <20100819095329.3c39a8a9.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Thu, Aug 19, 2010 at 1:53 AM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> On Wed, 18 Aug 2010 10:56:51 -0500
> Robert Nelson <robertcnelson@gmail.com> wrote:
>
>> + =A0 =A0 ret =3D gpio_request(171, "rev_id_0");
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail0;
>> +
>> + =A0 =A0 ret =3D gpio_request(172, "rev_id_1");
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
>> +
>> + =A0 =A0 ret =3D gpio_request(173, "rev_id_2");
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
> ...
>> +fail2:
>> + =A0 =A0 gpio_free(173);
>> +fail1:
>> + =A0 =A0 gpio_free(172);
>> +fail0:
>> + =A0 =A0 gpio_free(171);
>
> This must be:
>
> +fail2:
> + =A0 =A0 =A0 gpio_free(172);
> +fail1:
> + =A0 =A0 =A0 gpio_free(171);
> +fail0:
>
> Otherwise the set looks good to me.
>
>
> --
> Jarkko
>

Thanks Jarkko,

Yeah that one is obvious, will resubmit..

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
