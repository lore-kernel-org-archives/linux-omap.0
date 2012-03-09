From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
Date: Fri, 09 Mar 2012 17:45:19 +0200
Message-ID: <4F5A258F.8050704@ti.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:54131 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932100Ab2CIPpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 10:45:30 -0500
Received: by mail-bk0-f42.google.com with SMTP id je9so3030236bkc.1
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 07:45:23 -0800 (PST)
In-Reply-To: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi Paul, Tony,

On 03/06/2012 10:55 AM, Peter Ujfalusi wrote:
> CLKS signal for McBSP ports can be selected from internal (PRCM) or e=
xternal
> (ABE_CLKS pin) source.
> To be able to use existing code we need to create clock aliases consi=
stent
> among OMAP2/3/4.

Would you be able to take a look at this patch?

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
