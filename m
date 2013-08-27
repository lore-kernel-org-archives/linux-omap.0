From: Illia Smyrnov <illia.smyrnov@globallogic.com>
Subject: Re: [PATCH v3 0/3] Input: omap-keypad: Wakeup capability and w/a
 for i689 errata.
Date: Tue, 27 Aug 2013 13:08:05 +0300
Message-ID: <521C7A85.6000504@ti.com>
References: <1375116311-13999-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:35328 "EHLO
	exprod5og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3H0KNi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Aug 2013 06:13:38 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so2414140lbi.11
        for <linux-omap@vger.kernel.org>; Tue, 27 Aug 2013 03:13:36 -0700 (PDT)
In-Reply-To: <1375116311-13999-1-git-send-email-illia.smyrnov@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Illia Smyrnov <illia.smyrnov@globallogic.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hello Dmitry,

could you take reviewed patches from this patchset?

Reviewed patches:
[PATCH v3 1/3] Input: omap-keypad: Enable wakeup capability for keypad.
[PATCH v3 3/3] Input: omap-keypad: Setup irq type from DT
are not depend on
[PATCH v3 2/3] Input: omap-keypad: errata i689: Correct debounce time

Thanks.

On 07/29/2013 07:45 PM, Illia Smyrnov wrote:
> This patchset adds wake up capability for the keypad and
> workaround for i689 errata.
>
> Based on top of v3.11-rc3
>
> Depends on:
>
> Input: omap-keypad: Convert to threaded IRQ
> https://patchwork.kernel.org/patch/2832920/
>
> Input: omap-keypad: Cleanup - use bitfiled instead of hardcoded values
> https://patchwork.kernel.org/patch/2832913/
>
> Axel Haslam (1):
>    Input: omap-keypad: errata i689: Correct debounce time
>
> Illia Smyrnov (2):
>    Input: omap-keypad: Enable wakeup capability for keypad.
>    Input: omap-keypad: Setup irq type from DT
>
>   drivers/input/keyboard/omap4-keypad.c |   52 ++++++++++++++++++++++++++++++---
>   1 file changed, 48 insertions(+), 4 deletions(-)
>
