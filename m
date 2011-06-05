From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH v4] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Sun, 5 Jun 2011 14:19:15 +0530
Message-ID: <20110605084915.GA2887@avinash-laptop>
References: <1305906384-22061-1-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:60534 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755430Ab1FEItd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Jun 2011 04:49:33 -0400
Received: by gxk2 with SMTP id 2so1796105gxk.22
        for <linux-omap@vger.kernel.org>; Sun, 05 Jun 2011 01:49:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305906384-22061-1-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Fri, May 20, 2011 at 09:16:24PM +0530, Avinash.H.M wrote:
> The sequence of _ocp_softreset doesn't work for i2c. The i2c module has a
> special sequence to reset the module. The sequence is
>  - Disable the I2C.
>  - Write to SOFTRESET bit.
>  - Enable the I2C.
>  - Poll on the RESETDONE bit.
> The sequence is implemented as a function and the i2c_class is updated with
> the correct 'reset' pointer.  omap_hwmod_softreset function is implemented
> which triggers the softreset by writing into sysconfig register. On following
> this sequence, i2c module resets properly and timeouts are not seen.
> 
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> ---

Hi Kevin, Paul ,

Ping .. could you please review this.

thanks ,

- Avinash

