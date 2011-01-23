From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v9 18/18] OMAP2,3: DSS2: Get DSS IRQ from platform
	device
Date: Sun, 23 Jan 2011 12:52:16 +0000
Message-ID: <20110123125216.GA29926@n2100.arm.linux.org.uk>
References: <1295690758-5845-1-git-send-email-sumit.semwal@ti.com> <1295690758-5845-19-git-send-email-sumit.semwal@ti.com> <4D3C217B.9020301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45287 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1AWMww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Jan 2011 07:52:52 -0500
Content-Disposition: inline
In-Reply-To: <4D3C217B.9020301@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>, khilman@ti.com, paul@pwsan.com, Senthilvadivu Guruswamy <svadivu@ti.com>, hvaibhav@ti.com, tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Jan 23, 2011 at 03:39:23PM +0300, Sergei Shtylyov wrote:
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
>> index 4d7a816..22690e9 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
> [...]
>> @@ -609,15 +609,18 @@ static int dss_init(bool skip_init)
>>   	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
>>   #endif
>>
>> -	r = request_irq(INT_24XX_DSS_IRQ,
>> +	dss_irq = platform_get_irq(dss.pdev, 0);
>> +	if (dss_irq != -ENXIO) {
>
>    Better just 'dss_irq > 0', IMHO.

If a function returns negative error codes, the correct test is
	ret < 0
not
	ret <= 0

The fact that it happens to be dealing with IRQ numbers where IRQ0
may not be valid is neither here nor there.
