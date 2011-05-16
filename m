From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [RESEND PATCH 2/4] omap: igep0020: minor refactoring
Date: Mon, 16 May 2011 09:17:53 +0200
Message-ID: <BANLkTi=PGq4qp8pZorR1UUp0NdEL1WkfJw@mail.gmail.com>
References: <cover.1305235542.git.mike@compulab.co.il>
	<201105132044.39163.arnd@arndb.de>
	<20110515185043.GA24785@gentoodev.compulab.local>
	<201105152228.00408.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40709 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab1EPHRy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 03:17:54 -0400
Received: by iyb14 with SMTP id 14so3504332iyb.19
        for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 00:17:53 -0700 (PDT)
In-Reply-To: <201105152228.00408.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: mike@compulab.co.il, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

2011/5/15 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 15 May 2011, mike@compulab.co.il wrote:
>> We can keep all the data structures that differ between IGEP2 and IG=
EP3.
>> However, this significantly reduces the benifit of the series.
>> There's already code in the IGEP2 that differentiates between HW
>> revisions, so anyway the board support will require some work for
>> devicetree transition. Eventually, when devicetree will be usable on
>> OMAPs, most of the code currently found in arch/arm/mach-omap2/board=
*
>> will require some work and I hardly believe that the transition can =
be
>> automated...
>
> True. Let's just use the version you posted then.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Arnd
>

Acked-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
