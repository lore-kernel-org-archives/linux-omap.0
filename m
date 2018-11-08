From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: mainline/master boot bisection: v4.19-12838-g71e56028173b on
 beagle-xm
Date: Thu, 08 Nov 2018 14:34:51 -0800
Message-ID: <7hbm6z6vw4.fsf@baylibre.com>
References: <5bdebe88.1c69fb81.3857a.05d1@mx.google.com>
 <a4d3b4ea-fcc5-f65b-70e2-bd12f089d0e6@collabora.com>
 <CAOesGMgcuGKgNiN44jOS_9qRo3es8W6kt5-o676ouwpcAZC6KQ@mail.gmail.com>
 <0ca97dae-86ee-8b75-52be-09cdaea3999f@collabora.com>
 <4b7922f2-6428-3011-0338-9c0662712b8a@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4b7922f2-6428-3011-0338-9c0662712b8a@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guillaume Tucker <guillaume.tucker@collabora.com>, Olof Johansson <olof@lixom.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, LinusW <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, matthew.hart@linaro.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Guillaume Tucker <guillaume.tucker@collabora.com> writes:

> On 06/11/2018 10:54, Guillaume Tucker wrote:
>> On 05/11/2018 14:33, Olof Johansson wrote:
>>> On Mon, Nov 5, 2018 at 1:43 AM Guillaume Tucker
>>> <guillaume.tucker@collabora.com> wrote:
>>>>
>>>> Hi Linus,
>>>>
>>>> Please see below, the kernelci.org automated boot bisection found
>>>> that the OMAP3 BeagleBoard-xM is failing to boot with SMP
>>>> disabled and PREEMPT enabled in multi_v7_defconfig.  There is no
>>>> log output after the bootloader so the kernel seems to be
>>>> crashing very early on.
>>>
>>> Can you enable DEBUG_LL to capture what goes wrong?
>> 
>> Yes I've scheduled a re-run of the automated bisection with
>> DEBUG_LL turned on, but the beagle-xm board is currently offline
>> in lab-baylibre.  I'll keep you posted when I get some results.
>
> Unfortunately, enabling the DEBUG_LL config didn't help.  There's
> still no visible kernel log at all from the failing LAVA jobs:
>
>     http://lava.baylibre.com:10080/scheduler/alljobs?length=25&search=lava-bisect-9638#table
>
>
> This might be a hard one to debug without physical access to the
> board, but please let me know if you think there's anything else
> I can try.  For example, if there's a known older kernel revision
> where the combination of SMP=n and PREEMPT=y worked then I could
> try to run an automated boot bisection based on that.

The reason DEBUG_LL doesn't show anything is because it also needs
a specific UART enabled for the output.  For the case of beagle-xm, it
needs CONFIG_DEBUG_OMAP3UART3=y also.

It did that locally, and the error on the console is this:

   Error: invalid dtb and unrecognized/unsupported machine ID
     r1=0x0000060a, r2=0x00000000
   Available machine support:

Upon closer inspection, the load addrs are such that it appears the DTB
is getting overwritten during zImage compression.

So bascially, it's just an (un)lucky fluke that CONFIG_PREEMPT=y changed
the kernel size just enough to cause this problem.

I did a local test (with pyboot, not LAVA) with all the same load
addresses, but without initrd_high and fdt_high, and it boots fine[1]

Guillaume, I think the proper solution is to fixup the LAVA device-type
for beagle-xm.  In particular, it's setting the u-boot variables
'initrd_high' and 'fdt_high' which means it's not letting uboot move
them.

Looks like that can be overridden in the device-dict using
"set base_high_limits = false", so I've done that now to this device[2]

Kevin

[1] http://termbin.com/9mm6
[2] http://lava.baylibre.com:10080/scheduler/device/omap3-beagle-xm-sea/devicedict
