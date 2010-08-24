From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: NAND ECC in linux-omap
Date: Tue, 24 Aug 2010 22:40:41 +0530
Message-ID: <AANLkTi=br81XgtJWE52NpE_0Kdbbpe6OTSXVAnhXDj2+@mail.gmail.com>
References: <AANLkTimABq72N98Ca6yJ9FgYnyDpod3qRPoTypkDn-4A@mail.gmail.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E8188DB@dbde02.ent.ti.com>
 <AANLkTik4+gApkw5fQ561QnJPLX5ED7oN3oU0P6F0+Gsv@mail.gmail.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E9299EA@dbde02.ent.ti.com> <AANLkTinuR_g53r4Q6a3LCmy4LR9ox8j7uCOFVB4OmRz4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53815 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab0HXRLB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 13:11:01 -0400
Received: by pwi7 with SMTP id 7so2541336pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 10:11:01 -0700 (PDT)
In-Reply-To: <AANLkTinuR_g53r4Q6a3LCmy4LR9ox8j7uCOFVB4OmRz4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, Linux OMAP Users <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>

On Tue, Aug 24, 2010 at 8:04 PM, Cliff Brake <cliff.brake@gmail.com> wrote:
>
> flash_erasall -j /dev/mtd4

Give a try without using '-j' option... If ECC layout is the suspect..
this may help.


-- 
Regards,
Vimal Singh
