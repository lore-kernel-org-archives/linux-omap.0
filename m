From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 3/5] ARM: dts: AM33XX: Fix gpio numbering to match hardware/TRM
Date: Wed, 27 Mar 2013 14:23:09 +0100
Message-ID: <87fvzh6koy.fsf@dell.be.48ers.dk>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
	<1364389156-8273-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:44480 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3C0NXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 09:23:13 -0400
Received: by mail-ea0-f181.google.com with SMTP id z10so3335222ead.12
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 06:23:12 -0700 (PDT)
In-Reply-To: <1364389156-8273-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Wed, 27 Mar 2013 18:29:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, mporter@ti.com, devicetree-discuss@lists.ozlabs.org

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> With DT support, where naming convention is based on base-addr
 Vaibhav> and not id, so we should follow TRM/Spec numbering label.

 Vaibhav> This patch changes GPIO numbering as per TRM, as gpio0-3.

 Vaibhav> Matt Porter had submitted base patch sometime back but it
 Vaibhav> didn't make it to the mainline -
 Vaibhav> https://patchwork.kernel.org/patch/1433001/

 Vaibhav> Later DT nodes for gpio based keypad and led driver got
 Vaibhav> merged, so this fix needs to propagate to board dts files
 Vaibhav> as well.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
