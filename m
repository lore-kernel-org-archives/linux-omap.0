From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 2/6 V2] OMAP4: Adding the temperature sensor register set bit fields
Date: Mon, 29 Aug 2011 14:52:38 -0700
Message-ID: <87zkirq40p.fsf@ti.com>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
	<1313664735-8917-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:39887 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755235Ab1H2Vwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 17:52:43 -0400
Received: by mail-yw0-f49.google.com with SMTP id 17so7586968ywp.22
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 14:52:42 -0700 (PDT)
In-Reply-To: <1313664735-8917-3-git-send-email-j-keerthy@ti.com> (Keerthy's
	message of "Thu, 18 Aug 2011 16:22:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

+Benoit

Keerthy <j-keerthy@ti.com> writes:

> OMAP4460 specific temperature sensor register bit fields are added.

...and existing OMAP4 entries are renamed to OMAP4430.

Please be sure to describe thoroughly *all* the changes that are being
done in the changelog.

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: tony@atomide.com

The script that auto-generates this data needs to be updated.

Please coordinate with Benoit to ensure the scripts are updated as well.

Kevin
