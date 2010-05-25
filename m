From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH v3 1/3] omap3 gpmc: functionality enhancement
Date: Tue, 25 May 2010 21:04:37 +0530
Message-ID: <AANLkTimvO3Gd1oM6Ctp22PcaBw7QmvOZhY6YhawJNos0@mail.gmail.com>
References: <s-ghorai@ti.com> <1274181389-7488-1-git-send-email-s-ghorai@ti.com>
	<1274181389-7488-2-git-send-email-s-ghorai@ti.com> <AANLkTikFxtzDpiJvJjnuonM2urMJR1LDLafx5JtpC_bS@mail.gmail.com>
	<1274284094.6286.17.camel@thunk> <2A3DCF3DA181AD40BDE86A3150B27B6B030D991D50@dbde02.ent.ti.com>
	<AANLkTikK4ISAsLFS-l5fXGxCppv98F2qqb8OBnZ7OTHd@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DA9F8EB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57225 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab0EYPkA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 11:40:00 -0400
Received: by pxi18 with SMTP id 18so2018492pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 08:40:00 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030DA9F8EB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "sakoman@gmail.com" <sakoman@gmail.com>, "mike@compulab.co.il" <mike@compulab.co.il>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, "peter.barada@gmail.com" <peter.barada@gmail.com>

On Tue, May 25, 2010 at 8:07 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrot=
e:
[...]
>> > c. And how to know that ECC engine is in used other driver should =
not
>> use it? Any bit to know that ecc engine is busy, as we check for pre=
fetch?
>> Do not really remember config registers. Perhaps there is no way.
>> But I guess you should check into register GPMC_ECC_CONFIG at bit 1.
>> This is the bit we are setting to enable ECC calculation, IIRC.
> [Ghorai] there are two functions -
> =A0 =A0 =A0 info->nand.ecc.calculate =A0 =A0 =A0 =A0=3D omap_calculat=
e_ecc;
> =A0 =A0 =A0 info->nand.ecc.hwctl =A0 =A0 =A0 =A0 =A0 =A0=3D omap_enab=
le_hwecc;
> And GPMC_ECC_CONFIG register..
> =A0 =A0 =A0 =A03:1 ECCCS Selects the CS where ECC is computed
> =A0 =A0 =A0 =A00 ECCENABLE Enables the ECC feature
> Now we enable omap_enable_hwecc (with GPMC_ECC_CONFIG[ECCENABLE]=3D1)=
; and its get disabled (automatically) when ecc_size data transfer over=
=2E
> But say still it did not read the ecc value yet (omap_calculate_ecc).
> So how to protect following omap_enable_hwecc() before omap_calculate=
_ecc() =A0without additional flag? Any input is welcome.

Oh yes, that's is a problem. Perhaps in that case you have to protect
it in very much same way you already did.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
