From: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Wed, 15 Feb 2012 10:43:57 +0100
Message-ID: <20120215094357.GA24331@lit.local.igalia.com>
References: <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
 <20120210180015.GF4141@mwanda>
 <CAMP44s2HUApzGH_rExqS1bOnq0nHj4Y0vEojZN4vXNPAxC1oKA@mail.gmail.com>
 <20120210203537.GG4141@mwanda>
 <CAMP44s2OEvn7RVpwJ2zkdkxrzwrbD3+PFQbzYiOG-hvnrc4UhA@mail.gmail.com>
 <CAB-zwWhSoiMNVGQ=u=6-Umte-AaP9Qih8QMJFTyk8pjXaXysLg@mail.gmail.com>
 <CAMP44s1yY8N4z_uF1b=DKdEMGXORJUhkytEpbK2AoCSTbmiJNw@mail.gmail.com>
 <CAB-zwWjtPcdwAfQGW6iB-pLWVuM1S0YJS7ioVv_voYZH2wNM9Q@mail.gmail.com>
 <CAMP44s3sNH2qRsMHxgCbemefVye=z5E8XFLnSPvUtgA94SoV=A@mail.gmail.com>
 <CAB-zwWjkCqehNAKp=gFt6Zq=XR+Mscz67oGnfY2sPjgvgpvNFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.mundo-r.com ([212.51.32.151]:56011 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631Ab2BOJoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 04:44:16 -0500
Content-Disposition: inline
In-Reply-To: <CAB-zwWjkCqehNAKp=gFt6Zq=XR+Mscz67oGnfY2sPjgvgpvNFQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, "Justin P. Mattock" <justinmattock@gmail.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <gregkh@linuxfoundation.org>

On Tue, Feb 14, 2012 at 08:56:11PM -0600, Ramirez Luna, Omar wrote:
> On Tue, Feb 14, 2012 at 10:23 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >> When that case is applicable, we should first modify the loader code
> >> or prepare the baseimages to be common so we can get rid of specific
> >> loaders and just dump them into memory.
> >
> > I'd say the less workarounds, the better.
> 
> If there are ever more base images compatible with the dsp, I would
> say that unifying them into a common format to be dumped in memory
> isn't a workaround, and in that process we can get rid of the custom
> loader code.

Yes! please! and use Ohad's rproc thingy.

What would be the steps to unify that common format? I guess we will depend on
TI for that... Do we?

vmjl

> 
> >> WDT could be detected by prepending common symbols into the baseimages
> >> or just making the new images to treat all peripherals as resources,
> >> that is, the new baseimg should actually request the wdt3 as any other
> >> clock.
> >
> > I see, but if wdt3 is requested as another clock, the Linux ARM side
> > would still need to know how to threat the WDT.
> 
> Tidspbridge does know how to treat other clock request from dsp (gpt,
> mcbsp), it would be a matter of adding the logic in the arm side for
> any dsp image that is able to do it, however this doesn't apply to the
> current (latest) base image since it assumes the wdt3 is always
> controlled by tidspbridge.
> 
> Regards,
> 
> Omar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
