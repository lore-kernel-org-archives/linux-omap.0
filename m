From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: HDMI: Disable HDMI DDC internal pull up
Date: Fri, 21 Oct 2011 14:19:27 +0300
Message-ID: <1319195967.2870.77.camel@deskari>
References: <1319189226-11019-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:34543 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754434Ab1JULTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Oct 2011 07:19:33 -0400
Received: by bkat2 with SMTP id t2so5185223bka.4
        for <linux-omap@vger.kernel.org>; Fri, 21 Oct 2011 04:19:31 -0700 (PDT)
In-Reply-To: <1319189226-11019-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

On Fri, 2011-10-21 at 14:57 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> Disables the internal pull resistor for SDA and SCL enabled by
> default as there are expernal pull up's to avoid the EDID read failure.

What do you mean with external pull up? Outside OMAP? Then it's a board
specific feature, isn't it, and not related to the OMAP version?

 Tomi


