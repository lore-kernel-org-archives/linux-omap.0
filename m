From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/4] USB: TWL6025 allow different regulator name
Date: Wed, 27 Apr 2011 13:45:44 +0300
Message-ID: <20110427104542.GZ13227@legolas.emea.dhcp.ti.com>
References: <1303897191-14792-1-git-send-email-gg@slimlogic.co.uk>
 <1303897191-14792-5-git-send-email-gg@slimlogic.co.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1303897191-14792-5-git-send-email-gg@slimlogic.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, balbi@ti.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Apr 27, 2011 at 10:39:51AM +0100, Graeme Gregory wrote:
> The twl6025 uses a different regulator for USB than the 6030 so select
> the correct regulator name depending on the subclass of device.
> 
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>

I don't see the point of this patch. It's just a string. Use the same
name and add a comment saying that on datasheet/TRM/documentation the
name LDO is actually referred to as LDOUSB. It's the same functionality
anyway.

-- 
balbi
