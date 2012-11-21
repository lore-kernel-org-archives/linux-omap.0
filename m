From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Wed, 21 Nov 2012 11:15:23 +0100
Message-ID: <50ACA9BB.7090106@gmail.com>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com> <1351869956-2787-5-git-send-email-zonque@gmail.com> <518397C60809E147AF5323E0420B992E3E9DA81F@DBDE01.ent.ti.com> <5097B7EE.3000508@gmail.com> <518397C60809E147AF5323E0420B992E3E9DC1F1@DBDE01.ent.ti.com> <509A2E75.5060307@gmail.com> <518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com> <509EA360.2050504@gmail.com> <87mwycjmdn.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59842 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab2KUKRh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 05:17:37 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2815848bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Nov 2012 02:17:36 -0800 (PST)
In-Reply-To: <87mwycjmdn.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: "Philip, Avinash" <avinashphilip@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 20.11.2012 16:59, Peter Korsgaard wrote:
>>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:
> 
> Hi,
> 
>  >>>> In omap2 driver NAND_ECC_HW ecc mode supports 3 ecc layout
>  >>>> OMAP_ECC_HAMMING_CODE_HW_ROMCODE
>  >>>> OMAP_ECC_BCH4_CODE_HW
>  >>>> OMAP_ECC_BCH8_CODE_HW
>  >>>> 
>  >>>> So selection of ecc layout data should come from DT not ecc mode.
>  >>> 
>  >>> Ok, I see. I would still like to set them by string rather than magic
>  >>> numbers that map to enum entries. Valid values would be "none", "hw",
>  >>> "hw-romcode", "bch4" and "bch8". Are you ok with that?
>  >> 
>  >> Ok, that's nice. Better use ecc_opt instead of ecc_mode.
> 
>  Daniel> I did some more extensive tests that include reading the same
>  Daniel> nand pages from both U-Boot and the kernel with BCH8 ECC, and
>  Daniel> it turns out that -> is_elm_used needs to be set in the pdata
>  Daniel> in order to make this work.
> 
> So what you're saying is that the choice of ELM or not is not just an
> optimization, it really changes the ECC layout? Perhaps it should be
> treated as a seperate layout (E.G. bch8-elm) then?

That is what I experienced, yes. The kernel was unable to parse NAND
pages that were written from U-Boot with bch8 hardware mode when the elm
module was not active. Maybe someone from TI can explain that? Giving it
a dedicated name would also solve the problem with the extra DT property.

I'll wait until this is decided before I resend a new set that also
fixes the issue with the errornousely forgotten Documentation file.


Thanks,
Daniel

