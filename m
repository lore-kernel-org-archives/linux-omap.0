From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
Date: Fri, 23 Mar 2018 07:22:34 -0700
Message-ID: <20180323142234.GH5799@atomide.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
 <CACRpkdanFFwPBhkDNRTdns9cPebH3drBZNhqZLBzF78U3XdRgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdanFFwPBhkDNRTdns9cPebH3drBZNhqZLBzF78U3XdRgw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: David Lechner <david@lechnology.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [180323 03:02]:
> On Mon, Feb 19, 2018 at 10:57 PM, David Lechner <david@lechnology.com> wrote:
> 
> > This fixes pcs_request_gpio() in the pinctrl-single driver when
> > bits_per_mux != 0. It appears this was overlooked when the multiple
> > pins per register feature was added.
> >
> > Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> > Signed-off-by: David Lechner <david@lechnology.com>
> > ---
> >
> > v2 changes:
> > - don't wrap Fixes: line in commit message since it is a special machine-
> >   readable line.
> 
> Tony/Haojian: are you OK with this change?

No objections from me, would be good if Haojian could
test it with his test cases though.

Regards,

Tony
