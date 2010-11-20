From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH v3 5/5] OMAP: mailbox: add notification support for
 multiple readers
Date: Sat, 20 Nov 2010 07:26:20 -0600
Message-ID: <AANLkTimUD8Yi8KK_tsjm4CQPtp6VdYr51K4L=9MkNcOZ@mail.gmail.com>
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
	<1290252669.15533.28.camel@eowin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42773 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753696Ab0KTN0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Nov 2010 08:26:21 -0500
Received: by mail-vw0-f51.google.com with SMTP id 2so2943811vws.10
        for <linux-omap@vger.kernel.org>; Sat, 20 Nov 2010 05:26:20 -0800 (PST)
In-Reply-To: <1290252669.15533.28.camel@eowin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: balbi@ti.com, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Fernando Guzman Lugo <x0095840@ti.com>

Felipe,

On Sat, Nov 20, 2010 at 5:31 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> Hi Hari,
>
> On Fri, 2010-11-19 at 22:01 -0600, Kanigeri, Hari wrote:
>> Of course :), profiling was done before releasing this code and no
>> difference observed with or without blocking notifier. All the OMAP4
>
> would you share some numbers ?

Sure. On an average, 135 us for round trip message from A9 userspace
Process to a thread running on M3 that handles this message.
The test is with the entire IPC stack on both ends.

Thank you,
Best regards,
Hari
