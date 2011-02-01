From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] arm: mach-omap2: board-rm680: fix rm680_vemmc regulator
 constraints
Date: Tue, 1 Feb 2011 20:27:25 +0200
Message-ID: <20110201202725.804aa011.jhnikula@gmail.com>
References: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62341 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab1BAS13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 13:27:29 -0500
Received: by fxm20 with SMTP id 20so7102893fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 10:27:28 -0800 (PST)
In-Reply-To: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue,  1 Feb 2011 17:36:28 +0200
Aaro Koskinen <aaro.koskinen@nokia.com> wrote:

> With the commit 757902513019e6ee469791ff76f954b19ca8d036 fixed voltage
> regulator setup will fail if there are voltage constraints defined. This
> made MMC unusable on this board. Fix by just deleting those redundant
> constraints.
> 
True. Before there were a test min_uV == max_uV && ops->set_voltage and
now min_uV == max_uV followed by test for ops->set_voltage that returns
EINVAL if not set (NULL for fixed voltage regulator obviously).

Reviewed-by: Jarkko Nikula <jhnikula@gmail.com>
