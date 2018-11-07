From: Olof Johansson <olof@lixom.net>
Subject: Re: mainline/master boot bisection: v4.19-12838-g71e56028173b on
 beagle-xm
Date: Wed, 7 Nov 2018 08:16:47 -0800
Message-ID: <CAOesGMgAxvERhQjnyZ7P4vqhhWdBdA20XrFnDn48Na5wrEAkEA@mail.gmail.com>
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
To: guillaume.tucker@collabora.com
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@baylibre.com>, LinusW <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Matt Hart <matthew.hart@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 7, 2018 at 8:09 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On 06/11/2018 10:54, Guillaume Tucker wrote:
> > On 05/11/2018 14:33, Olof Johansson wrote:
> >> On Mon, Nov 5, 2018 at 1:43 AM Guillaume Tucker
> >> <guillaume.tucker@collabora.com> wrote:
> >>>
> >>> Hi Linus,
> >>>
> >>> Please see below, the kernelci.org automated boot bisection found
> >>> that the OMAP3 BeagleBoard-xM is failing to boot with SMP
> >>> disabled and PREEMPT enabled in multi_v7_defconfig.  There is no
> >>> log output after the bootloader so the kernel seems to be
> >>> crashing very early on.
> >>
> >> Can you enable DEBUG_LL to capture what goes wrong?
> >
> > Yes I've scheduled a re-run of the automated bisection with
> > DEBUG_LL turned on, but the beagle-xm board is currently offline
> > in lab-baylibre.  I'll keep you posted when I get some results.
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

Is this only beagle-xm, or do we see it on all OMAP3 hardware?


-Olof
