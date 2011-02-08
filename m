From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM: Define wfi(), wfe(), sev() macros for pre-v7 processors
Date: Tue, 8 Feb 2011 14:15:40 +0530
Message-ID: <ff8b5b67a8c36c282e54e48d49204781@mail.gmail.com>
References: <1296829243-21313-1-git-send-email-dave.martin@linaro.org> b462b6fdb4265f13d0cd87d13df3c530@mail.gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41850 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751253Ab1BHIpm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 03:45:42 -0500
Received: by mail-gx0-f169.google.com with SMTP id 5so2313993gxk.14
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 00:45:41 -0800 (PST)
In-Reply-To: b462b6fdb4265f13d0cd87d13df3c530@mail.gmail.com
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King <linux@arm.linux.org.uk>

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Tuesday, February 08, 2011 2:11 PM
> To: 'Dave Martin'; 'linux-arm-kernel@lists.infradead.org'
> Cc: 'Tony Lindgren'; Jean Pihet-XID; 'linux-omap@vger.kernel.org';
> 'Nicolas Pitre'; 'Russell King'
> Subject: RE: [PATCH] ARM: Define wfi(), wfe(), sev() macros for pre-
> v7 processors
>
> Dave,
> > -----Original Message-----
> > From: Dave Martin [mailto:dave.martin@linaro.org]
> > Sent: Friday, February 04, 2011 7:51 PM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
> > linux-omap@vger.kernel.org; Nicolas Pitre; Russell King
> > Subject: [PATCH] ARM: Define wfi(), wfe(), sev() macros for pre-v7
> > processors
> >
> > Pre-v7 processors don't have wfe/sev, so these are defined for
> > consistency as empty barrier asms.
> >
> > For v6, wfi is architected as a defined MCR instruction, so
> > use that definition.
> >
> > Doing a no-op instead of wfi() is probably bad, so for older
> > processors than v6, wfi() is not defined.  If needed, some CPU-
> > specific wfi() will have to be defined elsewhere.
> >
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > ---
> >  arch/arm/include/asm/system.h |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/system.h
> > b/arch/arm/include/asm/system.h
> > index 97f6d60..0e1cae3 100644
> > --- a/arch/arm/include/asm/system.h
> > +++ b/arch/arm/include/asm/system.h
> > @@ -129,7 +129,14 @@ extern unsigned int user_debug;
> >  #define sev()	__asm__ __volatile__ ("sev" : : : "memory")
> >  #define wfe()	__asm__ __volatile__ ("wfe" : : : "memory")
> >  #define wfi()	__asm__ __volatile__ ("wfi" : : : "memory")
> > +#else /* __LINUX_ARM_ARCH__ < 7 */
> > +#define sev()	__asm__ __volatile__ ("" : : : "memory")
> > +#define wfe()	__asm__ __volatile__ ("" : : : "memory")
> This is not true for "CPU_32v6K" extensions, right. I think they do
> support 'sev' and 'wfe' instructions.
>
>
Ignore the comment. 'CPU_32v6K' is already considered.
