From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio/omap: add *remove* callback in platform_driver
Date: Thu, 12 Jul 2012 13:03:00 +0200
Message-ID: <CACRpkdZMG_ZHW_eGGrdrJh1SuO_=hOObijzmxG1ob6RoNf_dwg@mail.gmail.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
	<1341997995-14020-3-git-send-email-tarun.kanti@ti.com>
	<87394xhocn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87394xhocn.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 12, 2012 at 1:25 AM, Kevin Hilman <khilman@ti.com> wrote:

> There is quite a bit of other things to do in remove to properly cleanup
> what is done in probe.

OK I'm dropping this patch for now...

Yours,
Linus Walleij
