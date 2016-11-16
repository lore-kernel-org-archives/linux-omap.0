From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [patch] pinctrl: single: Fix a couple error codes
Date: Wed, 16 Nov 2016 20:57:01 +0100
Message-ID: <CACRpkdYOKg01t0u39gsJk2FWz411dkoM43yR7UWNkoyUcP9gwA@mail.gmail.com>
References: <20161116114151.GA31224@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161116114151.GA31224@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 16, 2016 at 12:41 PM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:

> We should return -ENOMEM instead of success if pcs_add_function() fails.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij
