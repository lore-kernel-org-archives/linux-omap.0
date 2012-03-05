From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 0/6] ARM: OMAP3+: IO daisychain support fixes
Date: Mon, 05 Mar 2012 15:31:13 +0530
Message-ID: <4F548EE9.6050805@ti.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56497 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756577Ab2CEKBW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 05:01:22 -0500
Received: by mail-gy0-f173.google.com with SMTP id r14so1865796ghr.18
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 02:01:19 -0800 (PST)
In-Reply-To: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Friday 02 March 2012 08:47 PM, Tero Kristo wrote:
> Hi,
>
> Changes compared to previous version:
>
> - patch2:
>   * changed timeout value to 100us (from 1000)
>   * added poll for the IO status == 0 at the end of trigger sequence
> - patch4:
>   * omap3: global wakeup done in PRM init instead of OMAP3 PM init
>   * omap4: moved global wakeup enable from trigger func to PRM init
>
> Tested on omap3beagle / omap4blaze, suspend / resume works with io chain.

for the full series,
Reviewed-by: Rajendra Nayak <rnayak@ti.com>

>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

