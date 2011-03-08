From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 5/9] OMAP4 : DSS2 : HDMI: HDMI driver header file
 addition
Date: Tue, 8 Mar 2011 10:24:57 +0200
Message-ID: <1299572697.2401.14.camel@deskari>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
	 <1299224907-11354-6-git-send-email-mythripk@ti.com>
	 <1299491185.2281.144.camel@deskari>
	 <AANLkTinLWp6T86ah7b=2-tYtNaya5F38e6e1BSmF-Qfh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50137 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab1CHIZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 03:25:00 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p288OxfX008293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 02:24:59 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p288Ox06024770
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 02:24:59 -0600 (CST)
In-Reply-To: <AANLkTinLWp6T86ah7b=2-tYtNaya5F38e6e1BSmF-Qfh@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-08 at 02:17 -0600, K, Mythri P wrote:
> Hi Tomi,
> 
> On Mon, Mar 7, 2011 at 3:16 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Fri, 2011-03-04 at 01:48 -0600, K, Mythri P wrote:
> >> Adding the hdmi interface driver header file (hdmi.h) to the dss driver.
> >> Register and timing declaration to be used by the corresponding c file
> >> is added in this file.
> >
> > The subject and description are wrong. Always before sending patches do
> > a quick sanity check, by check the subjects, looking at the stats in the
> > intro letter, etc.

<snip>

> >> +        * SW HACK : DDC needs time to stablize else it sometimes reads 0 values
> >> +        * or right shifted values.
> >> +        */
> >> +       usleep_range(800, 1000);
> >
> > This is still unclear. Is it an OMAP HW problem? OMAP HW feature? A
> > feature in HDMI TVs? A HDMI spec delay? Or unknown reason?
> >
> there is an internal DDC (i2c bus) , without this delay I have
> sometimes seen that while reading EDID
> we sometimes (Not always and only with some TV's , even with a
> particular TV it is not consistent)
> read a shifted value or EDID value is 0. I can clarify with the h/w
> team , but  can we add this as a s/w hack for time being?

Sure, I have nothing against this work-around as such. I just want it to
be clearly described in the comment. The comment should explain as much
as possible about the hack/workaround, because if the problem is not
described in the TRM/errata, the comment is the only place where the
reader can get information about it.

 Tomi


