From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/3] radio-tea5761: Update driver
Date: Tue, 10 Jun 2008 05:07:47 +0300
Message-ID: <20080610020746.GF4962@kedavra.cpe.vivax.com.br>
References: <1213041943-31218-1-git-send-email-edubezval@gmail.com> <1213041943-31218-2-git-send-email-edubezval@gmail.com> <1213041943-31218-3-git-send-email-edubezval@gmail.com> <1213041943-31218-4-git-send-email-edubezval@gmail.com> <20080609234028.GC4962@kedavra.cpe.vivax.com.br> <a0580c510806091814g246a1553n7e78f8a857d978f8@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39156 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbYFJCH0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 22:07:26 -0400
Content-Disposition: inline
In-Reply-To: <a0580c510806091814g246a1553n7e78f8a857d978f8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

On Mon, Jun 09, 2008 at 09:14:21PM -0400, Eduardo Valentin wrote:
> If I understood correctly what you said, the same comment I said
> before also applies here.
> Eventhough it prints that the probe
> failed, this way I sent it says: The probe failed and "The driver
> registration failed". More easy
> to debug the code when in a error situation.

But if probe fails, driver registration failed. The same comment Jean
Delvare gave me when I was sending some isp1301 patches upstream, so
later on, when this driver goes to mailine, it'll probably, if Jean
happens to see this one, get commented on this point as well.

If you look at drivers/i2c/chips/*.c you'll see that only in two cases
they are printing error if i2c_add_driver() fails and those are really
necessary cases (check those drivers).

But anyway, if you think it's really necessary.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
