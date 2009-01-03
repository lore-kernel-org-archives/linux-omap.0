From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] Add TI TSC2005 Touchscreen driver
Date: Sat, 3 Jan 2009 10:08:03 +0530
Message-ID: <5d5443650901022038p310f77e3ifee241080126d9b1@mail.gmail.com>
References: <5d5443650812080949h5aff6010mb7341f581841f126@mail.gmail.com>
	 <20081208182812.GD13076@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:9758 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZACEiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jan 2009 23:38:05 -0500
In-Reply-To: <20081208182812.GD13076@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com

Hi Felip,

Sorry for the delayed reply.

On Mon, Dec 8, 2008 at 11:58 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Mon, Dec 08, 2008 at 11:19:53PM +0530, Trilok Soni wrote:
>> +static ssize_t tsc2005_disable_store(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  const char *buf, size_t count)
>> +{
>> +     struct tsc2005          *tsc = dev_get_drvdata(dev);
>> +     unsigned long res;
>> +     int i;
>> +
>> +     i = strict_strtoul(buf, 10, &res);
>> +     i = i ? 1 : 0;
>
> shouldn't this be i = res ? 1 : 0; ??

You are right, I will change this.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
