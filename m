From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] OMAP: DSS2: omap_dss_probe() conditional compilation cleanup
Date: Thu, 06 May 2010 11:52:51 -0700
Message-ID: <874oikvp4s.fsf@deeprootsystems.com>
References: <cover.1273146321.git.ext-jani.1.nikula@nokia.com>
	<cover.1273146321.git.ext-jani.1.nikula@nokia.com>
	<bce34ed2a9f7206ddeedb2921807c7602cfcaaaa.1273146322.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f189.google.com ([209.85.221.189]:39492 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab0EFSw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 14:52:56 -0400
Received: by qyk27 with SMTP id 27so512201qyk.23
        for <linux-omap@vger.kernel.org>; Thu, 06 May 2010 11:52:56 -0700 (PDT)
In-Reply-To: <bce34ed2a9f7206ddeedb2921807c7602cfcaaaa.1273146322.git.ext-jani.1.nikula@nokia.com> (Jani Nikula's message of "Thu\,  6 May 2010 14\:59\:02 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: Tomi.Valkeinen@nokia.com, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

Jani Nikula <ext-jani.1.nikula@nokia.com> writes:

> From: Jani Nikula <ext-jani.1.nikula@nokia.com>
>
> Move a number of #ifdefs from code into dss.h and elsewhere, and
> conditionally define no-op static inline functions, cleaning up the
> code. This style is according to Documentation/SubmittingPatches.
>
> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>

Indeed, this helps readability greatly.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
