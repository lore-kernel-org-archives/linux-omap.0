From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1]  Patch for I2C transmit overflow error
Date: Thu, 7 Aug 2008 16:38:58 -0700
Message-ID: <200808071638.58130.david-b@pacbell.net>
References: <54576.192.168.10.89.1218118251.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:48017 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752907AbYHGXi7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 19:38:59 -0400
In-Reply-To: <54576.192.168.10.89.1218118251.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: chandra shekhar <x0044955@ti.com>
Cc: linux-omap@vger.kernel.org

On Thursday 07 August 2008, chandra shekhar wrote:
> This patch is to fix I2C transmit overflow error.
> I guess it should fix the OSK5912 error. I dont have the board to test it.

Yes, it makes those error reports go away.
I'd say to merge this patch.
