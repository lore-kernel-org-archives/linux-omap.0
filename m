From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 4/4] usb: musb: dsps: add support for suspend and resume
Date: Tue, 26 Nov 2013 13:30:24 +0100
Message-ID: <52949460.6090708@gmail.com>
References: <1385414803-13212-1-git-send-email-zonque@gmail.com> <1385414803-13212-5-git-send-email-zonque@gmail.com> <20131125212920.GU18046@saruman.home> <5293C17D.3020508@gmail.com> <20131125213236.GW18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:38172 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab3KZMa0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 07:30:26 -0500
In-Reply-To: <20131125213236.GW18046@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

On 11/25/2013 10:32 PM, Felipe Balbi wrote:
> On Mon, Nov 25, 2013 at 10:30:37PM +0100, Daniel Mack wrote:
>> On 11/25/2013 10:29 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Mon, Nov 25, 2013 at 10:26:43PM +0100, Daniel Mack wrote:
>>>> +static int dsps_resume(struct device *dev)
>>>> +{
>>>> +	struct dsps_glue *glue = dev_get_drvdata(dev);
>>>> +	const struct dsps_musb_wrapper *wrp = glue->wrp;
>>>> +	struct musb *musb = platform_get_drvdata(glue->musb);
>>>> +	void __iomem *mbase = musb->ctrl_base;
>>>> +
>>>> +	dsps_writel(mbase, wrp->control, glue->context.control);
>>>> +	dsps_writel(mbase, wrp->epintr_set, glue->context.epintr);
>>>> +	dsps_writel(mbase, wrp->coreintr_set, glue->context.coreintr);
>>>> +	dsps_writel(mbase, wrp->phy_utmi, glue->context.phy_utmi);
>>>> +	dsps_writel(mbase, wrp->mode, glue->context.mode);
>>>> +	dsps_writel(mbase, wrp->tx_mode, glue->context.tx_mode);
>>>> +	dsps_writel(mbase, wrp->rx_mode, glue->context.rx_mode);
>>>> +
>>>> +	//musb_port_reset(musb, false);
>>>
>>> ????
>>>
>>
>> Urgs. Development left-over. Sorry. You want me to resend the whole
>> series or just this last patch?
> 
> just the last patch is fine :-)

Sorry, there was one more hunk that shouldn't be there. I'll resend a v4
with all the patches included again, for reference.

