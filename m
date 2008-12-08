From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Add TI TSC2005 Touchscreen driver
Date: Mon, 8 Dec 2008 20:28:12 +0200
Message-ID: <20081208182812.GD13076@frodo>
References: <5d5443650812080949h5aff6010mb7341f581841f126@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41518 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbYLHS2V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 13:28:21 -0500
Content-Disposition: inline
In-Reply-To: <5d5443650812080949h5aff6010mb7341f581841f126@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com

On Mon, Dec 08, 2008 at 11:19:53PM +0530, Trilok Soni wrote:
> +static ssize_t tsc2005_disable_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct tsc2005		*tsc = dev_get_drvdata(dev);
> +	unsigned long res;
> +	int i;
> +
> +	i = strict_strtoul(buf, 10, &res);
> +	i = i ? 1 : 0;

shouldn't this be i = res ? 1 : 0; ??

-- 
balbi
