From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes
	to support OMAP4 mailbox.
Date: Wed, 23 Sep 2009 10:56:28 +0100
Message-ID: <20090923095627.GA29765@flint.arm.linux.org.uk>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53834 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbZIWJ4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 05:56:37 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>, "tony@atomide.com" <tony@atomide.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

On Tue, Sep 22, 2009 at 08:03:32PM +0530, C.A, Subramaniam wrote:
> @@ -70,10 +88,9 @@ static inline void mbox_write_reg(u32 val, size_t ofs)
>  static int omap2_mbox_startup(struct omap_mbox *mbox)
>  {
>  	unsigned int l;
> -
>  	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
>  	if (IS_ERR(mbox_ick_handle)) {
> -		printk("Could not get mailboxes_ick\n");
> +		printk(KERN_ERR "Could not get mailboxes_ick\n");
>  		return -ENODEV;

Good idea: Print the error code so people can diagnose why things fail.

		printk(KERN_ERR "Could not get mailboxes_ick: %d\n",
			PTR_ERR(mbox_ick_handle));

And wonder why this hasn't been spotted before.

Rule: always propagate error codes when you have one to propagate.

		return PTR_ERR(mbox_ick_handle);

BTW, in future, please post patches to my linux@ address, not my rmk@
address.  Patches to my rmk@ address tend to be heavily buried.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
