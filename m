From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/3] OMAP2+: hwmod: Avoid setup if clock lookup failed
Date: Wed, 16 Feb 2011 15:35:28 +0300
Message-ID: <4D5BC490.4060809@ru.mvista.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com> <1297858285-7056-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42051 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab1BPMgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 07:36:46 -0500
Received: by bwz15 with SMTP id 15so554374bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:36:45 -0800 (PST)
In-Reply-To: <1297858285-7056-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hello.

On 16.02.2011 15:11, Rajendra Nayak wrote:

> Add a hwmod state check in the _setup function
> to avoid setting up hwmods' for which clock
> lookup has failed.

> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
[...]

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e282e35..cd9dcde 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1362,6 +1362,12 @@ static int _setup(struct omap_hwmod *oh, void *data)
>   	int i, r;
>   	u8 postsetup_state;
>
> +	if (oh->_state != _HWMOD_STATE_CLKS_INITED) {
> +		WARN(1, "omap_hwmod: %s: _setup failed as one or more"

    You forgot space bafore " -- "moreclock" will be printed.

> +		     "clock lookups' have failed\n", oh->name);

    Why there's apostrophe here?

WBR, Sergei
