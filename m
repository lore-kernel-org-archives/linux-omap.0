From: Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Re: mainline/master boot bisection: v4.19-12838-g71e56028173b on
 beagle-xm
Date: Tue, 6 Nov 2018 10:54:26 +0000
Message-ID: <0ca97dae-86ee-8b75-52be-09cdaea3999f@collabora.com>
References: <5bdebe88.1c69fb81.3857a.05d1@mx.google.com>
 <a4d3b4ea-fcc5-f65b-70e2-bd12f089d0e6@collabora.com>
 <CAOesGMgcuGKgNiN44jOS_9qRo3es8W6kt5-o676ouwpcAZC6KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOesGMgcuGKgNiN44jOS_9qRo3es8W6kt5-o676ouwpcAZC6KQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@baylibre.com>, LinusW <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, matthew.hart@linaro.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 05/11/2018 14:33, Olof Johansson wrote:
> On Mon, Nov 5, 2018 at 1:43 AM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> Hi Linus,
>>
>> Please see below, the kernelci.org automated boot bisection found
>> that the OMAP3 BeagleBoard-xM is failing to boot with SMP
>> disabled and PREEMPT enabled in multi_v7_defconfig.  There is no
>> log output after the bootloader so the kernel seems to be
>> crashing very early on.
> 
> Can you enable DEBUG_LL to capture what goes wrong?

Yes I've scheduled a re-run of the automated bisection with
DEBUG_LL turned on, but the beagle-xm board is currently offline
in lab-baylibre.  I'll keep you posted when I get some results.

> The regression is on me. Linus sent the patch, but I was trigger happy
> and applied it to fixes instead of letting it soak in -next longer.
> 
> I'll revert it in our fixes branch and send it in quickly, and apply
> it to a branch picked up by -next instead.

Ack - will also keep an eye on boot reports.

Guillaume
