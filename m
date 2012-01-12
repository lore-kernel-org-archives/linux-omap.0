From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the AVS
 driver framework
Date: Thu, 12 Jan 2012 12:12:58 +0100
Message-ID: <CAORVsuXpC=fiEpiiHZAR3pRyLEyaV6yiJGxokEdke7m7dNP1nQ@mail.gmail.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
	<1321974370-25800-26-git-send-email-j-pihet@ti.com>
	<20111123233437.GA17638@google.com>
	<877h0xviw0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54101 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab2ALLM7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 06:12:59 -0500
Received: by vbmv11 with SMTP id v11so226870vbm.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 03:12:58 -0800 (PST)
In-Reply-To: <877h0xviw0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Todd Poynor <toddpoynor@google.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, balbi@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>, nm@ti.com

Kevin, Todd,

On Thu, Jan 12, 2012 at 1:55 AM, Kevin Hilman <khilman@ti.com> wrote:
> Todd Poynor <toddpoynor@google.com> writes:
>
>>> +static irqreturn_t _interrupt(int irq, void *data)
>>> +{
>>> + =A0 =A0struct smartreflex *sr =3D (struct smartreflex *)data;
>>> + =A0 =A0u32 status =3D 0;
>>> +
>>> + =A0 =A0/* Read the status bits */
>>> + =A0 =A0sr_read_reg(sr, IRQSTATUS);
>>> +
>>> + =A0 =A0/* Clear them by writing back */
>>> + =A0 =A0sr_write_reg(sr, IRQSTATUS, status);
>>
>> Felipe Balbi sent a patch to the list fixing the write of zero,
>> failing to clear the interrupts, to the list recently.
>
> Right, this patch is in mainline now[1], so rebasing this series shou=
ld
> pick up this change.
I did include all the latest fixes from Felipe and Nishant in the
latest version. More details to come in the chang e logs.

Jean

>
> Kevin
>
> [1]
> commit 5a4f1844c2ba21f804d7729306d9b16eaeb724a8
> Author: Felipe Balbi <balbi@ti.com>
> Date: =A0 Wed Nov 23 14:43:37 2011 -0800
>
> =A0 =A0ARM: OMAP: smartreflex: fix IRQ handling bug
>
> =A0 =A0Fix a bug which has been on this driver since
> =A0 =A0it was added by the original commit 984aa6db
> =A0 =A0which would never clear IRQSTATUS bits.
>
> =A0 =A0Signed-off-by: Felipe Balbi <balbi@ti.com>
> =A0 =A0Signed-off-by: Kevin Hilman <khilman@ti.com>
> =A0 =A0Cc: stable@vger.kernel.org
> =A0 =A0Signed-off-by: Tony Lindgren <tony@atomide.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
