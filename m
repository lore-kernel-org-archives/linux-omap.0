From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 13/15] mmc: host: omap_hsmmc: use regulator_is_enabled
 to find pbias status
Date: Thu, 27 Aug 2015 14:49:28 +0200
Message-ID: <CAPDyKFq7cNzDJ4-oPnLmqa9yhBnkntFx6_6scctH=4tZjc7TPA@mail.gmail.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
	<1440666847-12594-14-git-send-email-kishon@ti.com>
	<CAPDyKFqkwHPiiLVXpwNB_nBt3bdXAOhUH46cD5npS8OFsBrfeQ@mail.gmail.com>
	<CAPDyKFpm1BsKvD0f_hNvPM1LmKbd2AL8yddYRpayLPKsN2UQfw@mail.gmail.com>
	<55DF06CE.9030600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <55DF06CE.9030600@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Neil Brown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

On 27 August 2015 at 14:47, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi Uffe,
>
> On Thursday 27 August 2015 06:12 PM, Ulf Hansson wrote:
>> On 27 August 2015 at 14:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 27 August 2015 at 11:14, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>> Use regulator_is_enabled of pbias regulator to find pbias regulator
>>>> status instead of maintaining a custom bookkeeping
>>>> pbias_enabled variable.
>>>
>>> Doesn't this cause a problem for the scenario when the initial state
>>> of the regulator is enabled?
>
> Patch 11 of this series "mmc: host: omap_hsmmc: don't use ->set_power to
> set initial regulator state" disables the pbias regulator if the initial
> state of the regulator is enabled.
>

Got it, thanks!

[...]

Kind regards
Uffe
