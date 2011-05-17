From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 0/2] [RFC] Shrink clock data utilizing preprocessor
Date: Tue, 17 May 2011 15:06:43 +0200
Message-ID: <87r57x4gt8.fsf@ti.com>
References: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41304 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754878Ab1EQNGt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 09:06:49 -0400
Received: by wyb40 with SMTP id 40so499122wyb.21
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 06:06:46 -0700 (PDT)
In-Reply-To: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com> (Vladimir
	Zapolskiy's message of "Mon, 16 May 2011 00:45:56 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Vladimir Zapolskiy <vzapolskiy@gmail.com> writes:

> This change shows a possibility to utilize C preprocessor to remove
> redundant data from clock definitions for OMAP4 architecture.
>
> If the change is evaluated as a positive one, the same approach could
> be applied in reducing LOCs from other files, which contain monotonous
> data enumeration.

Now that I can apply these patches and look at the result, I still have
the same opinion.  For me, this results in a major loss of readability.

Changes just to make nice diffstats are fine, but not when it impacts
readability, etc.  Especially since this data will likely be eventually
moved to device tree, I'd rather see consolidation efforts focused
elsewhere.

Kevin



