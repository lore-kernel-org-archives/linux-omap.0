From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [patch 2.6.27-rc3-omap1] omap3 beagle: nand (mostly) cleanups
Date: Tue, 2 Sep 2008 11:46:31 -0700
Message-ID: <5e088bd90809021146n6fbc7b50l924f757cbf6f4e08@mail.gmail.com>
References: <200808291012.47332.david-b@pacbell.net>
	 <13B9B4C6EF24D648824FF11BE896716203653CA11D@dlee02.ent.ti.com>
	 <200809021023.55493.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:12837 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYIBSqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 14:46:33 -0400
Received: by gv-out-0910.google.com with SMTP id e6so68730gvc.37
        for <linux-omap@vger.kernel.org>; Tue, 02 Sep 2008 11:46:32 -0700 (PDT)
In-Reply-To: <200809021023.55493.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Sep 2, 2008 at 10:23 AM, David Brownell <david-b@pacbell.net> wrote:

> (Unrelated:  make omap3_beagle_i2c_init be part of beagle_init.
> It shouldn't be called on non-beagle hardware; and beagle_init
> already runs with other arch_initcall code.)

Good catch, I will do the same on the Overo board file.

Steve
