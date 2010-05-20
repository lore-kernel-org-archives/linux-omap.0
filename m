From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 6/9] OMAP:GPIO:hwmod: add GPIO hwmods for OMAP3
Date: Thu, 20 May 2010 12:13:17 +0200
Message-ID: <4BF50B3D.3030003@ti.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com> <1271951720-21714-2-git-send-email-charu@ti.com> <1271951720-21714-3-git-send-email-charu@ti.com> <1271951720-21714-4-git-send-email-charu@ti.com> <1271951720-21714-5-git-send-email-charu@ti.com> <1271951720-21714-6-git-send-email-charu@ti.com> <1271951720-21714-7-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55809 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424Ab0ETKNY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 06:13:24 -0400
In-Reply-To: <1271951720-21714-7-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On 4/22/2010 5:55 PM, Varadarajan, Charulatha wrote:
> Add hwmod structures for GPIO module on OMAP3

[snip]

> +
> +static struct omap_hwmod omap3xxx_gpio1_hwmod = {
> +       .name           = "gpio1_hwmod",

You should remove the "_hwmod" prefix of all the hwmod name in order to 
align with the convention we have on OMAP4.
It will increase the data size without bringing any extra information.

Thanks,
Benoit
