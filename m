From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH V4 0/5] OMAPDSS: Enable dynamic debug printing
Date: Wed, 10 Oct 2012 15:56:38 +0530
Message-ID: <50754D5E.8030206@linaro.org>
References: <cover.1348826106.git.cmahapatra@ti.com>  <cover.1348914940.git.cmahapatra@ti.com> <1349441191.5836.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33024 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab2JJK0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 06:26:44 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so297628oag.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Oct 2012 03:26:43 -0700 (PDT)
In-Reply-To: <1349441191.5836.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Tomi, Chandrabhanu,

On Friday 05 October 2012 06:16 PM, Tomi Valkeinen wrote:
> On Sat, 2012-09-29 at 16:19 +0530, Chandrabhanu Mahapatra wrote:
>> Hi everyone,
>> this patch series aims at cleaning up of DSS of printk()'s enabled with
>> dss_debug and replace them with generic dynamic debug printing.
>
> Except for the missing debug print conversions in dsi.c this looks good.
> Do you want me to apply the current series and you can send the dsi.c
> patch later, or do you want to fix the dsi.c also before I apply?

With the change for DSI, please feel free to add

Reviewed-by: Sumit Semwal <sumit.semwal@ti.com>

BR,
~Sumit.
>
>   Tomi
>

