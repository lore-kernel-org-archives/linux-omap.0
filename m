From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb: musb: Fix external abort in musb_remove
Date: Thu, 8 Mar 2018 15:18:46 -0600
Message-ID: <20180308211846.GK14921@uda0271908>
References: <20180308204049.29474-1-merlijn@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308204049.29474-1-merlijn@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 08, 2018 at 09:40:47PM +0100, Merlijn Wajer wrote:
> This fixes an oops on unbind / module unload.

Please also mention here that it happens on omap2430 platform.

(omap2430 is the only platform affected by this bug.)

Regards,
-Bin.
