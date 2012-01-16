From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v6 0/6] PM QoS: implement the OMAP low level constraints
 management code
Date: Mon, 16 Jan 2012 20:57:51 +0100
Message-ID: <CAORVsuVNvvPu6it7r_uxc0f6H-9kpo6SChTTGkdqpLmzMDNxvQ@mail.gmail.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1112191337420.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56963 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab2APT5v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jan 2012 14:57:51 -0500
Received: by vbbfp1 with SMTP id fp1so493231vbb.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 11:57:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112191337420.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <j-pihet@ti.com>

Paul, Kevin,

On Mon, Dec 19, 2011 at 10:02 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Jean
>
> I'm really sorry it's taken me so long to do detailed review of these
> patches for merging... anyway -
>
> On Wed, 14 Dec 2011, jean.pihet@newoldbits.com wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> . Implement the devices wake-up latency constraints using the global
>> =A0 device PM QoS notification handler which applies the constraints=
 to the
>> =A0 underlying layer
>> . Implement the low level code which controls the power domains next=
 power
>> =A0 states, through the hwmod and pwrdm layers
>> . Add cpuidle and power domains wake-up latency figures for OMAP3, c=
f.
>> =A0 comments in the code and [1] for the details on where the number=
s
>> =A0 are magically coming from
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
> I've been reviewing these closely. =A0It looks to me that are some is=
sues
> that need to be resolved before all of them are mergeable.
>
> One issue that I noticed in this series is that there are some lockin=
g
> issues in patch 1. =A0It looks to me that calls to
> _pwrdm_wakeuplat_update_pwrst() can race with each other, since it's
> called outside the lock?
I fixed this by moving the lock so that it includes the update of the
next power state.

Speaking of the locking, currently a spinlock is used and it could be
replaced by a more efficient mutex. This is ok at the condition that
this code is not called from interrupt context?

Kevin,
Do you know if the per-device constraint code can be called from
interrupt context?

>

=2E..

>
>
> - Paul

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
