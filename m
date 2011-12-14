From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 02/10] i2c: OMAP: Add DT support for i2c controller
Date: Tue, 13 Dec 2011 17:06:40 -0800
Message-ID: <87hb14q7vj.fsf@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
	<1323439361-1647-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58023 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753655Ab1LNBGn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 20:06:43 -0500
Received: by mail-yx0-f172.google.com with SMTP id m7so263423yen.17
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 17:06:43 -0800 (PST)
In-Reply-To: <1323439361-1647-3-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 9 Dec 2011 15:02:33 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>

Benoit Cousson <b-cousson@ti.com> writes:

> Add initial DT support to retrieve the frequency using a
> DT attribute instead of the pdata pointer if of_node exist.
>
> Add documentation for omap i2c controller binding.
>
> Based on original patches from Manju and Grant.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

This seems indepenent from the rest of the series, and I can queue up
for merge via the I2C tree.

Benoit, please confirm that we shouldn't have any problems if this patch
goes independently.

Grant/Rob, with your ack on the bindings, I can queue this up for the
I2C maintainers along with some other OMAP I2C changes for v3.3.

Kevin
