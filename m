From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] omap: prcm: switch to a chained IRQ handler mechanism
Date: Wed, 17 Nov 2010 17:38:34 +0100
Message-ID: <4CE4050A.6040204@ti.com>
References: <1289996179-17698-1-git-send-email-thomas.petazzoni@free-electrons.com>	<4CE3D96A.5010004@ti.com> <87tyjg6i4e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50690 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934890Ab0KQQik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 11:38:40 -0500
In-Reply-To: <87tyjg6i4e.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Petazzoni-XID, Thomas" <t-petazzoni@ti.com>

On 11/17/2010 5:16 PM, Kevin Hilman wrote:
> "Cousson, Benoit"<b-cousson@ti.com>  writes:
>
> [...]
>
>>> +#define OMAP_MPUIO_IRQ_END	(IH_MPUIO_BASE + 16)
>>> +
>>> +/* 32 IRQs for the PRCM */
>>> +#define OMAP_PRCM_IRQ_BASE                 (OMAP_MPUIO_IRQ_END)
>>> +#define INT_34XX_PRCM_WKUP_EN              (OMAP_PRCM_IRQ_BASE +  0)
>>> +#define INT_34XX_PRCM_EVGENON_EN           (OMAP_PRCM_IRQ_BASE +  2)
>>> +#define INT_34XX_PRCM_EVGENOFF_EN          (OMAP_PRCM_IRQ_BASE +  3)
>>> +#define INT_34XX_PRCM_TRANSITION_EN        (OMAP_PRCM_IRQ_BASE +  4)
>>> +#define INT_34XX_PRCM_CORE_DPLL_RECAL_EN   (OMAP_PRCM_IRQ_BASE +  5)
>>> +#define INT_34XX_PRCM_PERIPH_DPLL_RECAL_EN (OMAP_PRCM_IRQ_BASE +  6)
>>> +#define INT_34XX_PRCM_MPU_DPLL_RECAL_EN_EN (OMAP_PRCM_IRQ_BASE +  7)
>>> +#define INT_34XX_PRCM_IVA2_DPLL_RECAL_EN   (OMAP_PRCM_IRQ_BASE +  8)
>>> +#define INT_34XX_PRCM_IO_EN                (OMAP_PRCM_IRQ_BASE +  9)
>>> +#define INT_34XX_PRCM_VP1_OPPCHANGEDONE_EN (OMAP_PRCM_IRQ_BASE + 10)
>>> +#define INT_34XX_PRCM_VP1_MINVDD_EN        (OMAP_PRCM_IRQ_BASE + 11)
>>> +#define INT_34XX_PRCM_VP1_MAXVDD_EN        (OMAP_PRCM_IRQ_BASE + 12)
>>> +#define INT_34XX_PRCM_VP1_NOSMPSACK_EN     (OMAP_PRCM_IRQ_BASE + 13)
>>> +#define INT_34XX_PRCM_VP1_EQVALUE_EN       (OMAP_PRCM_IRQ_BASE + 14)
>>> +#define INT_34XX_PRCM_VP1_TRANXDONE_EN     (OMAP_PRCM_IRQ_BASE + 15)
>>> +#define INT_34XX_PRCM_VP2_OPPCHANGEDONE_EN (OMAP_PRCM_IRQ_BASE + 16)
>>> +#define INT_34XX_PRCM_VP2_MINVDD_EN        (OMAP_PRCM_IRQ_BASE + 17)
>>> +#define INT_34XX_PRCM_VP2_MAXVDD_EN        (OMAP_PRCM_IRQ_BASE + 18)
>>> +#define INT_34XX_PRCM_VP2_NOSMPSACK_EN     (OMAP_PRCM_IRQ_BASE + 19)
>>> +#define INT_34XX_PRCM_VP2_EQVALUE_EN       (OMAP_PRCM_IRQ_BASE + 20)
>>> +#define INT_34XX_PRCM_VP2_TRANXDONE_EN     (OMAP_PRCM_IRQ_BASE + 21)
>>> +#define INT_34XX_PRCM_VC_SAERR_EN          (OMAP_PRCM_IRQ_BASE + 22)
>>> +#define INT_34XX_PRCM_VC_RAERR_EN          (OMAP_PRCM_IRQ_BASE + 23)
>>> +#define INT_34XX_PRCM_VC_TIMEOUT_ERR_EN    (OMAP_PRCM_IRQ_BASE + 24)
>>> +#define INT_34XX_PRCM_SND_PERIPH_RECAL_EN  (OMAP_PRCM_IRQ_BASE + 25)
>>> +#define INT_36XX_PRCM_ABB_LDO_TRANXDONE_EN (OMAP_PRCM_IRQ_BASE + 26)
>>> +#define INT_36XX_PRCM_VC_VP1_ACK_EN        (OMAP_PRCM_IRQ_BASE + 27)
>>> +#define INT_36XX_PRCM_VC_BYPASS_ACK_EN     (OMAP_PRCM_IRQ_BASE + 28)
>>> +#define OMAP_PRCM_NR_IRQS                  32
>>> +#define OMAP_PRCM_IRQ_END                  (OMAP_PRCM_IRQ_BASE + \
>>> +					    OMAP_PRCM_NR_IRQS)
>>
>> We are in the process of getting rid of all the IRQ defines thanks to
>> hwmod. Maybe we should consider moving that to hwmod data? I'm not
>> sure exactly how we will handle that case but it might worth
>> considering it.
>
> What hwmod would these be attached to?  I guess that would mean creating
> a hwmod for the PRM, and attatching the IRQs there?

Yep. I already have that in some of my secret branches, because, I'd 
like at some point to leverage hwmod data even for infrastructure code 
(prcm, control module).

> Taht being said, is hwmod the right place for these "virtual" IRQs?
> These IRQs are internal to that IP, and not really integration IRQs.

Well, yes, that's why I was wondering as well if hwmod data is the right 
place.
Anyway, we should probably consider a table with the same kind of 
information hwmod is using in order to have a flexible management for 
every OMAPs.

>> If we do want to make that code OMAP generic, we will probably have to.
>>
>> That being said, that patch is already a good improvement compared to
>> the previous solution. So maybe we should do that in several phases.
>>
>> Kevin,
>> Any thoughts on that?
>
> I think this needs some more discussion, and probably a separate phase
> since we don't currently have hwmods for PRM or CM, at least on OMAP3.

That part is easy to fix... We just have to "create" them :-)

Benoit
