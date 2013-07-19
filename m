From: Illia Smyrnov <x0194613@ti.com>
Subject: Re: [PATCH 0/2] Input: omap-keypad: Cleanup - remove hardcoded values
 and IRQ enabling/disabling
Date: Fri, 19 Jul 2013 16:10:50 +0300
Message-ID: <51E93ADA.3010402@ti.com>
References: <1374239027-3927-1-git-send-email-illia.smyrnov@globallogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1374239027-3927-1-git-send-email-illia.smyrnov@globallogic.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/19/2013 04:03 PM, Illia Smyrnov wrote:
> From: Illia Smyrnov <illia.smyrnov@ti.com>
>
> Replace unclear hardcoded values with bit field and remove
> unnecessary IRQ enabling/disabling.
>
> Based on top of v3.10-rc1.

Sorry, it is typo here. Based on v3.11-rc1.

>
> Tested on OMAP4 SDP.
>
> Illia Smyrnov (2):
>    Input: omap-keypad: Cleanup - use bitfiled instead of hardcoded
>      values
>    Input: omap-keypad: Cleanup - remove unnecessary IRQ
>      enabling/disabling
>
>   drivers/input/keyboard/omap4-keypad.c |   40 ++++++++++++--------------------
>   1 files changed, 15 insertions(+), 25 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
