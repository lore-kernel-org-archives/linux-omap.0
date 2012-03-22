From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 0/3] OMAP2+: UART: Enable tx wakeup + remove cpu checks
Date: Thu, 22 Mar 2012 12:29:56 +0530
Message-ID: <CAMrsUdLtC0iVk2qDDDXj2tteAzP5UQJXNvsCoJLEC9Yty2QjvQ@mail.gmail.com>
References: <1332325501-10467-1-git-send-email-govindraj.raja@ti.com> <87limurpsx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87limurpsx.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 21, 2012 at 7:58 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> Based on Linux-OMAP tree uart branch.
>> (git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>> remotes/origin/uart)
>>
>> * Removes the cpu checks wherever possible and use version reg
>> =A0 for populating features and errata's
>> * enable tx wakeup available in wer reg for applicable
>> =A0 module revision's
>
> As this affects multiple SoCs, please report what SoCs it was tested =
on
> as well.

Sorry I for got to add that, here are details on what was tested.

1.) OMAP2430 SDP : Boot tested with uart1 as console.

2.) OMAP3430 SDP: Boot test, suspend/resume tests, retention off mode
                               (checking retention and off mode count
in cpu idle cases)

3.) OMAP3630 - Beagle XM:  Boot test, suspend/resume tests, retention o=
ff mode
                                            (checking retention and
off mode count in cpu idle cases)

4.) OMAP4430 - PANDA: Boot test, suspend/resume tests

5.) OMAP4460 - PANDA: Boot test.

--
Thanks,
Govindraj.R


>
> Thanks,
>
> Kevin
>
>> Govindraj.R (3):
>> =A0 OMAP2+: UART: Remove cpu checks for populating errata flags
>> =A0 OMAP2+: UART: enable tx wakeup bit for wer reg
>> =A0 OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap2=
4xx
>>
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 13 +----
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A08 +++-
>> =A0drivers/tty/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 71 ++++++++++++++++++++++++-
>> =A03 files changed, 78 insertions(+), 14 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
