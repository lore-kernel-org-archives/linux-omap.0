From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/12] rtc: omap: fixes and power-off feature
Date: Fri, 24 Oct 2014 09:58:37 +0200
Message-ID: <20141024075837.GE28808@localhost>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <20141015165452.GB15770@saruman>
 <20141015170628.GA13824@localhost>
 <20141015170832.GD15770@saruman>
 <20141022102305.GM2113@localhost>
 <20141023185513.GD21407@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141023185513.GD21407@saruman>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 23, 2014 at 01:55:13PM -0500, Felipe Balbi wrote:
> On Wed, Oct 22, 2014 at 12:23:05PM +0200, Johan Hovold wrote:
> > On Wed, Oct 15, 2014 at 12:08:32PM -0500, Felipe Balbi wrote:
> > > On Wed, Oct 15, 2014 at 07:06:28PM +0200, Johan Hovold wrote:
> > > > On Wed, Oct 15, 2014 at 11:55:02AM -0500, Felipe Balbi wrote:
> > 
> > > > > BTW, how do you test this series ?
> > > > 
> > > > Set a 30 second wakealarm using the sysfs attribute of the rtc class
> > > > device and power off the BBB:
> > > > 
> > > > 	echo +30 >wakealarm; poweroff
> > > 
> > > sweet!!!! It worked just fine :-)
> > 
> > :)
> > 
> > > Too bad there's yet another DRM bug:
> > > 
> > > [  271.150158] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
> > > [  271.150158] 
> > > [  271.159725] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 3.17.0-08392-g7fe2269-dirty #326
> > > [  271.168567] [<c00175a4>] (unwind_backtrace) from [<c00132f0>] (show_stack+0x20/0x24)
> > > [  271.176668] [<c00132f0>] (show_stack) from [<c06573a4>] (dump_stack+0x8c/0xa4)
> > > [  271.184215] [<c06573a4>] (dump_stack) from [<c0654f10>] (panic+0xa0/0x220)
> > > [  271.191405] [<c0654f10>] (panic) from [<c0049e54>] (do_exit+0x974/0x9d0)
> > > [  271.198410] [<c0049e54>] (do_exit) from [<c0067694>] (SyS_reboot+0x14c/0x1e8)
> > > [  271.205870] [<c0067694>] (SyS_reboot) from [<c000f080>] (ret_fast_syscall+0x0/0x48)
> > > [  271.214023] drm_kms_helper: panic occurred, switching back to text console
> > > [  271.221312] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
> > > 
> > > In any case, board still powered up after 30 seconds(-ish). So this gets
> > > a:
> > > 
> > > Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > 
> > Thanks for testing. I didn't include your Tested-by in v2 due to the
> > invasiveness of the new device-abstraction patch. Still works fine on BBB
> > here though.
> 
> alright, if I have time I'll test again, but not this week.

Great, thanks! I believe Andrew usually adds any late Reviewed-by or
Tested-by tags while the patches live in his tree.

Johan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
