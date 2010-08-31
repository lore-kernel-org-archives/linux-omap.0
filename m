From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [RFC PATCH 00/20] HWMOD Adaptation for DSS
Date: Tue, 31 Aug 2010 18:24:36 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703114AA763@dbde02.ent.ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <4C72EAC7.500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48023 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757337Ab0HaM6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 08:58:07 -0400
In-Reply-To: <4C72EAC7.500@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>

 

> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Tuesday, August 24, 2010 3:10 AM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; tomi.valkeinen@nokia.com; 
> paul@pwsan.com; Hilman, Kevin
> Subject: Re: [RFC PATCH 00/20] HWMOD Adaptation for DSS
> 
> On 8/23/2010 5:57 PM, Guruswamy, Senthilvadivu wrote:
> > From: Senthilvadivu Guruswamy<svadivu@ti.com>
> >
[...]
> > 2) Usage of regulators by different drivers needs to implemented.
> > For Eg: Regulator used by VENC is moved to venc driver.  
> But vdda_dac would be
> > needed by DPI and DSI as well.  Need to verify if a patch 
> like this would work.
> > /* VPLL2 for digital video outputs */
> > static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
> > 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> > +	REGULATOR_SUPPLY("vdds_dsi", "dss_dsi1"),
> 
> You can add any consumer you want for a given regulator 
> supply as soon 
> as you have a valid dev or dev_name.
[Senthil] Thanks.  I will try this out.
> 
> > };
> > 3) SYSCONFIG of each of the dss HW IP has to be removed 
> from the driver.
> > HWMOD framework is supposed to take care of it.  This 
> change would be done in
> > the next version of the patch series.
> > 4) OMAP2 HWMOD database is yet to be generated.
> > 5) Number of DSS HW IPs in a silicon are hardcoded in devices.c.
> > It is not evident from HWMOD database.  Need to find a 
> cleaner way to register for OMAP2,3,4.
> 
> What does that mean exactly? Could you elaborate?
[Senthil] From HWMOD database, it is not possible to find out how many of the 
DSS related HW Ips are present.  Say in OMAP3 one DSI is present and HDMI is not.
In OMAP4 2 DSI is present and HDMI is.
So in devices.c if I have to do a omaphwmod_lookup(), I have to hardcode the
lookup names for omap3 and omap4 explicitly.

> 
> > 6) Module support for omapdss driver as per current DSS2 design.
> 
> What about the usage of clock framework, or the management of DSS 
> features, we already discussed?
> What about OMAP4?
> 
[Senthil]  DSS internal clocks generated from internal DPLLs are to planned to be 
in separate patch series.  
The DSS_FEATURES like number of pipelines in omap3/omap4, tiler/vrfb support,
are being posted as separate patch series by Taneja Archit.
> Benoit
> 
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 