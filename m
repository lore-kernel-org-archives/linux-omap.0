From: sourav <sourav.poddar@ti.com>
Subject: Re: [PATCH 0/3] pwm: ti: Miscellaneous Fixes and cleanup for pwm.
Date: Wed, 8 Jan 2014 12:17:00 +0530
Message-ID: <52CCF464.6040307@ti.com>
References: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 18 December 2013 05:06 PM, Sourav Poddar wrote:
> This patch series caters to the issue faced while using tiecap
> as a module.
>
> The patch fix lock dependency issue which leads to crash during rmmod.
> Also fixes the clock control register setup values during CLK EN call.
>
> Sourav Poddar (3):
>    pwm: core: Rearrange pwm lock usage.
>    driver: pwm: ti-ecap: Rmove duplicate put_sync call.
>    driver: pwmss: Disable stop during Enable clock call..
>
>   drivers/pwm/core.c        |    4 +++-
>   drivers/pwm/pwm-tiecap.c  |    1 -
>   drivers/pwm/pwm-tipwmss.c |    2 ++
>   3 files changed, 5 insertions(+), 2 deletions(-)
>
Gentle ping on this..
