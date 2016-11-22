From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Subject: Re: [PATCH v2] mfd: twl-core: make driver DT only
Date: Tue, 22 Nov 2016 12:55:06 +0200
Message-ID: <CAKP5S=3y6GAzs34c6-qsxHFZ1PaLC-_nT4LKd=3dd34wepnBMw@mail.gmail.com>
References: <1479810090-12183-1-git-send-email-Nicolae_Rosia@mentor.com> <20161122104510.iujd5revibqgbldl@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122104510.iujd5revibqgbldl@tarshish>
Sender: linux-kernel-owner@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Nicolae Rosia <Nicolae_Rosia@mentor.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Nov 22, 2016 at 12:45 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Nicolae,
>
>
> Can struct twl4030_platform_data declaration be removed now from
> include/linux/i2c/twl.h?
>
> baruch
>
Yes, I have the patches ready and plan on doing that in the next cycle.
I have been sending multiple patches to convert twl related drivers to
DT only and I don't want to create merge conflicts on twl.h

Thanks,
Nicolae
