From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Tue, 4 Jan 2011 08:52:29 +0200
Message-ID: <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-6-git-send-email-balbi@ti.com>
 <20110104014002.GV7771@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34154 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750831Ab1ADGwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 01:52:34 -0500
Received: by gxk21 with SMTP id 21so6891601gxk.24
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 22:52:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110104014002.GV7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Jan 03, 2011 at 05:40:02PM -0800, Tony Lindgren wrote:
>* Felipe Balbi <balbi@ti.com> [110102 23:49]:
>> @@ -53,23 +54,23 @@
>>  struct retu {
>>  	/* Device lock */
>>  	spinlock_t		lock;
>> -	struct tasklet_struct	tasklet;
>> +	struct mutex		irq_lock;
>>  	struct device		*dev;
>>
>> +	int			irq_base;
>> +	int			nirqs;
>>  	int			irq;
>
>This one oopses, looks like irq_base is not initialized?

Aaa, good catch. Sorry for that. Gotta add a platform_data for passing
that around. Will do it on V2.

-- 
balbi
