From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/7] omap4: Temporary fix silicon version detection
Date: Thu, 9 Sep 2010 15:07:46 +0300
Message-ID: <20100909120746.GB17000@legolas.emea.dhcp.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
 <20100909114255.GK21060@legolas.emea.dhcp.ti.com>
 <4C88C940.6070000@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D3A37@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55237 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705Ab0IIMIg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Sep 2010 08:08:36 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D3A37@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Santosh,

On Thu, Sep 09, 2010 at 07:02:46AM -0500, Shilimkar, Santosh wrote:
>Felipe is suggesting not to add this support where as you want to
>have this support.
>
>Sorry if I haven't understood the comment. Care to clarify

no, I suggested not to revert :-) So, just change the comment saying why
you need that extra check and remove the "this patch should be reverted
later" part :-)

-- 
balbi
