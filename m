From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 05/19] ARM: OMAP4: PM: save/restore all CM1/2 settings in OFF mode
Date: Wed, 16 May 2012 15:48:51 -0700
Message-ID: <87zk977ne4.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45238 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760738Ab2EPWsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 18:48:54 -0400
Received: by pbbrp16 with SMTP id rp16so1560153pbb.10
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 15:48:53 -0700 (PDT)
In-Reply-To: <1336990730-26892-6-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:36 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Axel Haslam <axelhaslam@gmail.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Restore all CM1/2 module registers as they are lost in OFF mode.

Save and restore?

Also, as in the previous patch.  Can this be done using cluster PM
notifier as well?    (I realize that this series was probably done
before the PM notifiers were upstream, but now that we have them, we
should use them.)

Kevin
