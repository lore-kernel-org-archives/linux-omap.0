From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM: OMAP3 HS/EMU off-mode support
Date: Wed, 29 Oct 2008 11:19:37 -0700
Message-ID: <8763nb8ds6.fsf@deeprootsystems.com>
References: <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.159]:35005 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbYJ2STl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 14:19:41 -0400
Received: by po-out-1718.google.com with SMTP id y22so5386513pof.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 11:19:40 -0700 (PDT)
In-Reply-To: <1223987011-25667-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Tue\, 14 Oct 2008 15\:23\:25 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> This patchset provides off-mode support for OMAP3 HS/EMU devices. Due to
> secure environment in these devices, wake-up from off-mode is slightly
> different than in GP devices. This code has been tested on following chip
> versions: ES2.1GP, ES3.0EMU, ES3.0HS.

Thanks, I'm pulling this series into the next PM branch.

Kevin
