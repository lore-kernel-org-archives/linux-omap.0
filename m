From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2: How to test TV and LCD output simulatenously
Date: Tue, 02 Jun 2009 14:57:08 +0300
Message-ID: <1243943829.24975.13.camel@tubuntu>
References: <5F744A5A3C131242B81CE5874BD2CFFB34E35EAC@dlee01.ent.ti.com>
	 <4A251260.7070800@mlbassoc.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57838 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbZFBL5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 07:57:24 -0400
In-Reply-To: <4A251260.7070800@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: "Venkatesh, Subbu" <subbu.wrs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shah, Hardik" <hardik.shah@ti.com>

Hi,

On Tue, 2009-06-02 at 13:52 +0200, ext Gary Thomas wrote:
> Venkatesh, Subbu wrote:
> > Hi,
> > I have DSS2 ported on LDP board, I could manage to get output display on TV and LCD interface individually, also tested some of the features like Rotation and Mirroring, they worked with out any problem.
> 
> What does "DSS2 ported on LDP board" mean?  What source tree/branch did you use?

He was using my DSS2 tree from
http://www.bat.org/~tomba/git/linux-omap-dss.git (or some older version
of it).

> 
> > Now I am trying to get output both on TV and LCD simultaneously, 
> > 
> > I was not successful with my approach that I tried, like
> > 
> > 1. Boot the kernel with the default LCD display
> > 2. Then I enabled ntsc timings for TV, as PAL do not work on it. 
> >     #echo ntsc > /sys/devices/platform/omapdss/display1/timings
> > 3. Enabled TV
> >   # echo 1 > /sys/devices/platform/omapdss/display1/enable
> > and did the common fb test....
> > But it did not seem to work.
> > Its nice if someone has different working approach or can suggest me where I am going wrong in the above steps.
> 
> Is this stuff documented somewhere?  Like the difference
> between DSS1 and DSS2?  How the various layers and overlays
> are supposed to work?  What about the camera interface?

It's documented in DSS2 documentation, Documentation/arm/OMAP/DSS. Of
course knowledge of OMAP's display subsystem is required, and that
information can be found from the OMAP TRM.

I have no idea about the camera, it has nothing to do with DSS.

 Tomi


