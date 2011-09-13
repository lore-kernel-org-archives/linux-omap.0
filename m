From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 21/25] OMAP4: PM: Add MPUSS power domain OSWR support
Date: Tue, 13 Sep 2011 13:55:34 +0530
Message-ID: <4E6F137E.30105@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-22-git-send-email-santosh.shilimkar@ti.com>	<87obypfvah.fsf@ti.com>	<4E6EEC35.8080203@ti.com> <CAORVsuUaR8pcZ4MYigi85tmtWspz3tR_OJcvhaB0AFRLRaAANw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:34619 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753596Ab1IMIZm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Sep 2011 04:25:42 -0400
Received: by gyg13 with SMTP id 13so263821gyg.8
        for <linux-omap@vger.kernel.org>; Tue, 13 Sep 2011 01:25:40 -0700 (PDT)
In-Reply-To: <CAORVsuUaR8pcZ4MYigi85tmtWspz3tR_OJcvhaB0AFRLRaAANw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Tuesday 13 September 2011 01:09 PM, Jean Pihet wrote:
> Hi Santosh,
>
> On Tue, Sep 13, 2011 at 7:37 AM, Santosh<santosh.shilimkar@ti.com>  wrote:
>> On Tuesday 13 September 2011 12:22 AM, Kevin Hilman wrote:
>>>

[..]

>>>
>>>>   static inline int omap4_finish_suspend(unsigned long cpu_state)
>>>>   {}
> This one should return 0, as I already pointed out in the comments for [14/25].
>
Taken care already.

Regards
Santosh
