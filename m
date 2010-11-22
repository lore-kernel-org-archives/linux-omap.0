From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 2/6] OMAP: powerdomain: Infrastructure to put arch
 specific code
Date: Mon, 22 Nov 2010 11:51:58 +0530
Message-ID: <83e82c84a0393aee1b1a9262149a819a@mail.gmail.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com><1289921886-5139-2-git-send-email-rnayak@ti.com><1289921886-5139-3-git-send-email-rnayak@ti.com>
 <20101116171117.46a13d0a@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43083 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792Ab0KVGWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 01:22:08 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so311652qyk.17
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 22:22:08 -0800 (PST)
In-Reply-To: <20101116171117.46a13d0a@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, khilman@deeprootsystems.com

Hi Thomas,

> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
> Sent: Tuesday, November 16, 2010 9:41 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; b-cousson@ti.com;
khilman@deeprootsystems.com
> Subject: Re: [PATCH 2/6] OMAP: powerdomain: Infrastructure to put arch
specific code
>
> On Tue, 16 Nov 2010 21:08:02 +0530
> Rajendra Nayak <rnayak@ti.com> wrote:
>
> > +struct pwrdm_functions {
> > +	int	(*pwrdm_set_next_pwrst)(struct powerdomain *pwrdm, u8
pwrst);
> > +	int	(*pwrdm_read_next_pwrst)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_read_pwrst)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_read_prev_pwrst)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_set_logic_retst)(struct powerdomain *pwrdm, u8
pwrst);
> > +	int	(*pwrdm_set_mem_onst)(struct powerdomain *pwrdm, u8 bank,
u8 pwrst);
> > +	int	(*pwrdm_set_mem_retst)(struct powerdomain *pwrdm, u8 bank,
u8 pwrst);
> > +	int	(*pwrdm_read_logic_pwrst)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_read_prev_logic_pwrst)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_read_logic_retst)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_read_mem_pwrst)(struct powerdomain *pwrdm, u8
bank);
> > +	int	(*pwrdm_read_prev_mem_pwrst)(struct powerdomain *pwrdm, u8
bank);
> > +	int	(*pwrdm_read_mem_retst)(struct powerdomain *pwrdm, u8
bank);
> > +	int	(*pwrdm_clear_all_prev_pwrst)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_enable_hdwr_sar)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_disable_hdwr_sar)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
> > +	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
> > +};
>
> It would probably be great to have some short documentation on this
> structure, to detail what are the different operations, what they
> should do, etc.

Sure, I can add some kerneldoc style headers to the structure to better
understand
what these functions should do on each OMAP.

>
> By the way, would pwrdm_operations be more linux-ish than
> pwrdm_functions ?

I agree. I'll do this as well before I post a V2.

Thanks for the review.
Regards,
Rajendra
>
> Thanks,
>
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
