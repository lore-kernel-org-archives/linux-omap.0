From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] arm: mach-omap2: board-rm680: fix rm680_vemmc regulator
 constraints
Date: Fri, 04 Feb 2011 16:31:40 +0300
Message-ID: <4D4BFFBC.4040606@ru.mvista.com>
References: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64100 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab1BDNcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 08:32:54 -0500
Received: by fxm20 with SMTP id 20so2408762fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 05:32:53 -0800 (PST)
In-Reply-To: <1296574588-23588-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 01-02-2011 18:36, Aaro Koskinen wrote:

> With the commit 757902513019e6ee469791ff76f954b19ca8d036 fixed voltage

    Please also specify the commit summary in parens, as asked by Linus.

> regulator setup will fail if there are voltage constraints defined. This
> made MMC unusable on this board. Fix by just deleting those redundant
> constraints.

> Signed-off-by: Aaro Koskinen<aaro.koskinen@nokia.com>

WBR, Sergei
