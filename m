From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 06/12] ARM: dts: AM43xx: Add aliases to d_can nodes
Date: Wed, 10 Sep 2014 11:08:45 +0300
Message-ID: <5410070D.9030605@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com> <1410274534-22826-7-git-send-email-rogerq@ti.com> <540F1806.9000302@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57897 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbaIJII6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2014 04:08:58 -0400
In-Reply-To: <540F1806.9000302@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, tony@atomide.com
Cc: wg@grandegger.com, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org

On 09/09/2014 06:08 PM, Marc Kleine-Budde wrote:
> On 09/09/2014 04:55 PM, Roger Quadros wrote:
>> The d_can driver expects appropriately named aliases for
>> the d_can nodes for the RAMINIT control register access.
>>
>> Provide those, otherwise RAMINIT register won't be configured.
>> Get's rid of the following messages during boot.
> 
> With your patch set this is not true anymore, is it?

Right. I'll drop this patch.

cheers,
-roger
