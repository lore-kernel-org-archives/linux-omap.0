From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv2 0/4] staging: tidspbridge - misc fixes
Date: Fri, 10 Dec 2010 05:34:31 -0600
Message-ID: <4D021047.9080300@ti.com>
References: <1291953342-4905-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291953342-4905-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: omar.ramirez@ti.com, linux-kernel@vger.kernel.org, felipe.contreras@gmail.com, ohad@wizery.com, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Fernando Guzman Lugo wrote, on 12/09/2010 09:55 PM:
> * V2
>   - rebase to the latest
>   - remove patches no needed at this moment
>
> This set of patches fix some issues found in lastest tree.
>
> Fernando Guzman Lugo (4):
>    staging: tidspbridge - use GTP7 for DSP stack dump
>    staging: tidspbridge - fix timeout in dsp_gpt_wait_overflow
>    staging: tidspbridge - remove disabling twl when printing DSP stack
>    staging: tidspbridge - change mmufault tasklet to a workqueue
>
>   drivers/staging/tidspbridge/core/_deh.h            |    2 +-
>   drivers/staging/tidspbridge/core/dsp-clock.c       |   17 ++++---
>   drivers/staging/tidspbridge/core/ue_deh.c          |   55 +++++++++++--------
>   .../staging/tidspbridge/include/dspbridge/clk.h    |    4 +-
>   4 files changed, 46 insertions(+), 32 deletions(-)
>
Suggest looping in Linux-omap as well.

-- 
Regards,
Nishanth Menon
