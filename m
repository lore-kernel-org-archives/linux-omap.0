From: David Brownell <david-b@pacbell.net>
Subject: Re: MTD partitions
Date: Wed, 12 Mar 2008 02:16:56 -0800
Message-ID: <200803120316.56363.david-b@pacbell.net>
References: <9c1eb1b90803120306u52ed28cdr4039cd772e901b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:32825 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751192AbYCLKQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2008 06:16:59 -0400
In-Reply-To: <9c1eb1b90803120306u52ed28cdr4039cd772e901b3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Chen <tim.chen.86@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 12 March 2008, Tim Chen wrote:
> What file should I add MTD partitions information to?
> Files in arch/arm/mach-omap1/ or drivers/mtd/maps?

Platform data in .../mach-omap1/board-$(MYBOARD).c should
give default partition data to the relevant NAND driver.

- Dave

