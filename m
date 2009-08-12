From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: query: omap-defconfigs
Date: Wed, 12 Aug 2009 07:35:41 -0700
Message-ID: <87iqgt14n6.fsf@deeprootsystems.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F598989C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f196.google.com ([209.85.222.196]:61075 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbZHLOfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 10:35:47 -0400
Received: by pzk34 with SMTP id 34so33874pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 07:35:47 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F598989C@dbde02.ent.ti.com> (Vikram Pandita's message of "Wed\, 12 Aug 2009 03\:01\:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

> For the omap board defconfigs, is there a plan to remove these entries:
> CONFIG_SYSFS_DEPRECATED=y
> CONFIG_SYSFS_DEPRECATED_V2=y
>
> I can see that on pm branch on kevin's tree, these are not enabled.
>
> With older busybox, I needed these entries to be enabled, but switching to latest busybox 1_9_2 I could disable these entries without problem.
>
> Anything we would break by removing these DEPRECATED entries? 

I vote to remove them since using OE or OE-based distros like Arago
require them to be disabled.

Kevin
