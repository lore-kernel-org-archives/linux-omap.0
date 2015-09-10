From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: mysterious crashes on OMAP5 uevm
Date: Thu, 10 Sep 2015 08:42:57 +0200
Message-ID: <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150908210708.GH4215@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Grazvydas Ignotas <notasas@gmail.com>, Marek Belisko <marek@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


Am 08.09.2015 um 23:07 schrieb Tony Lindgren <tony@atomide.com>:

> * Grazvydas Ignotas <notasas@gmail.com> [150908 13:44]:
>> On Tue, Sep 8, 2015 at 4:38 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Grazvydas Ignotas <notasas@gmail.com> [150908 05:50]:
>>>> Hi,
>>>> =

>>>> this is a longstanding problem I'm seeing since the very beginning,
>>>> which was around 3.12 or so (when I've first got the hardware) and it
>>>> seems 4.2 is affected by it still. Basically what happens is Xorg
>>>> randomly segfaults at some "impossible" location. I don't have the
>>>> details at the moment (could get them is needed), but from what I
>>>> examined with gdb some time ago the situation did not make any sense.
>>>> =

>>>> There are 2 workarounds that I know which make the problem go away
>>>> (one is enough):
>>>> - recompile Xorg with -marm (I'm using Debian armhf so it's thumb2 by =
default)
>>>> - disable ARCH_MULTI_V6 in the kernel config
>>>> =

>>>> Because of the above workarounds I have forgotten about it several
>>>> times, but it regularly comes back and bites again. It would look like
>>>> some missing erratum workaround, but I have all of them enabled in the
>>>> kernel.
>>>> =

>>>> Does anyone know about this? Perhaps some missing erratum workaround
>>>> in the bootloader? u-boot isn't too old here (2015.07).
>>> =

>>> Seems like some incorrect handling with CONFIG_CPU_V6 compiled in..
>>> Maybe try to narrow it down by commenting out some CONFIG_CPU_V6 and
>>> __LINUX_ARM_ARCH__ =3D 6 ifdefs in the git grep CONFIG_CPU_V6
>>> places ignoring uncompress and davinci code.
>> =

>> ok with that it was quite easy to find. On a kernel with ARCH_MULTI_V6
>> disabled, it is enough to just do this:
>> =

>> --- a/arch/arm/kernel/signal.c
>> +++ b/arch/arm/kernel/signal.c
>> @@ -340,13 +340,13 @@ setup_return(struct pt_regs *regs, struct ksignal =
*ksig,
>>                /*
>>                 * The LSB of the handler determines if we're going to
>>                 * be using THUMB or ARM mode for this signal handler.
>>                 */
>>                thumb =3D handler & 1;
>> =

>> -#if __LINUX_ARM_ARCH__ >=3D 7
>> +#if 0 //__LINUX_ARM_ARCH__ >=3D 7
>>                /*
>>                 * Clear the If-Then Thumb-2 execution state
>>                 * ARM spec requires this to be all 000s in ARM mode
>>                 * Snapdragon S4/Krait misbehaves on a Thumb=3D>ARM
>>                 * signal transition without this.
>>                 */
>> =

>> ... and the problem appears, so I guess this needs some real
>> multiplatform handling,.
> =

> OK nice to hear you found it. Yeah looks like some runtime
> capability check is needed.
> =

>>> Do you have some easy way to reproduce this issue?
>> =

>> Just moving a browser window around with mouse usually triggers it
>> within a minute.
> =

> OK good to know.

It looks as if this is the solution for the same symptom on our OMAP3 board=
 (gta04).
There, it suffices to draw on the touch screen for ~10 seconds to make the =
xserver segfault.

[we are using the binary xserver from debian wheezy
ii  xserver-xorg-core                        2:1.12.4-6+deb7u5             =
armhf        Xorg X server - core server]

We know about this bug for a while, but so far did think that some touch sc=
reen
event bit has changed and we have to fix our touch screen driver.

Now, disabling CONFIG_ARCH_MULTI_V6 also makes the bug go away and adding t=
he
>> #if 0 //__LINUX_ARM_ARCH__ >=3D 7
makes it re-appear.

A while ago I tried to debug running the x-server under strace and could fi=
nd that it also has
something to do with SIGALRM.

And that is very consistent with =93enable/disable=94 by modifying arch/arm=
/kernel/signal.c

BR,
Nikolaus
