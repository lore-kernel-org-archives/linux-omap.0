From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
Date: Fri, 01 Apr 2011 14:12:26 -0700
Message-ID: <87k4fdllqd.fsf@ti.com>
References: <1301672047-31903-1-git-send-email-avinashhm@ti.com>
	<1301672047-31903-2-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40639 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754857Ab1DAVM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 17:12:29 -0400
Received: by iwn8 with SMTP id 8so5710497iwn.16
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 14:12:28 -0700 (PDT)
In-Reply-To: <1301672047-31903-2-git-send-email-avinashhm@ti.com> (Avinash
	H. M.'s message of "Fri, 1 Apr 2011 21:04:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M" <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Hi Avinash,

"Avinash.H.M" <avinashhm@ti.com> writes:

> The i2c module has a special reset sequence. The sequence is
> - Disable the I2C.
> - Write to SOFTRESET bit.
> - Enable the I2C.
> - Poll on the RESETDONE bit.

Shouldn't the final state be disabled after reset?  IOW, Shouldn't the
I2C be disabled again after the polling?

Also, when reposting, please be sure to Cc the linux-arm-kernel mailing
list for patches that are targetted for upstream.

Thanks,

Kevin


