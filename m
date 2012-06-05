From: "Matcovschi, Oleg" <oleg.matcovschi@ti.com>
Subject: RE: [PATCH v2] omap: dma: Clear status registers on enable/disable
 irq.
Date: Tue, 5 Jun 2012 18:28:24 +0000
Message-ID: <E0D6B3D7803B1A49AC7CEA9958379F6303752BF9@DFLE36.ent.ti.com>
References: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
 <20120604061357.GV12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38334 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab2FES2m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 14:28:42 -0400
In-Reply-To: <20120604061357.GV12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "jarkko.nikula@bitmer.com" <jarkko.nikula@bitmer.com>, "jkrzyszt@tis.inet.pl" <jkrzyszt@tis.inet.pl>

>>* Oleg Matcovschi <oleg.matcovschi@ti.com> [120515 14:40]:
>> Use omap_disable_channel_irq() function instead of directly accessing CICR.
>> The omap_disable_chanel_irq() function clears pending interrupts and 
>> disables interrupt on channel.
>> Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear 
>> interrupt status register.

>Looking at this again, I'll apply this into cleanup-dma instead of fixes.

>If it fixes something that I can't see, please reply with a description what it fixes and I'll move it into fixes.
>Regards,
>Tony

Sure, cleanup-dma sounds ok.

Code covers:
- my test case for 4460:
      I could reproduce 2 interrupts @ omap-pcm driver after omap_stop_dma function call.
         1st irq CSR: 0x42 (half & drop)
         2nd irq CSR: 0x02 (drop)
      Only 1 interrupt occurs after applying this patch(overnight test results)
      Test case was created to reproduce problem reported by customer(without clear description):
          contiguous playback of 0.5 wav file (frequent start/stop audio transitions)
          contiguous data transfers on 15 self-linked dma channels.

- omap_request_dma could cause spurious interrupt
         (enable irq, clear irq status instead of clear irq status, enable irq)

thanks,
 Oleg