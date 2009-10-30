From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH v3 1/2] arm: a driver for on-chip ETM and ETB
Date: Fri, 30 Oct 2009 14:10:24 +0200
Message-ID: <20091030121024.GB15200@shisha.kicks-ass.net>
References: <1256230315-22340-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.welho.com ([213.243.153.40]:38298 "EHLO smtp6.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbZJ3MXY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Oct 2009 08:23:24 -0400
Content-Disposition: inline
In-Reply-To: <1256230315-22340-1-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Oct 22, 2009 at 07:51:54PM +0300, Alexander Shishkin wrote:
> Changes:
> v3 -- major update:
>       * switched from platform device to AMBA device
>       * started using clk API in a more proper way
>       * changed omap3 Kconfig part to select the driver instead of depending
>         on it

Russell, I believe this one addresses your concerns about my previous patches.
Shall I wait for more comments from you or do you want me to upload them to
your patch tracker?

Regards,
--
Alex
