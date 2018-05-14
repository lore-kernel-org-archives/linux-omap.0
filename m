From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/3] ti_am335x_tsc: Fix suspend/resume
Date: Mon, 14 May 2018 20:34:50 +0530
Message-ID: <45161a15-8804-561c-18af-0c9b45a2eac1@ti.com>
References: <20180424062741.7891-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424062741.7891-1-vigneshr@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org



On 24-Apr-18 11:57 AM, Vignesh R wrote:
> This patch series fixes couple of issues wrt suspend/resume with TI AM335x
> TSC driver. Disable and clear any pending IRQs before suspend, and
> handle case where TSC wakeup would fail, if there were touch events
> during suspend.
> 
> 

Gentle ping on this series... Any comments?

> Grygorii Strashko (2):
>   Input: ti_am335x_tsc - Ack pending IRQs at probe and before suspend
>   Input: ti_am335x_tsc - Prevent system suspend when TSC is in use
> 
> Vignesh R (1):
>   Input: ti_am335x_tsc - Mark IRQ as wakeup capable
> 
>  drivers/input/touchscreen/ti_am335x_tsc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
