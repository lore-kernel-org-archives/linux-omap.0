From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in
 clock36xx.c
Date: Mon, 10 Jun 2013 08:15:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306100806530.4604@utopia.booyaka.com>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com> <alpine.DEB.2.02.1306051814520.10103@utopia.booyaka.com> <CAGGh5h1gBin0vWFf=SpB4eCQX69a2U+J6u2ccF_Oo_4R62+5fQ@mail.gmail.com> <alpine.DEB.2.02.1306061517430.5152@utopia.booyaka.com>
 <CAGGh5h0z3OPPL_jECb1NhENo2OaBqebdTC6r_ddhWKDuuB1Ykg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42447 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab3FJIPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 04:15:35 -0400
In-Reply-To: <CAGGh5h0z3OPPL_jECb1NhENo2OaBqebdTC6r_ddhWKDuuB1Ykg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: Mike Turquette <mturquette@linaro.org>, Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Kevin Hilman <khilman@linaro.org>

Hello Jean-Philippe,

On Mon, 10 Jun 2013, jean-philippe francois wrote:

> I am ok to work on it, however could you explain to me what is the
> expected output of your PM tests, and how to reproduce them ?

Here is the expected output for my ancient 3730 ES1.0 Beagle-XM:

http://www.pwsan.com/omap/testlogs/test_v3.10-rc5/20130609031534/pm/3730beaglexm/3730beaglexm_log.txt

When I ran that same test on the second version of your patch, the system 
froze during the retention dynamic idle test:

----------------

%% Start retention dynamic idle UART wakeup test

echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_delay_ms
root@beagleboard:~# 
root@beagleboard:~# echo 3000 > 
/sys/devices/platform/omap_uart.1/power/autosuspend_delay_ms
root@beagleboard:~# 
root@beagleboard:~# echo 3000 > 
/sys/devices/platform/omap_uart.2/power/autosuspend_delay_ms
root@beagleboard:~# 
root@beagleboard:~# echo 3000 > 
/sys/devices/platform/omap_uart.3/power/autosuspend_delay_ms
root@beagleboard:~# 
root@beagleboard:~# 

-------------------

That is where the log stopped.

Sorry to hear about your board - I can certainly sympathize,

regards,

- Paul
