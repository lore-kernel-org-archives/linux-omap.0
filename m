From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v6 00/13] OMAP: GPIO: Implement GPIO in hwmod way
Date: Sat, 25 Sep 2010 17:29:07 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030C8FBC50@dbde02.ent.ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
	<87r5goq7ro.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD3C16FE@dbde02.ent.ti.com>
	<87zkvbj7yc.fsf@deeprootsystems.com>	<87k4mefz70.fsf@deeprootsystems.com>
	<87bp7qfx6g.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD46A104@dbde02.ent.ti.com>
 <8762xvdm3h.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47446 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755272Ab0IYL7R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 07:59:17 -0400
In-Reply-To: <8762xvdm3h.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Saturday, September 25, 2010 12:07 AM
> To: Varadarajan, Charulatha; Premi, Sanjeev
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; paul@pwsan.com; Cousson,
> Benoit; Nayak, Rajendra; Basak, Partha
> Subject: Re: [PATCH v6 00/13] OMAP: GPIO: Implement GPIO in hwmod way
> 
> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 
> Aha.  Thanks for digging into this.
> 
> Now it makes sense why it worked for SDP and overo, but not omap3evm.
> Relying too much on bootloader settings is definitely a bug in the board
> file.  Since we understand it, I am OK if your series breaks this board
> support.

Thanks. Would send the new series of GPIO hwmod patches as per our latest
alignment soon.

> 
> > With GPIO hwmod series, gpio module reset happens during init and hence
> > the uboot settings are modified which makes the Ethernet controller to
> fail.
> >
> > Patch [1] below if applied on top of gpio hwmod series would make the
> > evm board work with DHCP and nfsroot.
> 
> Indeed, I verified that this method works, although maybe I have an
> older board with a reset line that is not in GPIO1, because setting the
> flag in GPIO1 didn't work.  I blindly set it in all the banks, and got
> my board working.

Okay. Something similar must be the reason. Let us get the OMAP3 EVM
Ethernet Controller initialization fixed.

> 
> > Rather, patch [2] below would be a better fix for this. I am not
> > getting deeper into the minor details of Ethernet controller
> > initialization for OMAP3 EVM board. This patch would suffice for
> > now. But my observation is that omap3evm_init_smsc911x() needs to be
> > fixed including CS configuration and other required settings for
> > Ethernet controller.
> 
> Yes, patch 2 is the better approach (although, I couldn't get it to work
> for me.)  I suggest you raise this with Sanjeev and post your patch 2 as
> an RFC to
> the list saying that something like this will be needed after your GPIO
> series.  We'll let Sanjeev or someone on his team fix omap3evm support,
> being sure it works for older boards as well.

Posted. See [a]

<<snip>>

> > +	/* Configure ethernet controller reset gpio */
> > +	if (gpio_request(OMAP3EVM_ETHR_GPIO_RST, "SMSC911x gpio") < 0) {
> > +		pr_err(KERN_ERR "Failed to request GPIO8 for smsc911x
> gpio\n");
> > +		return;
> > +	}
> 
> This request has to come before you set the direction and set the value.

My bad :-( 
I had sent wrong patch by mistake.
 
-V Charulatha

[a] https://patchwork.kernel.org/patch/208892/
