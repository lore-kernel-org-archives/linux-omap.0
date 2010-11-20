From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Sat, 20 Nov 2010 13:31:09 +0200
Message-ID: <1290252669.15533.28.camel@eowin>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	 <1290107742-16760-6-git-send-email-h-kanigeri2@ti.com>
	 <20101119085007.GK6446@legolas.emea.dhcp.ti.com>
	 <AANLkTimSxGZufLk1RzQuBSg2vBF1p9BXFP8abVZVoLFs@mail.gmail.com>
	 <20101119120938.GN2329@legolas.emea.dhcp.ti.com>
	 <AANLkTinVf8--zmGa7svapcVpEp2BPXf33DtdruLtoJx5@mail.gmail.com>
	 <20101119125353.GB5818@legolas.emea.dhcp.ti.com>
	 <AANLkTi=VoUixouRAz-a+y9Jf6z94OtLe9UzWjnod743s@mail.gmail.com>
	 <1290176736.15533.17.camel@eowin>
	 <AANLkTi=EMBrb0eHZyzPen2DHGR4ARh1T8ojT7jOVQ67u@mail.gmail.com>
	 <1290208036.15533.24.camel@eowin>
	 <AANLkTi=OH1y=Q39yqd5m+PXEvM1pX6p_SmH_HFYDHHsK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37364 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab0KTLaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Nov 2010 06:30:52 -0500
In-Reply-To: <AANLkTi=OH1y=Q39yqd5m+PXEvM1pX6p_SmH_HFYDHHsK@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: balbi@ti.com, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

Hi Hari,

On Fri, 2010-11-19 at 22:01 -0600, Kanigeri, Hari wrote:
> Of course :), profiling was done before releasing this code and no
> difference observed with or without blocking notifier. All the OMAP4

would you share some numbers ?

> use cases are exercising this code. Just curious , are you doubting
> the blocking notifier mechanism ?

a little bit. Yeah. It added about 600ms of time spent on musb's probe
when we were using blocking notifier for charger detection. When we
moved to atomic notifier, that was solved. Anyway, you can never be sure
when that will be scheduled and if cpu is really busy, it might pose a
great deal.

-- 
balbi

