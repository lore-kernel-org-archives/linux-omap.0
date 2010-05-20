From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 6/9] OMAP:GPIO:hwmod: add GPIO hwmods for OMAP3
Date: Thu, 20 May 2010 15:46:39 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5666BBC@dbde02.ent.ti.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
 <1271951720-21714-2-git-send-email-charu@ti.com>
 <1271951720-21714-3-git-send-email-charu@ti.com>
 <1271951720-21714-4-git-send-email-charu@ti.com>
 <1271951720-21714-5-git-send-email-charu@ti.com>
 <1271951720-21714-6-git-send-email-charu@ti.com>
 <1271951720-21714-7-git-send-email-charu@ti.com> <4BF50B3D.3030003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59084 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571Ab0ETKQr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 06:16:47 -0400
In-Reply-To: <4BF50B3D.3030003@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>



> -----Original Message-----
> From: Cousson, Benoit
> Sent: Thursday, May 20, 2010 3:43 PM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com; tony@atomide.com;
> khilman@deeprootsystems.com
> Subject: Re: [PATCH 6/9] OMAP:GPIO:hwmod: add GPIO hwmods for OMAP3
> 
> On 4/22/2010 5:55 PM, Varadarajan, Charulatha wrote:
> > Add hwmod structures for GPIO module on OMAP3
> 
> [snip]
> 
> > +
> > +static struct omap_hwmod omap3xxx_gpio1_hwmod = {
> > +       .name           = "gpio1_hwmod",
> 
> You should remove the "_hwmod" prefix of all the hwmod name in order to
> align with the convention we have on OMAP4.
> It will increase the data size without bringing any extra information.
> 

Yep. Will change the naming convention as followed in OMAP4.

> Thanks,
> Benoit
