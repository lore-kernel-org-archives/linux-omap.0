From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 09/11] omap4: twl: added pmic startup / shutdown times
Date: Fri, 04 Nov 2011 14:21:37 -0700
Message-ID: <871utn7fdq.fsf@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
	<1317835031-8201-10-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49090 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753413Ab1KDVVl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 17:21:41 -0400
Received: by mail-iy0-f178.google.com with SMTP id j38so3314653iad.9
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 14:21:40 -0700 (PDT)
In-Reply-To: <1317835031-8201-10-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 5 Oct 2011 20:17:09 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

[...]

> +static struct twl_lp_description omap4_pmic_lp_desc = {
> +	.pmic_shut_time		= 500,
> +	.pmic_start_time	= 500,
> +};

Also, please note where these timings come from (TRM, data sheet, etc.)

Kevin
