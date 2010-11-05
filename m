From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/3 v2] omap4: opp: add OPP table data
Date: Thu, 4 Nov 2010 20:05:46 -0400
Message-ID: <AANLkTik9gcdLinj3zQMGM29bXAzrgpHHQvDXt4ghJLTd@mail.gmail.com>
References: <1287536543-9729-1-git-send-email-nm@ti.com> <1287536543-9729-2-git-send-email-nm@ti.com>
 <1287536543-9729-3-git-send-email-nm@ti.com> <20101104231309.GE9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51286 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751534Ab0KEAGI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Nov 2010 20:06:08 -0400
Received: by mail-wy0-f174.google.com with SMTP id 36so601288wyb.5
        for <linux-omap@vger.kernel.org>; Thu, 04 Nov 2010 17:06:06 -0700 (PDT)
In-Reply-To: <20101104231309.GE9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, Kevin H <khilman@deeprootsystems.com>

On Thu, Nov 4, 2010 at 19:13, Tony Lindgren <tony@atomide.com> wrote:
> * Nishanth Menon <nm@ti.com> [101019 17:53]:
>> @@ -86,7 +87,10 @@ int __init omap_init_opp_table(void)
>> =A0 =A0 =A0 omap_table_init =3D 1;
>>
>> =A0 =A0 =A0 /* Select the OPP table we'd like to enable based on cpu=
 we are on */
>> - =A0 =A0 if (cpu_is_omap34xx()) {
>> + =A0 =A0 if (cpu_is_omap44xx()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 opp_def =3D omap44xx_opp_def_list;
>> + =A0 =A0 =A0 =A0 =A0 =A0 opp_def_size =3D ARRAY_SIZE(omap44xx_opp_d=
ef_list);
>> + =A0 =A0 } else if (cpu_is_omap34xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 opp_def =3D cpu_is_omap3630() ? omap36xx=
_opp_def_list :
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap34xx_opp_def_list;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 opp_def_size =3D cpu_is_omap3630() ?
>
> And based on the comments in patch 1/3, when you add support for
> new processor, you just add a new init function instead of adding
> "if cpu_is_omapxxxx else if" chunks.

yeah it does sound better and i like the approach as well. thanks for
the same. will post a v3 asap.

Regards,
NM
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
