From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 7/8] 34XX: PM: Workaround to disable mmc
Date: Tue, 17 Jun 2008 06:31:44 -0500
Message-ID: <663b4c9bb83ca6e0f9e490db7bfdccce@felipebalbi.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com> <1213687871-30038-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59456 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbYFQLbq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 07:31:46 -0400
In-Reply-To: <1213687871-30038-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org



On Tue, 17 Jun 2008 10:31:11 +0300, Jouni Hogander
<jouni.hogander@nokia.com> wrote:
> Current hsmmc is not pm friendly. Disable it because it prevents omap3
> retention

Disabling will just hide the bug. Better making it modular
and let mmc guys dig on it.

What do you need to make it more pm friendly?

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

