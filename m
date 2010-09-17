From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 14/14] omap4: Fix bootup crash observed with higher CPU
 clocks
Date: Fri, 17 Sep 2010 14:19:24 +0300
Message-ID: <20100917111924.GU26474@legolas.emea.dhcp.ti.com>
References: <1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-13-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-14-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-15-git-send-email-santosh.shilimkar@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C014F13A77C@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD307C7B@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C014F13A782@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD307CA7@dbde02.ent.ti.com>
 <20100917104133.GP26474@legolas.emea.dhcp.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD307D21@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49047 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0IQLTz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 07:19:55 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307D21@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

On Fri, Sep 17, 2010 at 06:17:47AM -0500, Shilimkar, Santosh wrote:
>On OMAP4 specifically, the wait IDLEST support isn't there in the
>clock framework.  This is taken care now in hwmod framework. With
>that we see that we don't need this delay anymore.
>
>The delay change is there for some time. May be there were issue
>with wait IDLEST.

ok, I see.

Kevin, any plans to remove this hack ?

-- 
balbi
