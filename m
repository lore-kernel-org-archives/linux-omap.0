From: melwyn lobo <linux.melwyn@gmail.com>
Subject: Re: [PATCH] CPUIdle: Reevaluate C-states under CPU load to favor
 deeper C-states
Date: Tue, 20 Mar 2012 20:19:02 +0530
Message-ID: <CAHSGOuuexpCDNoP1G1Gyge2DCep0rsPmUwrVyZFDQ1_tH+Du7Q@mail.gmail.com>
References: <1316475315-5905-1-git-send-email-khilman@ti.com>
	<87d3d75zo6.fsf@ti.com>
	<4EBA6046.2060305@linux.vnet.ibm.com>
	<37CAE120BAE10B42A790DD1418C8021D0136C7@DNCE02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <37CAE120BAE10B42A790DD1418C8021D0136C7@DNCE02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chalhoub, Nicole" <n-chalhoub@ti.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Hey Kevin,
I would like to try out this patch in my platform see the benefits
that you are reporting. But there is one issue in this patch. You have
not initialized "hrtimer_timeout" variable.
This will always be 0 right ?.
Thanks,
-M

On Wed, Nov 9, 2011 at 11:36 PM, Chalhoub, Nicole <n-chalhoub@ti.com> w=
rote:
> Hi Deepthi,
>
>>
> Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve =
Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920
>
> -----Original Message-----
>> From: Deepthi Dharwar [mailto:deepthi@linux.vnet.ibm.com]
>> Sent: Wednesday, November 09, 2011 12:13 PM
>> To: Hilman, Kevin
>> Cc: linux-kernel@vger.kernel.org; Arjan van de Ven; linux-arm-
>> kernel@lists.infradead.org; linux-omap@vger.kernel.org; linux-
>> pm@lists.linux-foundation.org; Chalhoub, Nicole
>> Subject: Re: [PATCH] CPUIdle: Reevaluate C-states under CPU load to =
favor
>> deeper C-states
>
> [...]
>> By setting timers when we enter non-deepest C-state possible, such t=
hat
>> when it fires we
>> can re-evaluate and try moving into deeper and deeper C-states enhan=
cing
>> the
>> power savings is a good feature to have.
>>
>> Looking at the current implementation, is it possible to have it as
>> configurable option
>> where one can enable/disable this functionality through the backhand
>> driver ?
>
> The timeout values of the c state timers are set in the backhand driv=
er.
> By setting the timeout to 0 the timers will not fire so you'll not ha=
ve this functionality enabled
>
>> Also I am thinking, instead of having them in governor
>> wouldnt it be a good idea to have it implemented in
>> the backhand driver itself ?
>> --Deepthi
>
>
> In fact each C-state had its own configurable timer, so it is a param=
eter characterizing a C-state as it is for the exit_latency and target_=
residency parameters.
> And we wanted the timer to fire only when we do not go in deep Cstate=
 due to a high load. This decision is made in the CPU idle governor. So=
 the functionality should be seen from the governor..
>
> Thanks and Regards
> Nicole
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
