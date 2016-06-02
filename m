From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: single: Fix missing flush of posted write for a wakeirq
Date: Thu, 2 Jun 2016 14:27:33 +0200
Message-ID: <CACRpkdZUJU90S1Qsqx=8uk33tsXfnpsViJGr_ysgZcmRBH9KHA@mail.gmail.com>
References: <1464729426-11187-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1464729426-11187-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 31, 2016 at 11:17 PM, Tony Lindgren <tony@atomide.com> wrote:

> With many repeated suspend resume cycles, the pin specific wakeirq
> may not always work on omaps. This is because the write to enable the
> pin interrupt may not have reached the device over the interconnect
> before suspend happens.
>
> Let's fix the issue with a flush of posted write with a readback.
>
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied.

Is it a regression that needs to be sent to fixes and tagged
for stable?

Yours,
Linus Walleij
