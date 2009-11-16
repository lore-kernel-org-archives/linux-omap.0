From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/6] Idle status patches revisited
Date: Mon, 16 Nov 2009 11:30:45 -0800
Message-ID: <87ocn2jmhm.fsf@deeprootsystems.com>
References: <1258045359-7962-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41529 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbZKPTal (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 14:30:41 -0500
Received: by pzk1 with SMTP id 1so3004129pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 11:30:47 -0800 (PST)
In-Reply-To: <1258045359-7962-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 12 Nov 2009 19\:02\:33 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Following set implements checks for idle states of powerdomains, and
> changes target cpuidle state according to those. This also includes as
> a cleanup removal of some hacks from omap_sram_idle(), and also introduces
> INACTIVE / ON state support for powerdomains which simplifies the code.
>
> Applies on top of PM branch.

Hi Tero,

I *really* like this cleanup and re-organization you've done.  I have
a few minor comments on some of the patches, but overall it looks
really good.

I'll wait for Paul's comments/signoff on PATCH 1/6, and after some of
my comments are addressed, I'll gladly pull an updated series into the
PM branch.

Kevin
