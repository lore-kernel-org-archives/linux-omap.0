From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/2] omap: rx51: Set regulator V28_A always on
Date: Tue, 31 May 2011 02:34:23 -0700
Message-ID: <20110531093423.GP11352@atomide.com>
References: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:45334 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751251Ab1EaJe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 05:34:28 -0400
Content-Disposition: inline
In-Reply-To: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

* Jarkko Nikula <jhnikula@gmail.com> [110531 01:22]:
> The V28_A domain in Nokia N900 that supplies VDD voltages to TLV320AIC34 and
> TPA6130A2 should not be shutdown. This is because otherwise there will be
> leak from VIO to VDD in TLV320AIC34 and this leak consumes more battery
> current that is saved from keeping V28_A off. With this patch the battery
> current consumption is approximately 1.5 mA lower.

Thanks, applying into fixes.

Tony
