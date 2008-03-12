From: "Tim Chen" <tim.chen.86@gmail.com>
Subject: MTD partitions
Date: Wed, 12 Mar 2008 18:06:50 +0800
Message-ID: <9c1eb1b90803120306u52ed28cdr4039cd772e901b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:58241 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbYCLKGu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 06:06:50 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1732888rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 12 Mar 2008 03:06:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
I'm trying to add MTD NAND partitions to my OMAP850 based board.

I saw NAND partitions information in arch/arm/mach-omap1/board-h3.c,
But after some survey, I found *.c files in drivers/mtd/maps, there're
also files containing MTD partitions information.
What file should I add MTD partitions information to?
Files in arch/arm/mach-omap1/ or drivers/mtd/maps?

Thanks.

-- 
--
Regards,
Tim.
