From: <me@felipebalbi.com>
Subject: RE: [PATCH 2/2] arm: omap: ehci: avoid compiler error with touchbook
Date: Thu, 04 Mar 2010 13:15:27 -0600
Message-ID: <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
References: <20100304074434.GI15954@nokia.com> <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57555 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235Ab0CDTPe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 14:15:34 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi,

On Thu, 4 Mar 2010 18:33:15 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
wrote:
>> This patch fixes that for the ehci_hdc_omap_platform_data.
>> 
> 
> should be ehci_hcd_omap_platform_data ;)
> 
> BTW, this breaks compile for omap3-evm.
> Could you please build with omap3_defconfig and check.

will do first thing tomorrow :-)

thanks

-- 
balbi
