From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND
Date: Tue, 20 Nov 2012 16:59:48 +0100
Message-ID: <87mwycjmdn.fsf@dell.be.48ers.dk>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com>
	<1351869956-2787-5-git-send-email-zonque@gmail.com>
	<518397C60809E147AF5323E0420B992E3E9DA81F@DBDE01.ent.ti.com>
	<5097B7EE.3000508@gmail.com>
	<518397C60809E147AF5323E0420B992E3E9DC1F1@DBDE01.ent.ti.com>
	<509A2E75.5060307@gmail.com>
	<518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com>
	<509EA360.2050504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:65483 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab2KTP7w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 10:59:52 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so1072463wer.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Nov 2012 07:59:51 -0800 (PST)
In-Reply-To: <509EA360.2050504@gmail.com> (Daniel Mack's message of "Sat, 10
	Nov 2012 19:56:32 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Philip, Avinash" <avinashphilip@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:

Hi,

 >>>> In omap2 driver NAND_ECC_HW ecc mode supports 3 ecc layout
 >>>> OMAP_ECC_HAMMING_CODE_HW_ROMCODE
 >>>> OMAP_ECC_BCH4_CODE_HW
 >>>> OMAP_ECC_BCH8_CODE_HW
 >>>> 
 >>>> So selection of ecc layout data should come from DT not ecc mode.
 >>> 
 >>> Ok, I see. I would still like to set them by string rather than magic
 >>> numbers that map to enum entries. Valid values would be "none", "hw",
 >>> "hw-romcode", "bch4" and "bch8". Are you ok with that?
 >> 
 >> Ok, that's nice. Better use ecc_opt instead of ecc_mode.

 Daniel> I did some more extensive tests that include reading the same
 Daniel> nand pages from both U-Boot and the kernel with BCH8 ECC, and
 Daniel> it turns out that -> is_elm_used needs to be set in the pdata
 Daniel> in order to make this work.

So what you're saying is that the choice of ELM or not is not just an
optimization, it really changes the ECC layout? Perhaps it should be
treated as a seperate layout (E.G. bch8-elm) then?

-- 
Bye, Peter Korsgaard
