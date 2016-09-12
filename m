From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, GPIO and Regulator due
 for the v4.9 merge window
Date: Mon, 12 Sep 2016 10:18:39 +0100
Message-ID: <20160912091839.GC1873@dell>
References: <1472633892-8261-1-git-send-email-j-keerthy@ti.com>
 <20160831122435.GD9415@dell>
 <CACRpkdbfOdaouKEooLsGRYXhbwkjfNoTXTqunumF4bOPjOUD4w@mail.gmail.com>
 <20160908072646.GH4921@dell>
 <20160909121140.GQ27946@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160909121140.GQ27946@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Keerthy <j-keerthy@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 09 Sep 2016, Mark Brown wrote:

> On Thu, Sep 08, 2016 at 08:26:46AM +0100, Lee Jones wrote:
> > On Wed, 07 Sep 2016, Linus Walleij wrote:
> 
> > > Hm it is based on a later release candidate than my tree so I'll wait
> > > and see if I
> > > have to pull it (like if there are clashes in linux-next...)
> 
> > You use -rc1 as your base?  Crazy man. :)
> 
> I do that too for the topic branches.  It's really helpful for cross
> tree work as it avoids issues like the above - wherever it's being
> merges it shouldn't pull in any extra dependencies so things are clearer
> when reviewing diffs/logs and git has an easier time coping.

I've always used -rc2 for everything.  It's usually more stable for
build-testing purposes.  But I'll bow down, and try to use -rc1 in
future, if it's preferred.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
