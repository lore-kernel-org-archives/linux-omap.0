From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH] omap: fix build when MTD_NAND_OMAP2 and TOUCHSCREEN_ADS7846 are disabled
Date: Wed, 4 May 2011 12:02:57 -0400
Message-ID: <53A11D3C-4DBA-4772-AF14-3590772F6AA1@linuxhacker.ru>
References: <1304515622-25113-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:53446 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab1EDQDJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 12:03:09 -0400
In-Reply-To: <1304515622-25113-1-git-send-email-mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello!

On May 4, 2011, at 9:27 AM, Mike Rapoport wrote:

> Commits 5e6a64b36ce346b7a2d481ef9fa315290eb28e5e (omap: move detection of
> NAND CS to common-board-devices) and 96974a249b0cf3537f49115a59be67e2c54f315c
> (omap: consolidate touch screen initialization among different boards)
> break compilation when CONFIG_MTD_NAND_OMAP2 and
> CONFIG_TOUCHSCREEN_ADS7846 are not selected.
> Removing ifdefs and stubs from common-board-devices.h fixes the problem.

Works for me.

Bye, 
   Oleg

