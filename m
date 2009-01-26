From: Kalle Valo <kalle.valo@nokia.com>
Subject: Re: [PATCH 3/3] Disable linux-omap version of menelaus
Date: Mon, 26 Jan 2009 13:35:11 +0200
Message-ID: <877i4iqp00.fsf@nokia.com>
References: <20090122131602.18315.84862.stgit@tikku>
	<20090122131920.18315.68032.stgit@tikku>
	<20090122131509.GH9233@scadufax.research.nokia.com>
	<20090123022334.GN7172@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63710 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbZAZLfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2009 06:35:40 -0500
In-Reply-To: <20090123022334.GN7172@atomide.com> (ext Tony Lindgren's message of "Thu\, 22 Jan 2009 18\:23\:34 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

>> > diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
>> > index b451369..d8bef8c 100644
>> > --- a/drivers/i2c/chips/Makefile
>> > +++ b/drivers/i2c/chips/Makefile
>> > @@ -18,7 +18,6 @@ obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
>> >  obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
>> >  obj-$(CONFIG_PCF8575)		+= pcf8575.o
>> >  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>> > -obj-$(CONFIG_MENELAUS)		+= menelaus.o
>
> I'll also remove drivers/i2c/chips/menelaus.c.

Thanks. It's nice to see drivers going to upstream.

-- 
Kalle Valo
