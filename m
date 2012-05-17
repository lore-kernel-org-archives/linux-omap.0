From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 11/19] ARM: OMAP4: PM: save/restore CM L3INSTR registers
 when MPU hits OSWR/OFF mode
Date: Thu, 17 May 2012 12:23:08 +0530
Message-ID: <CAMQu2gxqkCzGZfn-X1e+n=07iZ75qk30udPUk+VPjaZAgQPqLw@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-12-git-send-email-t-kristo@ti.com> <87sjez67i4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:58859 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759674Ab2EQGxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 02:53:31 -0400
Received: by qcse1 with SMTP id e1so1224138qcs.23
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 23:53:30 -0700 (PDT)
In-Reply-To: <87sjez67i4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Thu, May 17, 2012 at 4:47 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> On HS devices on the way out of MPU OSWR and OFF ROM code wrongly
>> overwrites the CM L3INSTR registers. So to avoid this, save them and
>> restore on the way out from MPU OSWR/OFF.
>>
>> This errata applies to all HS/EMU versions of OMAP4.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> [t-kristo@ti.com: added omap4 pm errata support]
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> Let's use the cluster PM notifiers here too, using the PM errata check
> when registering the notifier.
>
Good idea.
