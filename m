From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: mainline/master boot bisection: v4.19-12838-g71e56028173b on
 beagle-xm
Date: Fri, 9 Nov 2018 09:52:10 +0100
Message-ID: <CACRpkdbNysJmw4ZGMhPFY0S7Vp=jwQQtTWcuaLJTbxqCBdfofQ@mail.gmail.com>
References: <5bdebe88.1c69fb81.3857a.05d1@mx.google.com>
 <a4d3b4ea-fcc5-f65b-70e2-bd12f089d0e6@collabora.com>
 <CAOesGMgcuGKgNiN44jOS_9qRo3es8W6kt5-o676ouwpcAZC6KQ@mail.gmail.com>
 <0ca97dae-86ee-8b75-52be-09cdaea3999f@collabora.com>
 <4b7922f2-6428-3011-0338-9c0662712b8a@collabora.com>
 <7hbm6z6vw4.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7hbm6z6vw4.fsf@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, ext Tony Lindgren <tony@atomide.com>, guillaume.tucker@collabora.com, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Mark Brown <broonie@kernel.org>, matthew.hart@linaro.org, Olof Johansson <olof@lixom.net>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 8, 2018 at 11:34 PM Kevin Hilman <khilman@baylibre.com> wrote:

> Upon closer inspection, the load addrs are such that it appears the DTB
> is getting overwritten during zImage compression.
>
> So bascially, it's just an (un)lucky fluke that CONFIG_PREEMPT=y changed
> the kernel size just enough to cause this problem.

Oh that kind of bug. It has bitten me more than once :(

Thanks a lot for rootcausing this Kevin!

Yours,
Linus Walleij
