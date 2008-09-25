From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: MMC broken on beagleboard with current git
Date: Thu, 25 Sep 2008 08:24:30 -0700
Message-ID: <5e088bd90809250824q38fb95e0q7a9e3f8a24a4d845@mail.gmail.com>
References: <FDAFB709-68B8-478D-8321-1322449B9A7F@student.utwente.nl>
	 <20080925085142.GC5222@atomide.com>
	 <77EE6A0D-895B-4E0B-B9C4-18D333BFF85C@student.utwente.nl>
	 <20080925094718.GE5222@atomide.com>
	 <4D346DA2-6C57-48A7-AC4E-2191C44497CF@student.utwente.nl>
	 <20080925103952.GJ5222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:37345 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYIYPYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 11:24:32 -0400
Received: by rn-out-0910.google.com with SMTP id k40so164228rnd.17
        for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 08:24:31 -0700 (PDT)
In-Reply-To: <20080925103952.GJ5222@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Thu, Sep 25, 2008 at 3:39 AM, Tony Lindgren <tony@atomide.com> wrote:

> Hmm, I don't understand how it could work on 3430sdp...
>
> Looks like board-omap3beagle.c calls hsmmc_init() just like
> board-3430sdp.c. Maybe timings have changed and you need
> a longer delay somewhere during the init?

I can confirm that mmc is also broken on Overo.  I'll spend some time
today investigating.

Steve
