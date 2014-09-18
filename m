From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v3 2/3] nand: omap2: Remove horrible ifdefs to fix module probe
Date: Thu, 18 Sep 2014 08:48:06 +0100
Message-ID: <CAAEAJfAbObn0biRrxKeGpddvYcSZfabntz8fY3LCaa8wsEzjkg@mail.gmail.com>
References: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<1410447730-16087-3-git-send-email-ezequiel@vanguardiasur.com.ar>
	<20140918060336.GE7362@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:49392 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaIRHsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 03:48:07 -0400
Received: by mail-qc0-f179.google.com with SMTP id x13so680852qcv.38
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2014 00:48:06 -0700 (PDT)
In-Reply-To: <20140918060336.GE7362@norris-Latitude-E6410>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On 18 September 2014 07:03, Brian Norris <computersforpeace@gmail.com> =
wrote:
> On Thu, Sep 11, 2014 at 12:02:09PM -0300, Ezequiel Garcia wrote:
>> The current code abuses ifdefs to determine if the selected ECC sche=
me
>> is supported by the running kernel. As a result the code is hard to =
read,
>> and it also fails to load as a module.
>
> Yes, a real eyesore, with little benefit from the #ifdef's.
>
>> This commit removes all the ifdefs and instead introduces a function
>> omap2_nand_ecc_check() to check if the ECC is supported by using
>> IS_ENABLED(CONFIG_xxx).
>>
>> Since IS_ENABLED() is true when a config is =3Dy or =3Dm, this chang=
e fixes the
>> module so it can be loaded with no issues.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> [...]
>> diff --git a/include/linux/platform_data/elm.h b/include/linux/platf=
orm_data/elm.h
>> index 780d1e9..25d1bca 100644
>> --- a/include/linux/platform_data/elm.h
>> +++ b/include/linux/platform_data/elm.h
>> @@ -42,8 +42,22 @@ struct elm_errorvec {
>>       int error_loc[16];
>>  };
>>
>> +#if IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)
>>  void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
>>               struct elm_errorvec *err_vec);
>>  int elm_config(struct device *dev, enum bch_ecc bch_type,
>>       int ecc_steps, int ecc_step_size, int ecc_syndrome_size);
>> +#else
>> +void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
>> +             struct elm_errorvec *err_vec)
>
> You should not be defining non-static functions in a header. Now thes=
e
> functions will be uselessly placed in every compilation unit that
> includes this header. You should probably make this function 'static
> inline'.
>

Darn, of course they must be static! Thanks for spotting this.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
