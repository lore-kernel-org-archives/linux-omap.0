From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Sat, 17 Dec 2011 00:33:23 +0800
Message-ID: <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
	<CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
	<CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34436 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759502Ab1LPQdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 11:33:24 -0500
Received: by mail-ww0-f44.google.com with SMTP id dr13so6494733wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 08:33:24 -0800 (PST)
In-Reply-To: <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Sat, Dec 17, 2011 at 12:09 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> No. The table reflects the actual possible combination on hardware. You can't
> add anything there arbitrary if that combination is not supported.
>
> But that makes me wonder how the patch worked. I will look at this in detail
> next week.

Thanks, I use the below hwmod data patch[1] and omap device patch[2]
to bring up fdif module, and Benoit has ACKed on patch [1].


[1], http://marc.info/?l=linux-kernel&m=132387140703874&w=2
[2], http://marc.info/?l=linux-kernel&m=132387155403929&w=2

thanks,
-- 
Ming Lei
