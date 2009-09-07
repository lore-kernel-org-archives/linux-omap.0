From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 6/10] omap mailbox: remove unnecessary arg for
	omap_mbox_msg_send
Date: Mon, 7 Sep 2009 16:02:43 +0100
Message-ID: <20090907150243.GB6538@flint.arm.linux.org.uk>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108F0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33875 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbZIGPCx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 11:02:53 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108F0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

On Fri, Sep 04, 2009 at 05:18:04PM +0530, C.A, Subramaniam wrote:
> @@ -114,7 +114,6 @@ int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg, void* arg)
>  	}
>  
>  	tx_data->msg = msg;
> -	tx_data->arg = arg;

What about also removing 'arg' from struct omap_msg_tx_data ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
