From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/9 v3] usb: musb: Using omap_device_build for musb
 device registration
Date: Thu, 23 Sep 2010 09:51:41 +0300
Message-ID: <20100923065141.GH2563@legolas.emea.dhcp.ti.com>
References: <1285201750-26438-1-git-send-email-hemahk@ti.com>
 <20100923062044.GB2563@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D978@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56217 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753874Ab0IWGvr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 02:51:47 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D978@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Thu, Sep 23, 2010 at 01:46:51AM -0500, Kalliguddi, Hema wrote:
>Any driver which uses the device->dma_mask will have to it after the
>device build.

yeah, let's see what Kevin, Paul and Tony say about it.

-- 
balbi
