From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Fri, 30 Mar 2012 11:29:16 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831841326@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
 <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
 <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
 <CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
 <CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840E0C@DBDE01.ent.ti.com>
 <4F7570FC.8000907@ti.com>
 <79CD15C6BA57404B839C016229A409A831840F82@DBDE01.ent.ti.com>
 <CAMQu2gzOkE6LD0WZ_9bKe3J-=Dv89rWaMzvWWvJHPMSPe6MzNg@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831841009@DBDE01.ent.ti.com>
 <CAMQu2gyktrAhtTYViYfb9nQ7g8UB1btGFkmd7aLD+Kt4r8y9WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46205 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933785Ab2C3L3e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 07:29:34 -0400
In-Reply-To: <CAMQu2gyktrAhtTYViYfb9nQ7g8UB1btGFkmd7aLD+Kt4r8y9WQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Fri, Mar 30, 2012 at 15:12:19, Shilimkar, Santosh wrote:
> On Fri, Mar 30, 2012 at 2:58 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> > On Fri, Mar 30, 2012 at 14:50:02, Shilimkar, Santosh wrote:
> >> On Fri, Mar 30, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> >> > On Fri, Mar 30, 2012 at 14:08:20, Shilimkar, Santosh wrote:
> >> >> On Friday 30 March 2012 02:02 PM, Hiremath, Vaibhav wrote:
> >> >> > On Fri, Mar 30, 2012 at 13:11:35, Shilimkar, Santosh wrote:
> >>
<...>

Santosh & others,

Do you think, it makes sense to clean up the CONFIG_OMAP_32K_TIMER
usage in mach-omap2/timer.c file now? Specifically below code-snippet -

#ifdef CONFIG_OMAP_32K_TIMER
#define OMAP2_CLKEV_SOURCE      OMAP2_32K_SOURCE
#define OMAP3_CLKEV_SOURCE      OMAP3_32K_SOURCE
#define OMAP4_CLKEV_SOURCE      OMAP4_32K_SOURCE
#define OMAP3_SECURE_TIMER      12
#else
#define OMAP2_CLKEV_SOURCE      OMAP2_MPU_SOURCE
#define OMAP3_CLKEV_SOURCE      OMAP3_MPU_SOURCE
#define OMAP4_CLKEV_SOURCE      OMAP4_MPU_SOURCE
#define OMAP3_SECURE_TIMER      1
#endif

And lets make 32k_fclk as default clocksource for gptimer, if it is being
used as clocksource. Atleast with this I can clean whole omap2/3/4 families,
and I can take omap1 thing later .
(as I have to understand/read about omap1 first).

If you agree, I can include this cleanup also in my next version of patch-
series. What's your opinion here?

Thanks,
Vaibhav
