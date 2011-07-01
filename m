From: hong zhang <henryzhang62@yahoo.com>
Subject: gpio interrupt is not invoked on Panda board
Date: Fri, 1 Jul 2011 11:10:35 -0700 (PDT)
Message-ID: <1309543835.48880.YahooMailClassic@web161712.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm19.bullet.mail.bf1.yahoo.com ([98.139.212.178]:38694 "HELO
	nm19.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752302Ab1GASRM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 14:17:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

List,

I try to get gpio_191 ping interrupted on panda but never succeeded. What I do is

1. set 0x410b on dpm_emu19 register to enable interrupt and wakeup 
   on gpio_191
2. set bit 31 to 1 on GPIO_IRQSTATUS_SET_0 register at 0x4805d034
3. set bit 31 to 1 on GPIO_IRQWAKEN_0 register at 0x4805d044
4. set bit 31 to 0 on GPIO_OE register at 0x4805d134 (output)
5. set bit 31 to 1 on GPIO_SETDATAOUT register at 0x4805d194

Then I expect I should see interrupt on GPIO_IRQSTATUS_0 register at 0x4805d02c. But nothing happens for both output and input (put pin on ground or 1,8v).

Would you please give me hint what I miss here to get interrupt happened?
I want to use gpio_191 for IR receiver.

Thanks.

---henry
