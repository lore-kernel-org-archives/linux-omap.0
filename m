From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 10/11] OMAP4: PM: TWL6030: fix ON/RET/OFF voltages
Date: Wed, 18 May 2011 12:44:46 +0200
Message-ID: <87tycsuw2p.fsf@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
	<1305695854-9638-11-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50906 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756860Ab1ERKpC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 06:45:02 -0400
Received: by wwa36 with SMTP id 36so1564070wwa.1
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 03:44:59 -0700 (PDT)
In-Reply-To: <1305695854-9638-11-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 18 May 2011 00:17:33 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Patrick Titiano <p-titiano@ti.com>

Nishanth Menon <nm@ti.com> writes:

> From: Patrick Titiano <p-titiano@ti.com>
>
> According to latest OMAP4430 Data Manual v0.4 dated March 2011:
>  - Retention voltage shall be set to 0.83V. See tables 2.2, 2.4 and 2.6 in DM.
>    This allows saving a little more power in retention states.
>  - OPP100 IVA nominal voltage is 1.188V. See table 2.4 in DM.
>    This allows saving a little power when CPU wakes up until Smart-Reflex is
>    not yet resumed.
>
> [nm@ti.com: ported to voltdm_c]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Patrick Titiano <p-titiano@ti.com>

Thanks, adding to voltdm queue.

Kevin
