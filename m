From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: pandaboard can't reboot on 2.6.38-rc2?
Date: Mon, 11 Apr 2011 21:37:49 +0530
Message-ID: <20110411160749.GA7525@avinash-laptop>
References: <BANLkTikjyaA4mL-eWOcPse2T7NC2rbCfkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55599 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752461Ab1DKQIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 12:08:06 -0400
Received: by mail-yw0-f45.google.com with SMTP id 41so2859542ywl.18
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 09:08:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikjyaA4mL-eWOcPse2T7NC2rbCfkg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: linux-omap@vger.kernel.org

On Mon, Apr 11, 2011 at 06:13:06PM +0800, Bob Liu wrote:
> Hi, folks
> 
> I am using pandaboard and compiled a 2.6.38-rc2 kernel for it.
> Everything works fine except that it can't reboot.
> 
> #reboot
> #
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system reboot
> [  120.742370] Restarting system.
> 
> Then hanged...
> 
> Has anyone seen similar problem?

I have seen a similar issue on OMAP4 SDP. It wasn't rebooting. I added
few prints to see where its failing. My observation is , 

In arm_machine_restart, it is not coming out of 'setup_mm_for_reboot'.
Not sure why.

        setup_mm_for_reboot(mode);
	/* Clean and invalidate caches */
	flush_cache_all();

Thanks ,

- Avinash


> 
> Thanks
> -- 
> Regards,
> --Bob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
