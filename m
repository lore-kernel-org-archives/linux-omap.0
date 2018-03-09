From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH v2] usb: musb: Fix external abort in musb_remove on
 omap2430
Date: Fri, 9 Mar 2018 08:11:30 -0600
Message-ID: <20180309141130.GM14921@uda0271908>
References: <20180308221949.12054-1-merlijn@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308221949.12054-1-merlijn@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Mar 08, 2018 at 11:19:48PM +0100, Merlijn Wajer wrote:
> This fixes an oops on unbind / module unload (on the musb omap2430
> platform).
> 
> musb_remove function now calls musb_platform_exit before disabling
> runtime pm.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>

Applied. Thanks.

Regards,
-Bin.
