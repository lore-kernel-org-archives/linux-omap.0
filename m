From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH v2] usb: musb: Fix external abort in musb_remove on
 omap2430
Date: Tue, 13 Mar 2018 15:11:39 -0500
Message-ID: <20180313201139.GN14921@uda0271908>
References: <20180308221949.12054-1-merlijn@wizzup.org>
 <20180309141130.GM14921@uda0271908>
 <b163041c-02d5-56c0-8f46-139b564a7280@wizzup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b163041c-02d5-56c0-8f46-139b564a7280@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: ivo.g.dimitrov.75@gmail.com, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Mar 12, 2018 at 11:30:39PM +0100, Merlijn Wajer wrote:
> Hi Bin,
> 
> On 09/03/18 15:11, Bin Liu wrote:
> > Hi,
> > 
> > On Thu, Mar 08, 2018 at 11:19:48PM +0100, Merlijn Wajer wrote:
> >> This fixes an oops on unbind / module unload (on the musb omap2430
> >> platform).
> >>
> >> musb_remove function now calls musb_platform_exit before disabling
> >> runtime pm.
> >>
> >> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> > 
> > Applied. Thanks.
> 
> Thank you. Is there any chance that this patch and the vbus patch could
> end up in the 4.16-rc series? I was waiting for another rc to see if the
> vbus patch would land, but it didn't land with 4.16-rc5.

Those two patches are already in the upstream tree, hopefully they will
be in the v4.16-rc.

Regards,
-Bin.
