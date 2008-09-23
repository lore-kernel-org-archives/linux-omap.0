From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: MMC issues with 2.6.27-rc7
Date: Tue, 23 Sep 2008 05:31:06 +0300
Message-ID: <20080923023103.GF10156@frodo>
References: <94a0d4530809221402l79abae77re8b062974e1af4a3@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37507 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbYIWCb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 22:31:27 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530809221402l79abae77re8b062974e1af4a3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tue, Sep 23, 2008 at 12:02:51AM +0300, Felipe Contreras wrote:
> Hi,
> 
> I just moved to 2.6.27-rc7 from rc6 and I'm having a lot of issues with MMC.

Which board is that ? I suppose it's a beagle with omap_hsmmc.c ?

Could you git bisect and try to narrow down the patch that broke it ?

-- 
balbi
