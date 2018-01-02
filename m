From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] pinctrl: single: Delete an unnecessary return
 statement in pcs_irq_chain_handler()
Date: Tue, 2 Jan 2018 09:50:32 +0100
Message-ID: <CACRpkdbHQAW9gDrCqD0GuxYGMgrRuOe+g_52N+ij=niU5_Z6Yw@mail.gmail.com>
References: <6bc679d1-c1ee-52fe-9ece-b28095f653ec@users.sourceforge.net> <c736d14b-0293-82ac-27de-a673b62b61d7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c736d14b-0293-82ac-27de-a673b62b61d7@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-gpio@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Tony Lindgren <tony@atomide.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 25, 2017 at 2:07 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 25 Dec 2017 11:35:44 +0100
>
> The script "checkpatch.pl" pointed information out like the following.
>
> WARNING: void function return statements are not generally useful
>
> Thus remove such a statement in the affected function.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
