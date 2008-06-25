From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/7] 34XX: PM: Workaround to build omap hsmmc as a module
Date: Wed, 25 Jun 2008 04:50:55 -0500
Message-ID: <0442c5b0cf27a0b9f892174dadba3c20@felipebalbi.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com> <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43667 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbYFYJu7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 05:50:59 -0400
In-Reply-To: <1214385220-25576-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org



On Wed, 25 Jun 2008 12:13:40 +0300, Jouni Hogander
<jouni.hogander@nokia.com> wrote:
> Current omap hsmmc driver is not pm friendly. Build it as a module
> because it prevents omap3 retention.

Small comment.

At least this patch shouldn't be reverted, there's no reason
for not building drivers as modules. I'll do the same
to musb.

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

