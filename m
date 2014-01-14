From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 3/4] trivial omap big endian changes for v3.14 merge window
Date: Tue, 14 Jan 2014 14:31:52 -0800
Message-ID: <871u0a6vqf.fsf@linaro.org>
References: <20140109011940.GI31323@atomide.com>
	<20140109012139.GK31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:49188 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaANWby (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2014 17:31:54 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so246419pbc.39
        for <linux-omap@vger.kernel.org>; Tue, 14 Jan 2014 14:31:54 -0800 (PST)
In-Reply-To: <20140109012139.GK31323@atomide.com> (Tony Lindgren's message of
	"Wed, 8 Jan 2014 17:21:40 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:
>
>   Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/be-signed
>
> for you to fetch changes up to fc6ca98c81bf0ea8b46064915b5947b971594101:
>
>   ARM: OMAP: debug-leds: raw read and write endian fix (2014-01-07 16:09:45 -0800)
>
> ----------------------------------------------------------------
> Trivial search and replace of read and write functions to allow
> further patches to make omaps work also in big endian mode.
>
> ----------------------------------------------------------------

I think this one should wait for v3.15.  While a trivial rename, it's a
pretty broad change and risks having conflicts and fallouts with other
changes (thinking especially of ongoing clock changes.)

Kevin
