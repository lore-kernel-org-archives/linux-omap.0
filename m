From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC: PATCH] OMAP: hwmod: New API to modify the autoidle bits of
 sysconfig register
Date: Tue, 31 Aug 2010 03:13:23 -0500
Message-ID: <958980504a3ab43f3a7c5d86e968ea67@secure211.sgcpanel.com>
References: <1282823155-18328-1-git-send-email-kishon@ti.com> <878w3o9l6f.fsf@deeprootsystems.com> <4C7C91D8.5030809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50517 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756974Ab0HaINj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 04:13:39 -0400
In-Reply-To: <4C7C91D8.5030809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon <a0393678@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, linux-omap@vger.kernel.org, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On Tue, 31 Aug 2010 10:53:36 +0530, kishon <a0393678@ti.com> wrote:
>      Though driver shouldn't be using hwmod directly, there is no 
> corresponding API in omap_device to do the same. So we are planning to
>      store the omap_hwmod structure in platform_data during 
> arch_initcall (in the callback to omap_hwmod_for_each_by_class). So 
> whenever the
>      AUTOIDLE bits need to be reset or set, we pass the stored 
> omap_hwmod structure to this API. Currently, the functions that needs 
> AUTOIDLE
>      bit to be modified (omap_st_on, omap_st_off) resides in plat-omap.

couldn't your API instead be something like:

int omap_hwmod_set_autoidle(struct device *dev, u8 autoidle)
{
	struct omap_hwmod *oh = dev_to_hwmod(dev);

	if (!oh)
		return -ENODEV;
	[...]

	return 0;
}

-- 
balbi
