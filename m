From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v7 0/6] PM QoS: implement the OMAP low level constraints
 management code
Date: Tue, 1 May 2012 10:38:31 +0200
Message-ID: <CAORVsuWMuSrxWvM37gCS4HqzCmHqVCq=H9Oe2G0U=OS15L=aiw@mail.gmail.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
	<877gwwlsl3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38512 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530Ab2EAIic convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 04:38:32 -0400
Received: by vcqp1 with SMTP id p1so2609667vcq.19
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 01:38:31 -0700 (PDT)
In-Reply-To: <877gwwlsl3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hi Kevin,

On Tue, May 1, 2012 at 1:15 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> . Implement the devices wake-up latency constraints using the global
>> =A0 device PM QoS notification handler which applies the constraints=
 to the
>> =A0 underlying layer,
>> . Implement the low level code which controls the power domains next
>> =A0 functional power states [3], through the hwmod and pwrdm layers,
>> . Add cpuidle and power domains wake-up latency figures for OMAP3, c=
f.
>> =A0 comments in the code and [1] for the details on where the number=
s
>> =A0 are magically coming from,
>> . Implement the relation between the cpuidle and per-device PM QoS f=
rameworks
>> =A0 in the OMAP3 specific idle callbacks.
>> =A0 The chosen C-state shall satisfy the following conditions:
>> =A0 =A0. the 'valid' field is enabled,
>> =A0 =A0. it satisfies the enable_off_mode flag,
>> =A0 =A0. the next state for MPU and CORE power domains is not lower =
than the
>> =A0 =A0 =A0state programmed by the per-device PM QoS.
>
> I've just been through this series and it looks good to me.
>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
Thx for reviewing!

>> ToDo:
>> 1. support OMAP4 chipset when the low power modes will be supported
>
> Have you been able to do this with Tero's latest CORE RET and device =
off
> series?
No I still have to port Tero's latest patch set on top of the
functional power states and the constraints code. This is on my
ToDoNext list ;p

>
> Kevin
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
