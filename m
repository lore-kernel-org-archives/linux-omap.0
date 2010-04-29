From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 2/2] omap: gpmc-nand: add ability to keep timings defined
	by the bootloader
Date: Thu, 29 Apr 2010 12:41:33 +0530
Message-ID: <g2qce9ab5791004290011w84f68a4ak3e24acdc74016265@mail.gmail.com>
References: <cover.1272470212.git.mike@compulab.co.il> <d97635d8d65238f8801db6bcf4e89e2fb1b44b17.1272470212.git.mike@compulab.co.il>
	<z2hce9ab5791004282127u817d6604oa65b8bf3b9957bda@mail.gmail.com>
	<4BD92CD2.7010907@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62296 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918Ab0D3TfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 15:35:14 -0400
Received: by vws19 with SMTP id 19so489421vws.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 12:35:13 -0700 (PDT)
In-Reply-To: <4BD92CD2.7010907@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: tony@atomide.com, s-ghorai@ti.com, linux-omap@vger.kernel.org

On Thu, Apr 29, 2010 at 12:23 PM, Mike Rapoport <mike@compulab.co.il> w=
rote:
> Vimal Singh wrote:
>>
>> On Wed, Apr 28, 2010 at 9:36 PM, Mike Rapoport <mike@compulab.co.il>
>> wrote:
>>>
>>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>> + =A0 =A0 =A0 if (gpmc_nand_data->keep_timings) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_nand_detect_timings();
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_nand_data->gpmc_t =3D &gpmc_defa=
ult_timings;
>>> + =A0 =A0 =A0 }
>>> +
>>
>> I guess moving this part to omap2_nand_gpmc_retime will be a good id=
ea.
>> As there, once we get old/default timings we can simply skip the
>> rounding part and directly jump to setting the timings.
>
> This way it would be the same as to pass 'gpmc_nand_data->gpmc_t =3D
> NULL'. If I correctly understood the previous comments ([1]), the
> problem with skipping retime is that when L3 clock changes, the gpmc
> timings became wrong. So, if we convert old/default timings to
> nanoseconds early during startup every time retime is called it will =
use
> the timing settings in nanoseconds thus yielding proper gpmc register=
s
> configuration.

OK. Then I think we can at least put __rounding__ code inside an 'if'
case, something like:
if (!gpmc_nand_data->keep_timings) {
=2E..
do rounding for supplied timings from board file.
=2E..
}

> And, if I'm not terribly mistaken retime should be called each time L=
3
> frequency changes, though with current kernel it's not yet the case..=
=2E

Yes. This is still left.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
