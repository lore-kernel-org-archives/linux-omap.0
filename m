From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [linux-pm] [PATCH 0/3] coupled cpuidle state support
Date: Thu, 22 Dec 2011 14:05:36 +0530
Message-ID: <CAMQu2gxws83BUdj_eMbF0xpA1Mo_OA_MswE7KUm5pvbn3YbMuQ@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <4EF1A0B4.5080307@linux.intel.com> <CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw@mail.gmail.com>
 <4EF1AA8A.8060304@linux.intel.com> <CAMbhsRSNTUvou9Gf6T4Ggq=jfxsWUcn7M2yNsKQz6aNrt6gLDg@mail.gmail.com>
 <4EF1CD49.9020800@linux.intel.com> <CAMbhsRRnKoR3YPWrZzVynVe+dcuU5v0siYvmp2vbBcS1hquC7Q@mail.gmail.com>
 <4EF2352C.3060102@linux.intel.com> <CAMbhsRSPCo9MSGp57Fv0sRdYUFcdwx8jEz1-CfX8LdKf8X4MVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMbhsRSPCo9MSGp57Fv0sRdYUFcdwx8jEz1-CfX8LdKf8X4MVg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Cc: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 22, 2011 at 1:12 AM, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org> wrote=
:
> On Wed, Dec 21, 2011 at 11:36 AM, Arjan van de Ven
> <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>>>>
>>>> .. or it enters WFI, and a physical device sends it an interrupt,
>>>> at which point it exits.
>>>
>>> None of the cpus will return to the idle loop until all cpus have
>>> decremented the ready counter back to 0, so they can't wrap around
>>> again.
>>
>>
>> yikes, so you IPI all the cpus on the first exit.
>> that must burn power ;-(
>
> No, you're not understanding the point of this series.
>
> If your cpus can go in and out of idle independently, you don't use
> this code at all. =A0Each cpu can call WFI and come back out without
> talking to the other cpu.
>
Indeed. The SOCs, Arch's which does support low power
state independently and doesn't need any co-ordination between CPU's
will continue to work same way as before with this series.

> However, if you have two cpus that share some part of the SoC that ca=
n
> be turned off in idle, like the L2 cache controller or the system bus=
,
> the two cpus need to go to idle together, and they will both boot
> together when either one receives an interrupt (although one will
> likely immediately go back to a shallower state that doesn't require
> coordination with the other cpu). =A0There is no way around this, it'=
s
> how the hardware works on some ARM platforms.

Apart from shared peripherals which Colin pointed out, OMAP also
brings in the security software state which is kind of executing in
parallel with linux. This state is lost in certain deeper low power
states and since the security software is affine to only master CPU
(because of OMAP security architecture), the co-ordination is
mandatory to achieve those low power states.

So this additional CPU co-ordination logic for such C-states
really helps to solve the issue in most generic way.

Regards
Santosh
