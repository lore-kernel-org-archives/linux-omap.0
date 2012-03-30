From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Fri, 30 Mar 2012 17:05:40 +0530
Message-ID: <4F759A8C.9020901@ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
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
 <79CD15C6BA57404B839C016229A409A831841326@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A831841326@DBDE01.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson,
 Benoit" <b-cousson@ti.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, Ming Lei <tom.leiming@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma,
 Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Friday 30 March 2012 04:59 PM, Hiremath, Vaibhav wrote:
> On Fri, Mar 30, 2012 at 15:12:19, Shilimkar, Santosh wrote:
>> On Fri, Mar 30, 2012 at 2:58 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>>> On Fri, Mar 30, 2012 at 14:50:02, Shilimkar, Santosh wrote:
>>>> On Fri, Mar 30, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>>>>> On Fri, Mar 30, 2012 at 14:08:20, Shilimkar, Santosh wrote:
>>>>>> On Friday 30 March 2012 02:02 PM, Hiremath, Vaibhav wrote:
>>>>>>> On Fri, Mar 30, 2012 at 13:11:35, Shilimkar, Santosh wrote:
>>>>
> <...>
> 
> Santosh & others,
> 
> Do you think, it makes sense to clean up the CONFIG_OMAP_32K_TIMER
> usage in mach-omap2/timer.c file now? Specifically below code-snippet -
> 
> #ifdef CONFIG_OMAP_32K_TIMER
> #define OMAP2_CLKEV_SOURCE      OMAP2_32K_SOURCE
> #define OMAP3_CLKEV_SOURCE      OMAP3_32K_SOURCE
> #define OMAP4_CLKEV_SOURCE      OMAP4_32K_SOURCE
> #define OMAP3_SECURE_TIMER      12
> #else
> #define OMAP2_CLKEV_SOURCE      OMAP2_MPU_SOURCE
> #define OMAP3_CLKEV_SOURCE      OMAP3_MPU_SOURCE
> #define OMAP4_CLKEV_SOURCE      OMAP4_MPU_SOURCE
> #define OMAP3_SECURE_TIMER      1
> #endif
> 
> And lets make 32k_fclk as default clocksource for gptimer, if it is being
> used as clocksource. Atleast with this I can clean whole omap2/3/4 families,
> and I can take omap1 thing later .
> (as I have to understand/read about omap1 first).
> 
> If you agree, I can include this cleanup also in my next version of patch-
> series. What's your opinion here?
> 
I am ok with this clean up. But I let Tony take decision on it.

Regards
Santosh
