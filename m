From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/12] rtc: omap: silence bogus power-up reset message at
 probe
Date: Sun, 12 Oct 2014 20:42:40 +0200
Message-ID: <20141012184240.GA2786@localhost>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-8-git-send-email-johan@kernel.org>
 <20141010180054.GS31348@saruman>
 <20141010180256.GU31348@saruman>
 <20141011102004.GD18988@localhost>
 <20141012005007.GC21128@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141012005007.GC21128@saruman>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 11, 2014 at 07:50:07PM -0500, Felipe Balbi wrote:
> Hi,
>=20
> On Sat, Oct 11, 2014 at 12:20:04PM +0200, Johan Hovold wrote:
> > On Fri, Oct 10, 2014 at 01:02:56PM -0500, Felipe Balbi wrote:
> > > On Fri, Oct 10, 2014 at 01:00:54PM -0500, Felipe Balbi wrote:
> > > > On Thu, Oct 09, 2014 at 09:06:29PM +0200, Johan Hovold wrote:
> > > > > Some legacy RTC IP revisions has a power-up reset flag in the=
 status
> > > > > register that later revisions lack.
> > > > >=20
> > > > > As this flag is always read back as set on later revisions (o=
r is
> > > > > overloaded with a different flag), make sure to only clear th=
e flag and
> > > > > print the info message on legacy platforms.
> > > > >=20
> > > > > Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > >=20
> > > > Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > >=20
> > > oh, btw. This should be done for DT probes too.
> >=20
> > What do you mean? This is for DT probes (of "ti,da830-rtc" and
> > "ti,am3352-rtc"). DT probing of legacy RTC IPs is currently not
> > supported.
> >=20
> > Are you suggesting I should add a new compatible string for that?
>=20
> it seemed to me that you're only passing the new flag through
> platform_device_id table, not DT table. Did I miss something ?

Ah, that's just the way the driver currently encodes the IP revision
differences. The platform_device_id entries are references from
of_device_id data. Should probably clean that up as well.

Thanks again for the review. I'll post a new version when I'm back from
D=FCsseldorf and ELC-E/Plumbers.

Johan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
