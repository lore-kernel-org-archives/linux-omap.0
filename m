From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 0/6] ARM; OMAP2+: hwmod and SERIAL: Remove sysc
 handling from driver
Date: Fri, 10 May 2013 09:02:00 -0500
Message-ID: <20130510140200.GA11267@kahuna>
References: <1366973695-2088-1-git-send-email-rnayak@ti.com>
 <87ppxhxixu.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38666 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab3EJOCh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 May 2013 10:02:37 -0400
Content-Disposition: inline
In-Reply-To: <87ppxhxixu.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

On 11:09-20130426, Kevin Hilman wrote:
> Rajendra Nayak <rnayak@ti.com> writes:
> 
> [...]
> 
> > OMAP UART IP needs manual idle modes based on functional state of the
> > IP. Currently this is handled by the driver with function pointers
> > implemented in platform code.
> >
> > This however breaks in case of device tree because of missing
> > idle handling. 
> >
> > The series tries to address the issue and tries to remove complete
> > sysc handling from serial driver.
> 
> Other than the minor nit about the order of the series for bisect, 
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> Also tested this on OMAP4/Panda where I was having the sluggish console
> issues using DT boot, and and can confirm that this fixes the problem:
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>  # OMAP4/Panda
> 
I saw the same let of console sluggishness on SDP4430, Panda, Panda-ES
as well on latest linus master.

For reference, I have rebased the series to latest master and fixes the
sequencing:
https://github.com/nmenon/linux-2.6-playground/commits/push/uart-fixes-sidle-3.10
based on:
master 70eba42 Merge tag 'please-pull-pstore' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux

Rajendra,
Would you be able to repost this series so that we can get this into
3.10-rc2+?

-- 
Regards,
Nishanth Menon
