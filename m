From: Felipe Balbi <balbi@ti.com>
Subject: Re: [Patch v5] AM35xx: Craneboard: Add USB EHCI support
Date: Tue, 21 Dec 2010 08:58:09 +0200
Message-ID: <20101221065809.GB2921@legolas.emea.dhcp.ti.com>
References: <[PATCH]AM35xx-Craneboard-Add-USB-EHCI-support>
 <1292850523-14583-1-git-send-email-srinath@mistralsolutions.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1292850523-14583-1-git-send-email-srinath@mistralsolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srinath@mistralsolutions.com
Cc: linux-omap@vger.kernel.org, jdk@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com, sshtylyov@mvista.com, manjugk@ti.com, babli@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 20, 2010 at 06:38:43PM +0530, srinath@mistralsolutions.com wrote:
>From: Srinath <srinath@mistralsolutions.com>
>
>AM3517/05 Craneboard has one EHCI interface on board using port1.
>
>GPIO35 is used as power enable.
>GPIO38 is used as port1 PHY reset.
>
>History:
>http://marc.info/?l=linux-omap&w=2&r=1&s=Craneboard%253A%2BAdd%2BUSB%2BEHCI%2Bsupport&q=b
>
>Signed-off-by: Srinath <srinath@mistralsolutions.com>

Tony, do you want to make a pull request for you ? I guess this would
only go on next merge window.

If you want to take yourself, here's my acked-by:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
