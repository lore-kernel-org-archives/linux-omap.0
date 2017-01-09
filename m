From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 17/21] mmc: omap: Don't use mmc_card_present() when
 validating for inserted card
Date: Mon, 9 Jan 2017 19:24:17 +0100
Message-ID: <CACRpkdbUR3g46BV2zyXG7uo-=6Vq-QRcrdqfgBrrEpn3+kn6aQ@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-18-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1483102054-1752-18-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The mmc_card_present() function helps the mmc core to track an internal
> state of the card device. More importantly, it's not intended to be used by
> mmc host drivers to check for an inserted card. Therefore, let's stop using
> it and instead rely on checking for a valid pointer to a struct mmc_card,
> as it should be good enough.
>
> Cc: linux-omap@vger.kernel.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
