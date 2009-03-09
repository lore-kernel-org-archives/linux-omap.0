From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] OMAP3: GPIO off-mode fixes
Date: Mon, 09 Mar 2009 11:48:29 -0700
Message-ID: <87mybuy1ky.fsf@deeprootsystems.com>
References: <1236339986-29506-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:38957 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbZCISse (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 14:48:34 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1035633wah.21
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2009 11:48:32 -0700 (PDT)
In-Reply-To: <1236339986-29506-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\,  6 Mar 2009 13\:46\:24 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> These two patches add fixes to GPIO off-mode handling. First patch is more
> important as it fixes a HW bug, second one just optimizes off-mode code
> a bit by removing a couple of unnecessary registers from the context save.

Thanks, pushing both patches to PM branch.

Kevin
