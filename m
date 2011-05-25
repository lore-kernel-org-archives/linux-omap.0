From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: RE: [PATCH v3] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Wed, 25 May 2011 18:45:21 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370A4D88F@dbde02.ent.ti.com>
References: <1304328111-15999-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1105051548210.30136@utopia.booyaka.com>
 <20110509124842.GA25211@avinash-laptop>
 <alpine.DEB.2.00.1105181021590.4550@utopia.booyaka.com>
 <20110518162542.GB3026@avinash-laptop>
 <FCCFB4CDC6E5564B9182F639FC3560870370A4D887@dbde02.ent.ti.com>,<20110524190718.GA6899@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44431 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337Ab1EYNPh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 May 2011 09:15:37 -0400
In-Reply-To: <20110524190718.GA6899@avinash-laptop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahadeva, Avinash" <avinashhm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>


>On Thu, May 19, 2011 at 06:05:21PM +0530, Koyamangalath, Abhilash wrote:
>
> > I have tried the patch on am37x evm and the i2c soft-reset time-out issue doesn't
> > seem to go off for me. Previously I used to get a log  :
> >
> > [    0.000000] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
> > [    0.000000] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
> > [    0.000000] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
> >
> > And now I get :
> > [    0.000000] omap_i2c_reset: i2c1: softreset failed (waited 10000 usec)
> > [    0.000000] omap_i2c_reset: i2c2: softreset failed (waited 10000 usec)
> > [    0.000000] omap_i2c_reset: i2c3: softreset failed (waited 10000 usec)
> >
> > So the function where this failure happens seems to be the only thing that has changed.
> > I've tried this patch on top of the recent PSP 04.02.00.07 release.
> > What am I missing?
>
>Abhilash ,
>
>I am not sure what is PSP 04.02.00.07 release. But you should make sure
>that the hwmod structures in omap_hwmod_3xxx_data.c should have the
>16_bit flags.
>
>Below is just a snippet in P.S.. There is already a patch submitted by
>andy green for this. Not sure, if it is merged.
>
>With this and the posted v3 patch, you should not see timeouts. Or else
>you have some other problem.
>
>thanks ,
>
>- Avinash
>
>PS:
>
> static struct omap_hwmod omap3xxx_i2c1_hwmod = {
>        .name           = "i2c1",
>+       .flags          = HWMOD_16BIT_REG,

Yes Avinash, that works , 
thanks.
>
>
> >
> > thanks,
> > Abhilash
> >
> >
> >
> > > >
> > > >
> > > > - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
