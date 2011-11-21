From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v8 17/20] OMAP2+: UART: Use custom activate func for
 console uart.
Date: Mon, 21 Nov 2011 19:17:42 +0530
Message-ID: <CAAL8m4yft7_SQFrXtDZg5X5SJrKep0_j5D9_y1-QooSox+HZpg@mail.gmail.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-3-git-send-email-govindraj.raja@ti.com> <87vcqhuns9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50626 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab1KUNsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Nov 2011 08:48:04 -0500
In-Reply-To: <87vcqhuns9.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Sat, Nov 19, 2011 at 2:54 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Omap-uart can be used as console uart to print early boot
>> messages using earlyprintk so for console uart prevent
>> hwmod reset or idling during bootup.
>>
>> Identify the console_uart set the id and use the custom
>> pm_latency ops for console uart for the first time
>> to idle console uart left enabled from bootup and then enable
>> them back and reset pm_latency ops to default ops.
>>
>> Thanks to Kevin Hilman <khilman@ti.com> for suggesting
>> this approach.
>
> You're welcome, but Rajendra's solution is much better. ;)

Agree.

>
> Can you updated your branch without these custom hooks and using
> Rajendra's INIT_NO_IDLE change to the hwmod core.
>

Yes done, rebased on 3.2-rc2 and created a new branch [1].

Removed custom activate function usage and used Rajendra's hwmod patch[2]

--
Thanks,
Govindraj.R

[1]:
git://gitorious.org/runtime_3-0/runtime_3-0.git
3.2-rc1_uart_runtime

[2]:
http://permalink.gmane.org/gmane.linux.ports.arm.omap/66974
