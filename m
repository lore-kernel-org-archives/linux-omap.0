From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [REPOST][PATCH] Fix IGEPv2 second MMC channel power supply
Date: Tue, 14 Dec 2010 09:18:31 +0100
Message-ID: <AANLkTikJd_pS_f6cp6kThSLNHfo3Aug4efhpcrarrPE2@mail.gmail.com>
References: <1291466438-12827-1-git-send-email-maz@misterjones.org>
	<AANLkTi=9+AafKvyBanYeFjQtWQvUKK1rLLLJRO0z1ekw@mail.gmail.com>
	<20101213202443.GB3054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:40791 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab0LNISc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 03:18:32 -0500
Received: by gwb20 with SMTP id 20so262083gwb.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 00:18:32 -0800 (PST)
In-Reply-To: <20101213202443.GB3054@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Marc Zyngier <maz@misterjones.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2010/12/13 Tony Lindgren <tony@atomide.com>:
> * Enric Balletb=C3=B2 i Serra <eballetbo@gmail.com> [101213 08:47]:
>>
>> Tony, please can this patch be included before 2.6.37 ? Without this
>> patch the wifi module on IGEP v2 board not works.
>
> Sorry it's too much for the -rc series. For the -rc series
> the fixes should be major bugs. This is in the category
> "it never worked before".
>
> I will add it to omap-boards branch for the next merge window
> over the next few days while going through all the pending
> patches in patchwork.

Ok, I'll wait :-) thanks

Cheers,
   Enric
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
