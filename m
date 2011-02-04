From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH 2/2] ARM: Make CONFIG_FPE_NWFPE depend on !CONFIG_THUMB2_KERNEL
Date: Fri, 4 Feb 2011 12:01:21 +0000
Message-ID: <AANLkTik5A0nKtOvV=Ga4mtUasJ0vhHem+nx00Rpo3JV2@mail.gmail.com>
References: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
	<1291895982-4775-3-git-send-email-dave.martin@linaro.org>
	<20110204110342.GE15004@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42480 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab1BDMBW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 07:01:22 -0500
Received: by eye27 with SMTP id 27so1182834eye.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 04:01:21 -0800 (PST)
In-Reply-To: <20110204110342.GE15004@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Fri, Feb 4, 2011 at 11:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 09, 2010 at 11:59:42AM +0000, Dave Martin wrote:
>> Because the nwfpe support is unlikely to be used on new platforms
>> and requires CONFIG_OABI_COMPAT, which is not generally used with
>> ARMv7+, we shouldn't expect to build nwfpe support into a Thumb-2
>> kernel.
>>
>> At present, nwfpe contains assembly code which isn't Thumb-2
>> compatible, and for now it doesn't appear useful to port this
>> code.
>
> You might as well make OABI_COMPAT depend on !THUMB2_KERNEL. =A0OABI
> userland is useless without FPA support.
>

Sure.  The original patch is already upstream, but I can roll a
supplementary patch for this.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
