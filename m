From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Tue, 17 Mar 2015 09:48:49 +0100
Message-ID: <20150317084849.GB9761@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <B8616E57-51B5-446E-87D5-9C3EC9B5F1C9@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55223 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbCQIsw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 04:48:52 -0400
Content-Disposition: inline
In-Reply-To: <B8616E57-51B5-446E-87D5-9C3EC9B5F1C9@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, Belisko Marek <marek.belisko@gmail.com>

> 
> Temperature calibration should have already been done in the underlaying twl4030 iio driver.
> 
> Discharge rate is the real current flow reported in uA. Also
> reported by iio.

Ack, but there's rather severe temperature dependency of the lithium
battery, which you should take into account if you want to compute
"percentage charged".
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
