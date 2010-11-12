From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 01/14] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Thu, 11 Nov 2010 16:07:41 -0800
Message-ID: <878w0zs8tu.fsf@deeprootsystems.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
	<1288366708-32302-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48709 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab0KLAHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 19:07:45 -0500
Received: by yxt33 with SMTP id 33so97984yxt.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Nov 2010 16:07:44 -0800 (PST)
In-Reply-To: <1288366708-32302-2-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Fri, 29 Oct 2010 21:08:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

[...]

> +/**
>   * omap_vdd_info - Per Voltage Domain info
>   *
>   * @volt_data		: voltage table having the distinct voltages supported
> @@ -95,9 +112,13 @@ struct vp_reg_val {
>   *			  vp registers
>   * @voltdm		: pointer to the voltage domain structure
>   * @debug_dir		: debug directory for this voltage domain.
> + * @user_lock		: the lock to be used by the plist user_list
> + * @user_list		: the list head maintaining the various users.
> + * @scaling_mutex    : the dvfs muutex.
                                   ^^^^^^

hmmmm...  muutex,  that must be a Finnish mutex. ;)

Kevin
