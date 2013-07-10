From: Tony Lindgren <tony@atomide.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Wed, 10 Jul 2013 05:27:44 -0700
Message-ID: <20130710122744.GU5523@atomide.com>
References: <20130705115959.GQ5523@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com>
 <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org>
 <20130710121037.GS5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31289 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754511Ab3GJM1s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 08:27:48 -0400
Content-Disposition: inline
In-Reply-To: <20130710121037.GS5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: balbi@ti.com, Rajendra Nayak <rnayak@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

* Tony Lindgren <tony@atomide.com> [130710 05:17]:
> * Kevin Hilman <khilman@linaro.org> [130710 01:29]:
> 
> If the problem is omap-serial.c idling things while earlycon is
> running, then omap-serial.c should be fixed.

If this is the case, then delaying the idling in omap-serial.c
should take care of the issue as earlycon gets disabled when
the real console has been initialized.

Regards,

Tony
