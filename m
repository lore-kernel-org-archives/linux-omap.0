From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, GPIO and Regulator due
 for the v4.9 merge window
Date: Tue, 13 Sep 2016 10:32:49 +0200
Message-ID: <CACRpkdYLO3ih7vDfUk3rGq-59J2OWz2ZON8qHGQLFNbicGZYYA@mail.gmail.com>
References: <1472633892-8261-1-git-send-email-j-keerthy@ti.com>
 <20160831122435.GD9415@dell> <CACRpkdbfOdaouKEooLsGRYXhbwkjfNoTXTqunumF4bOPjOUD4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbfOdaouKEooLsGRYXhbwkjfNoTXTqunumF4bOPjOUD4w@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>, Mark Brown <broonie@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 7, 2016 at 10:03 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 31, 2016 at 2:24 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:
>>
>>   Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-regulator-v4.9
>
> Hm it is based on a later release candidate than my tree so I'll wait
> and see if I
> have to pull it (like if there are clashes in linux-next...)

Bah I'm getting patches for the GPIO driver so I caved in and
merged v4.8-rc1 and then pulled in this, all looks good.

Yours,
Linus Walleij
