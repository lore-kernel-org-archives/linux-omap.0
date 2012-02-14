From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
Date: Tue, 14 Feb 2012 12:45:11 +0530
Message-ID: <CAMQu2gxnHE8fps6LD93B2G_w-p=i7YmuadasPrE-601-S8mUkA@mail.gmail.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
 <20120210191813.GU1426@atomide.com> <4F39EDD0.9010304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:53794 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753288Ab2BNHPe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 02:15:34 -0500
Received: by mail-qy0-f174.google.com with SMTP id w6so3915429qcq.5
        for <linux-omap@vger.kernel.org>; Mon, 13 Feb 2012 23:15:31 -0800 (PST)
In-Reply-To: <4F39EDD0.9010304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 14, 2012 at 10:44 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Saturday 11 February 2012 12:48 AM, Tony Lindgren wrote:
>>
>> * Santosh Shilimkar<santosh.shilimkar@ti.com> =A0[120202 05:33]:
>>>
>>> > =A0From: Rajendra Nayak<rnayak@ti.com>
>>> >
>>> > =A0hwmod setup already does a reset and sets the OCP sysconfig
>>> > =A0registers appropriately. Avoid doing a reset again and overrid=
ing
>>> > =A0the OCP sysconfig settings in the system timer init code.
>
>>
>>
>> If we want this queued as a fix, it should also describe what
>> actually breaks? Timer? PM?
>
>
> It only fixes the redundant reset and overriding the smartidle-wakeup
> OCP setting (done by hwmod) with the smartidle in the driver.
> Doing this doesn't really break anything as yet in mainline, but will
> cause timer wakeup issues once OFF mode is in place for OMAP4. On OMA=
P5
> however this was causing more issues as the softreset bit position is
> different than on OMAP2/3/4.
> So it should be ok to queue this in for 3.4 considering neither OMAP4
> OFF, not OMAP5 support is in mainline yet.
>
I second Rajendra's comment.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
