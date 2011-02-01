From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Tue, 1 Feb 2011 17:01:03 +0530
Message-ID: <782caeeca19758b50d370c17db11c78a@mail.gmail.com>
References: <1294935563-14426-1-git-send-email-j-pihet@ti.com><b52b65db02da68b3febc0c9cf1e99040@mail.gmail.com><9215f5d7252a4b60f58c3e14a9d46f59@mail.gmail.com><AANLkTinRZyVBu=c3cHBQ7OmJv3U8717_w8Haig4R=ZQh@mail.gmail.com><86b8aab234e1451170c0937e2ab786e5@mail.gmail.com>
 <AANLkTinPxJigu8Nc5J04ciQ_c_Kw9R2xS7s1jaiqeM+F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:34933 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290Ab1BALbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 06:31:09 -0500
Received: by mail-gy0-f180.google.com with SMTP id 6so2970806gya.11
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 03:31:05 -0800 (PST)
In-Reply-To: <AANLkTinPxJigu8Nc5J04ciQ_c_Kw9R2xS7s1jaiqeM+F@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Tuesday, February 01, 2011 4:53 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
> Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>

[...]
> >> Does that makes sense?
> >>
> > Actually not. Rather I will separate only the scenario's
> > where CORE low power targets are attempted and only have
> > that code run from SRAM.
> >
> > There are scenario's where CORE can be active because MODEM,
> > DSP and MPU can still hit RET, OFF. And here, the errata
> > isn't applicable.
> >
> > Unless I missed something here, I think in the code we check
> > the the CORE attempted state and based on that we can do a
> > normal WFI from DDR (no self rfersh) or WFI from
> > SRAM with self refresh enabled.
> No. Only the MPU attempted state is checked (this actually is the
> 'save_state' parameter passed to omap_cpu_suspend).
> So it makes sense to check the CORE attempted state in order to
> decide
> to run the WFI from internal SRAM or DDR.
>
> The MPU attempted state is used to decide whether to save the
> MPU/L1/L2 context.
>
Looks like you miss-understood my point. As I understand from
errata, as long as core clock domain can idle with core
dpll divider auto idle enabled, the errata is applicable.

So the only check needed is to see if the core clockdomain
hw_auto or sw sleep is enabled.

If it is suppose to be not idle(we force few C-states
where CORE inactive is avoided for faster response),
we can execute WFI from DDR with not enabling
self refresh.

Rest of the scenario can follow the SRAM path.

Hope this is clear to you.

Regards,
Santosh
