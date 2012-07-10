From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2] mmc: omap: add clk_prepare and clk_unprepare
Date: Tue, 10 Jul 2012 09:57:27 +0530
Message-ID: <CANfBPZ9=-CZ=-bKN80tAZmWDZAvWNLxDcCR6hjQQzZ4qhQvbEA@mail.gmail.com>
References: <1340786994-29565-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1340786994-29565-1-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 27, 2012 at 2:19 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> and clk_unprepare() for the hsmmc clocks.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Balaji T K <balajitk@ti.com>
> Cc: <linux-mmc@vger.kernel.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Mike Turquette <mturquette@linaro.org>

Thanks Rajendra.
Acked-by: Venkatraman S <svenkatr@ti.com>

> ---
>  drivers/mmc/host/omap_hsmmc.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
