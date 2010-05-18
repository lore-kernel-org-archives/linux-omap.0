From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/3 v2] musb: AM35x: Workaround for fifo read issue
Date: Tue, 18 May 2010 19:12:12 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DCC5F3E@dbde02.ent.ti.com>
References: <1274184586-28843-1-git-send-email-ajay.gupta@ti.com>,<4BF28DF2.5010407@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757261Ab0ERNpB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 09:45:01 -0400
In-Reply-To: <4BF28DF2.5010407@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi
> AM35x supports only 32bit read operations so we need to have
> workaround for 8bit and 16bit read operations.

>   But don't we need to override musb_readb() and musb_readw() then?

Yes, Correct. I do have another patch on that which I will cleanup and submit later.
Anyways with currebt three patch set, basic Host and device operation has been tested.

-Ajay

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>WBR, Sergei

