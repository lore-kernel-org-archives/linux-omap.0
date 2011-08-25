From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 0/2] OMAP: Update nr_irqs field in machine descriptors
Date: Thu, 25 Aug 2011 20:25:13 +0530
Message-ID: <CANfBPZ-AAZx9TxO88EgxCtOUsWrsYzbK+M2d6cVSS7Kf-LwS3w@mail.gmail.com>
References: <1314215215-18683-1-git-send-email-svenkatr@ti.com> <4E5636CD.4080302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:57104 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752414Ab1HYOze convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 10:55:34 -0400
Received: by vxj14 with SMTP id 14so1915873vxj.20
        for <linux-omap@vger.kernel.org>; Thu, 25 Aug 2011 07:55:33 -0700 (PDT)
In-Reply-To: <4E5636CD.4080302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 25, 2011 at 5:19 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Venkat,
>
> On 8/24/2011 9:46 PM, S, Venkatraman wrote:
>>
>> As part of an effort to get single ARM kernel binary [1],
>> multiple =A0definitions of NR_IRQS under various platforms
>> have to be reconciled and abstracted away from common code.
>>
>> This patch series takes the small step of populating the
>> machine descriptors with the pre-existing nr_irqs field.
>> Eventually, the common irq handler code will only look at this
>> field and not the compile time constant.
>
> Not related to this patch, but still on that topic. The current NR_IR=
QS
> depends as well on board stuff, like for example : the Phoenix
> IRQs:TWL6030_IRQ_BASE, TWL6040_CODEC_IRQ_BASE.
> Is there a plan to get rid of this static defines?
>

Currently, the goal is to get rid of the singleton nature
of NR_IRQS. Then it just becomes a property of the
platform, and the arm common code should not see this define.
This cleanup has to be done across multiple SoCs, not just OMAP.

After I get to complete some meaningful cleanup of NR_IRQS,
I can look into the static defines that you mention.

Best regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
