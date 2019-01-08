From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Tue, 8 Jan 2019 08:59:56 +0100
Message-ID: <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
References: <20190107233833.GI5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107233833.GI5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tue, 8 Jan 2019 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi all,
>
> Looks like commit 8234f6734c5d ("PM-runtime: Switch autosuspend
> over to using hrtimers") caused a regression on at least
> omap5-uevm where 8250 UART rx wake no longer works. I have not
> noticed this happening on others so far.
>
> The devices I've tested all are using 8250 with dedicated
> wakeirqs configured for the rx pin. I can see the interrupt
> increase on omap5-uevm after some one or more keypresses,
> but then nothing. It seems that the uart just falls back
> asleep right away or something.
>
> Any ideas what might be going wrong?

What is the autosuspend value ? Can it be that the autosuspend is set
to a short value but was finally greater than 10-20ms on arm32. And
now the autosuspend happens before and this has changed the sequence ?

Regards,
Vincent
>
> Regards,
>
> Tony
>
