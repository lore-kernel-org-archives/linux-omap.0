From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: In many cases softlockup can not be reported after disabling
 IRQ for long time
Date: Wed, 01 Feb 2012 18:51:33 +0800
Message-ID: <4F291935.2030205@gmail.com>
References: <CAOwKts8zS1rYA+Y4k-vb8YAaR=aFd1BwryhhWWnWLQyrYrNqyA@mail.gmail.com> <20120131154748.GA5650@redhat.com> <CAOwKts_dTvc4LiCZUXN9oYzty1pkDEn_VQwPKY=EoVzk0n6tFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOwKts_dTvc4LiCZUXN9oYzty1pkDEn_VQwPKY=EoVzk0n6tFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

(Please don't top-reply.)

On 02/01/2012 10:18 AM, TAO HU wrote:
> Hi, Don
>
> Thanks for your feedback!
>
> Unfortunately, the hardlockup depends on NMI which is not available on
> ARM (Cortex-A9) per my understanding.
> Our system uses OMAP4430. Any more suggestions?

When there is no NMI, touch_nmi_watchdog() actually touches softlockup 
watchdog:

#if defined(ARCH_HAS_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
#include <asm/nmi.h>
extern void touch_nmi_watchdog(void);
#else
static inline void touch_nmi_watchdog(void)
{
         touch_softlockup_watchdog();
}
#endif

so you need to check if other places calling touch_nmi_watchdog() 
especially on ARM.
