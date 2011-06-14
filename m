From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: Re: [RFC PATCHv5 2/7] HSI: omap_ssi: Introducing OMAP SSI driver
Date: Tue, 14 Jun 2011 15:09:22 +0300
Message-ID: <1308053362.2819.38112.camel@groo>
References: <1307713124-3946-1-git-send-email-carlos.chinea@nokia.com>
	 <1307713124-3946-3-git-send-email-carlos.chinea@nokia.com>
	 <20110613132152.GA3352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:41112 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331Ab1FNMNW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jun 2011 08:13:22 -0400
In-Reply-To: <20110613132152.GA3352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi,
-- cut--
> > +
> > +static int __init ssi_init(void)
> > +{
> > +	return platform_device_register(&ssi_pdev);
> > +}
> > +subsys_initcall(ssi_init);
> 
> Looks like you need something here also to prevent this subsys_initcall
> on running on all boards. Maybe have a pointer to ssi_pdev that only
> gets initialized after omap_ssi_config?
> 
> Then you can have ssi_init fail if no configuration is called:
> 
> 	if (!pdev)
> 		return -ENODEV;
> 
> 	return platform_device_register(pdev);
> 

Right. I'll do those changes.

Thanks,
Carlos

