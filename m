From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: single: Fix missing flush of posted write for a
 wakeirq
Date: Thu, 2 Jun 2016 08:19:53 -0700
Message-ID: <20160602151953.GD5995@atomide.com>
References: <1464729426-11187-1-git-send-email-tony@atomide.com>
 <CACRpkdZUJU90S1Qsqx=8uk33tsXfnpsViJGr_ysgZcmRBH9KHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZUJU90S1Qsqx=8uk33tsXfnpsViJGr_ysgZcmRBH9KHA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [160602 05:29]:
> On Tue, May 31, 2016 at 11:17 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > With many repeated suspend resume cycles, the pin specific wakeirq
> > may not always work on omaps. This is because the write to enable the
> > pin interrupt may not have reached the device over the interconnect
> > before suspend happens.
> >
> > Let's fix the issue with a flush of posted write with a readback.
> >
> > Reported-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Patch applied.

Thanks.

> Is it a regression that needs to be sent to fixes and tagged
> for stable?

It fixes wake from suspend in repeated cases, so at least
Android users would appreciate it in the stable trees.

Although the Android users are using vendor tree, it's still
one fix less to carry them.

So yeah, I'd vote yes for stable tag on this one.

Regards,

Tony
