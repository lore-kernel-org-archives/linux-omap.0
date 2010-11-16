From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] i2c-omap: Set latency requirements only once for several
 messages
Date: Tue, 16 Nov 2010 03:58:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011160358092.10064@utopia.booyaka.com>
References: <1289896100-28881-1-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43104 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934030Ab0KPK6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:58:23 -0500
In-Reply-To: <1289896100-28881-1-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Tue, 16 Nov 2010, Samu Onkalo wrote:

> Ordinary I2C read consist of two messages. First a write operation
> to tell register address and then read operation to get data.
> CPU wake up latency is set and removed twice in read case.
> Set latency requirement before the message processing loop
> and remove the requirement after the loop to remove latency
> adjustment operations between the messages.
> 
> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
