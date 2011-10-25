From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Linux 3.0 DSS support
Date: Tue, 25 Oct 2011 10:37:09 +0300
Message-ID: <1319528229.1684.20.camel@lappyti>
References: <CANLagX8WaHGkqOZ2UnLR1ihOABbdDy1ZAyW19yO=f-JNUaLKfw@mail.gmail.com>
	 <4E9BD71A.90703@ti.com>  <4EA5A677.3050704@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:44091 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752656Ab1JYHhV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Oct 2011 03:37:21 -0400
Received: by mail-bw0-f49.google.com with SMTP id c12so332315bkb.22
        for <linux-omap@vger.kernel.org>; Tue, 25 Oct 2011 00:37:20 -0700 (PDT)
In-Reply-To: <4EA5A677.3050704@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@logicpd.com>
Cc: Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 2011-10-24 at 13:55 -0400, Peter Barada wrote:
> 
> In the above case (and my case where I'm looking for a 9Mhz pixel 
> clock), fck_div is calculated at higher than 16 - and the video
> output 
> is wrong (i.e. no pixel clock and hsync runs at 32x the requested
> rate). 

DM37x TRM says:

"DSS1_ALWON_FCLK: Issued from DPLL4. Its frequency can be a division by
1 to 16 of the frequency of the DPLL4 synthesized clock."

I take it that DM37x is detected as cpu_is_3630()?

The DSS driver currently handles only OMAPs, so for other SoCs the
driver may contain lots of bugs like this.

 Tomi


