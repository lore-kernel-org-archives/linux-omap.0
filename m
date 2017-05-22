From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: single: use of_device_get_match_data() to get
 soc data
Date: Mon, 22 May 2017 09:22:46 -0700
Message-ID: <20170522162245.GT10472@atomide.com>
References: <1495296137-6461-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1495296137-6461-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Haojian Zhuang <haojian.zhuang@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Masahiro Yamada <yamada.masahiro@socionext.com> [170520 09:06]:
> Use of_device_get_match_data() instead of of_match_device().
> It allows us to remove the forward declaration of pcs_of_match.

That's nice:

Acked-by: Tony Lindgren <tony@atomide.com>
