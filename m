From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM and 2.6.31
Date: Thu, 09 Jul 2009 09:53:21 -0700
Message-ID: <87iqi1u7b2.fsf@deeprootsystems.com>
References: <4A55D079.30501@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:64888 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761398AbZGIQxY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 12:53:24 -0400
Received: by pzk5 with SMTP id 5so201012pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2009 09:53:24 -0700 (PDT)
In-Reply-To: <4A55D079.30501@nokia.com> (Roger Quadros's message of "Thu\, 09 Jul 2009 14\:11\:53 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Roger Quadros <ext-roger.quadros@nokia.com> writes:

>   When do you plan to rebase PM to 2.6.31rc2 ?

<dodge>
When tony updates l-o master to v2.6.31-rc2. :)
</dodge>

Seriously though, I'm currently migrating to the new
omap_hwmod/omap_device infrastructure, and when I get that stabilized,
I'll move to the latest linux-omap HEAD.

Kevin



