From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 0/6] Idle status patches revisited
Date: Tue, 12 Jan 2010 11:14:44 -0800
Message-ID: <87aawj9luj.fsf@deeprootsystems.com>
References: <1259916781-2741-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:60413 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab0ALTOr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 14:14:47 -0500
Received: by ywh6 with SMTP id 6so22753698ywh.4
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 11:14:47 -0800 (PST)
In-Reply-To: <1259916781-2741-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\,  4 Dec 2009 10\:52\:55 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Improvements compared to previous set:
>
> - Fixed wrong pwrdm state check on IO chain arming on patch 2
> - Improved changelog on patch 2 & 4
> - Moved FCLK checks inside clockdomain code from powerdomain code in patch 5
> - Some style changes on patch 6
>
> Still, I believe there is no simple way of implementing the idle status
> check by using the usecounts inside clock framework. It would probably be
> possible by adding a new usecount variable that would be updated according
> to slightly different rules, but this also looks bit complicated compared
> to the need.

Tero,

Thanks for this series and the descriptive changelogs and comments.
Very nice.

Along with the comments on individual patches, this should probably
also be rebased on current PM branch.

Also, Paul has lots of other clockdomain/powerdomain changes queued up
for 2.6.34, so it might tbe helpful to Paul if those were based on his
upcoming changes.

Thanks,

Kevin

