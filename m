From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 06/10] ARM: OMAP2+: powerdomain/clockdomain: add a
 per-powerdomain spinlock
Date: Wed, 12 Dec 2012 11:28:01 +0100
Message-ID: <CAORVsuX=az540kBsshEwJV_KM=Wp+y1uzVHbTp=EYvzbBqcutQ@mail.gmail.com>
References: <20121209011755.19716.25244.stgit@dusk.lan>
	<20121209012340.19716.62316.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:60920 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab2LLK2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 05:28:01 -0500
Received: by mail-ie0-f178.google.com with SMTP id c12so1395208ieb.37
        for <linux-omap@vger.kernel.org>; Wed, 12 Dec 2012 02:28:01 -0800 (PST)
In-Reply-To: <20121209012340.19716.62316.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Paul,

-resending in plain text only, sorry about that-

On Sun, Dec 9, 2012 at 2:23 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Add a per-powerdomain spinlock.  Use that instead of the clockdomain
> spinlock.  Add pwrdm_lock()/pwrdm_unlock() functions to allow other
> code to acquire or release the powerdomain spinlock without reaching
> directly into the struct powerdomain.

Since clockdomains are part of powerdomains it seems weird for the
clockdomain code to take a powerdoamin lock.
Is there a reason why the powerdomain could not take the lock before
calling the clockdomain functions?

Also, are the lock and nolock version the clockdomain function needed?

Regards,
Jean
