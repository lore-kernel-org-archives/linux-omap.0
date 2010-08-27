From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 08/10] [PM-WIP-MMC] OMAP MMC: Register offset handling
Date: Fri, 27 Aug 2010 19:45:38 +0530
Message-ID: <AANLkTimRtu=ivtLipB6HL3wbSE=AJosQnCQJmJu_-Aea@mail.gmail.com>
References: <16162.10.24.255.18.1282335070.squirrel@dbdmail.itg.ti.com>
	<8739u1vu1w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63484 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab0H0OPj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:15:39 -0400
Received: by vws3 with SMTP id 3so2897561vws.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 07:15:39 -0700 (PDT)
In-Reply-To: <8739u1vu1w.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, adrian.hunter@nokia.com, akpm@linux-foundation.org, madhu.cr@ti.com

On Fri, Aug 27, 2010 at 4:52 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "kishore kadiyala" <kishore.kadiyala@ti.com> writes:
>
>> Since OMAP4 has added new set of registers , this patch adds
>> different array's for OMAP3 and OMAP4 and choose the right one
>> during run time.Newly added registers are updated at the bottom
>> of array.
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Adrian Hunter <adrian.hunter@nokia.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>
> This one could go upstream independently of this series as it's not
> directly related to the rest of the series.
>
> Please post this one independently, and in the next rev of the rest o=
f
> the series, state the dependency on this patch.

OK will post this independently

Regards,
Kishore
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
