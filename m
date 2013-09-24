From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/4] usb: musb: am35x: use SIMPLE_DEV_PM_OPS
Date: Tue, 24 Sep 2013 08:57:08 +0200
Message-ID: <524137C4.1000104@gmail.com>
References: <1379850421-7966-1-git-send-email-zonque@gmail.com> <20130923212009.GK309@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:60941 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3IXG5M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 02:57:12 -0400
In-Reply-To: <20130923212009.GK309@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-ubs@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org

On 23.09.2013 23:20, Felipe Balbi wrote:
> On Sun, Sep 22, 2013 at 01:46:58PM +0200, Daniel Mack wrote:

>> -static struct dev_pm_ops am35x_pm_ops = {
>> -	.suspend	= am35x_suspend,
>> -	.resume		= am35x_resume,
>> -};
>> +static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);
> 
> you could as well remove the DEV_PM_OPS trickery. Ditto for all other
> patches

Yes, I noticed that too. That's why I sent out a v2 of the series :)


Thanks,
Daniel

