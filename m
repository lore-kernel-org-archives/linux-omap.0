From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: rmgr/node.c code cleanup
Date: Thu, 9 Dec 2010 17:03:04 -0600
Message-ID: <AANLkTikLoNf-NDb6kCQnVHB95zrTKi2f9CU6m_u0A+KB@mail.gmail.com>
References: <1291931258-30744-1-git-send-email-ionut.nicu@mindbit.ro>
	<1291931258-30744-2-git-send-email-ionut.nicu@mindbit.ro>
	<1291933352.23672.52.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58084 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752665Ab0LIXDG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 18:03:06 -0500
Received: by mail-iw0-f173.google.com with SMTP id 40so4039925iwn.4
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 15:03:05 -0800 (PST)
In-Reply-To: <1291933352.23672.52.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Ionut,

On Thu, Dec 9, 2010 at 4:22 PM, Ionut Nicu <ionut.nicu@mindbit.ro> wrot=
e:
> Hi Omar,
>
> On Thu, 2010-12-09 at 23:47 +0200, Ionut Nicu wrote:
>> Reorganized some code in rmgr/node.c to increase its
>> readability. Most of the changes reduce the code
>> indentation level and simplifiy the code. No functional
>> changes were done.
>
> <snip>
>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Check stream mode. Default is STRMMODE_PROCCOPY.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if (!status && pattrs) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (pattrs->strm_mode !=3D STRMMODE_PROCCO=
PY)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -EPERM; =A0 =A0=
 =A0 =A0/* illegal stream mode */
>> -
>> - =A0 =A0 }
>> - =A0 =A0 if (status)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto func_end;
>> + =A0 =A0 if (pattrs && pattrs->strm_mode !=3D STRMMODE_PROCCOPY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM; =A0/* illegal stream mode *=
/
>>
>
> While cleaning up and reviewing the code I saw this check, =A0which u=
nless
> it's intentional I think it looks like a bug. See comment below.
>
> <snip>
>> + =A0 =A0 =A0 =A0 =A0 =A0 strm_mode =3D pattrs ? pattrs->strm_mode :=
 STRMMODE_PROCCOPY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (strm_mode) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case STRMMODE_RDMA:
>
> ...
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 case STRMMODE_ZEROCOPY:
>
> ...
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 case STRMMODE_PROCCOPY:
>
> It looks like all modes are handled here although the only one that
> could escape the validation from above is STRMMODE_PROCCOPY.
>
> I tried removing the first check and tested with the
> userspace-dspbridge strmcopy application, but I noticed the DSP hangs=
 if
> I try to use it with anything else than the copy mode.
>
> Are the other modes (rdma, zerocopy) not supported at all?

No, those modes are not supported... the only one working for dsp
streams is proc-copy.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
