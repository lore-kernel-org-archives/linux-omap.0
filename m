From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 13/14] OMAP2/3: PRCM: split OMAP2/3-specific PRCM code
 into OMAP2/3-specific files
Date: Wed, 15 Dec 2010 14:23:33 +0200
Message-ID: <AANLkTimTtdMeaz=k6H=GQMNTGciJ5uc+GGUnC1RdR_f2@mail.gmail.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<20101207012516.3708.87606.stgit@twilight.localdomain>
	<alpine.DEB.2.00.1012142147040.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:58346 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab0LOMXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 07:23:35 -0500
Received: by bwz16 with SMTP id 16so2185688bwz.4
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 04:23:34 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012142147040.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Jarkko Nikula <jhnikula@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Hi,

On Wed, Dec 15, 2010 at 6:50 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 6 Dec 2010, Paul Walmsley wrote:
>
>> In preparation for adding OMAP4-specific PRCM accessor/mutator
>> functions, split the existing OMAP2/3 PRCM code into OMAP2/3-specifi=
c
>> files. =C2=A0Most of what was in mach-omap2/{cm,prm}.{c,h} has now b=
een
>> moved into mach-omap2/{cm,prm}2xxx_3xxx.{c,h}, since it was
>> OMAP2xxx/3xxx-specific.
>>
>> This process also requires the #includes in each of these files to b=
e
>> changed to reference the new file name. =C2=A0As part of doing so, a=
dd some
>> comments into plat-omap/sram.c and plat-omap/mcbsp.c, which use
>> "sideways includes", to indicate that these users of the PRM/CM incl=
udes
>> should not be doing so.
>
> This patch has been updated to also take care of getting DSPBridge to
> build again. =C2=A0Omar, Felipe, could you please take a look at the
> mach-omap2/dsp.c and _tiomap.h changes and ack them?

I would prefer the XX comments in a separate chunk:

/*
 * license notice
 */

/*
 * XXX
 */

But otherwise it's ok.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
