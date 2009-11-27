From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: OMAP3: enabling CPU idle leads to panic
Date: Fri, 27 Nov 2009 14:32:57 +0300
Message-ID: <48239d390911270332tdf05c1lb5014e56cd3aa18b@mail.gmail.com>
References: <48239d390911240713v50bcae9ek855fb1e07c081486@mail.gmail.com>
	 <873a43wzfm.fsf@deeprootsystems.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DC@dbde02.ent.ti.com>
	 <48239d390911250737q35fc602fu9bce0b0f96f6970d@mail.gmail.com>
	 <87iqcyh5p5.fsf@deeprootsystems.com>
	 <48239d390911270202s3f6fcdbchaa7053bace5c36@mail.gmail.com>
	 <48239d390911270248se826f84r84d6b42cbd69344@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9217@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52096 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbZK0Lcw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 06:32:52 -0500
Received: by ewy19 with SMTP id 19so1311271ewy.21
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 03:32:57 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9217@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 27, 2009 at 2:02 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: Sergey Lapin [mailto:slapinid@gmail.com]
>> Sent: Friday, November 27, 2009 4:19 PM
>> To: Kevin Hilman
>> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
>> Subject: Re: OMAP3: enabling CPU idle leads to panic
>>
>> Hi, all!
>>
>> I've found the particular reason for my troubles with CPU idle,
>> since there's no core_pwrdm defined for OMAP3525 CPU.
>>
>> How could I create soch structure or is there anybody having
>> this handy?
>> 3523 is basically 3530 without 3D graphics.
>>
> The core_pwdm is defined in powerdomains34xx.h based on
> CONFIG_ARCH_OMAP34XX. This should be true for OMAP3525 as well.

Alas, that's not because omap_chip_is() function fails
on these structures.
