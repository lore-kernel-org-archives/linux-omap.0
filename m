From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 4/4] usb: musb: dsps: add support for suspend and resume
Date: Mon, 25 Nov 2013 22:30:37 +0100
Message-ID: <5293C17D.3020508@gmail.com>
References: <1385414803-13212-1-git-send-email-zonque@gmail.com> <1385414803-13212-5-git-send-email-zonque@gmail.com> <20131125212920.GU18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:65445 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab3KYVak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 16:30:40 -0500
In-Reply-To: <20131125212920.GU18046@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

On 11/25/2013 10:29 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Nov 25, 2013 at 10:26:43PM +0100, Daniel Mack wrote:
>> +static int dsps_resume(struct device *dev)
>> +{
>> +	struct dsps_glue *glue = dev_get_drvdata(dev);
>> +	const struct dsps_musb_wrapper *wrp = glue->wrp;
>> +	struct musb *musb = platform_get_drvdata(glue->musb);
>> +	void __iomem *mbase = musb->ctrl_base;
>> +
>> +	dsps_writel(mbase, wrp->control, glue->context.control);
>> +	dsps_writel(mbase, wrp->epintr_set, glue->context.epintr);
>> +	dsps_writel(mbase, wrp->coreintr_set, glue->context.coreintr);
>> +	dsps_writel(mbase, wrp->phy_utmi, glue->context.phy_utmi);
>> +	dsps_writel(mbase, wrp->mode, glue->context.mode);
>> +	dsps_writel(mbase, wrp->tx_mode, glue->context.tx_mode);
>> +	dsps_writel(mbase, wrp->rx_mode, glue->context.rx_mode);
>> +
>> +	//musb_port_reset(musb, false);
> 
> ????
> 

Urgs. Development left-over. Sorry. You want me to resend the whole
series or just this last patch?


Daniel

