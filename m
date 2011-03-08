From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 2/4] OMAP4: hwmod data: add mmu hwmod for ipu and dsp
Date: Tue, 8 Mar 2011 17:21:07 -0600
Message-ID: <AANLkTi=hJU7RUjBcsu3mb-yAdx2SzRwOVM7wERoyzWWw@mail.gmail.com>
References: <1299484388-16205-1-git-send-email-omar.ramirez@ti.com>
	<1299484388-16205-3-git-send-email-omar.ramirez@ti.com>
	<4D74D5B9.2070907@ti.com>
	<AANLkTimfSfCc3Pvf_=2MKnHTiC9gVw-_xohHczTUHroH@mail.gmail.com>
	<4D769FCB.4040907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54212 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756170Ab1CHXVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:21:08 -0500
Received: by mail-pz0-f52.google.com with SMTP id 36so1713382pzk.11
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 15:21:08 -0800 (PST)
In-Reply-To: <4D769FCB.4040907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Benoit,

On Tue, Mar 8, 2011 at 3:29 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> What I meant is that the mmu does not have any explicit PRCM module enable
> control. The PRCM does control only the DSP as a whole. Since hwmods are
> generated with a PRCM granularity, any sub module will not be exposed by
> default.

Ok, got it. Thanks for the reply.

> I've checked both IPU and DSP HW specs, and in the both cases, the mmu IP is
> the only module with OCP port from the MPU in the relevant subsystem.
> In that case, it is easier for me to remove that DSP and IPU hwmods and move
> everything under the MMUs hwmods.
> It will then highlight the re-use of the same IP in two different
> subsystems.
>
> I have now to modify the OMAP4 generator in order to provide the correct
> data in the right format.
>
> I'll try to do that before the end of this week. This will not have any real
> impact for you except for the name change (mmu_ipu and mmu_dsp).
>
> Is that OK for you?

No problem, once it is ready I'll update OMAP3 to mimic the name style.

Thanks,

Omar
