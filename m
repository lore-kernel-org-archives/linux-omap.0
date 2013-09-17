From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 0/3] cleanup of gpio_pcf857x.c
Date: Wed, 18 Sep 2013 00:56:19 +0200
Message-ID: <1695077.V4sgFrjTJR@avalon>
References: <1378278183-26596-1-git-send-email-george.cherian@ti.com> <CACRpkdYc4UTbpa5W-KY_D7hRUYi9N3Ny1+CPJ-aixeEk3WGHCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYc4UTbpa5W-KY_D7hRUYi9N3Ny1+CPJ-aixeEk3WGHCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: George Cherian <george.cherian@ti.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nikolay Balandin <n.a.balandin@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

On Tuesday 17 September 2013 14:51:48 Linus Walleij wrote:
> On Wed, Sep 4, 2013 at 9:03 AM, George Cherian wrote:
> > This patch series
> > 
> >         - removes the irq_demux_work
> >         - Uses devm_request_threaded_irq
> >         - Call the user handler iff gpio_to_irq is done.
> > 
> > v1 --> v2
> > 
> >         Split v1 to 3 patches
> > 
> > v2 --> v3
> > 
> >         Remove the unnecessary dts patches.
> > 
> > v3 --> v4
> > 
> >         Remove gpio->irq (in patch 2)
> 
> Applied all three patches with Kuninoro's ACK.
> 
> However your last iteration was still labeled "v3" in the subject
> so I was a bit confused, but I took all those sent on sep 4.
> 
> Please check the result in my GPIO tree or linux-next and
> make sure it works.
> 
> > Note: these patches were made after applying [1].
> > [1] - [PATCH v5] gpio: pcf857x: Add OF support -
> > https://lkml.org/lkml/2013/8/27/70
>
> Well that patch is not finished, but by rebasing patch 2 with
> patch -p1 < patch2.patch it applied anyway.
> 
> Now Laurent has to finalize his DT bindings on top of your patches instead.

I will do so. At first sight I don't see any conflict issue.

-- 
Regards,

Laurent Pinchart
