From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/1] Fix control debobs macro
Date: Tue, 25 Nov 2008 07:25:57 -0800
Message-ID: <87wserq12y.fsf@deeprootsystems.com>
References: <1227537275-7161-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:46998 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbYKYP0E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 10:26:04 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1590nfc.21
        for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 07:26:02 -0800 (PST)
In-Reply-To: <1227537275-7161-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Mon\, 24 Nov 2008 16\:34\:34 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patch fixes a silly bug which causes core observability to be configured wrongly for half of the pads.
>
> Peter 'p2' De Schrijver (1):
>   Debobs control macro fix
>
>  arch/arm/plat-omap/include/mach/control.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>

Thanks, will pull into next PM branch.

Kevin
