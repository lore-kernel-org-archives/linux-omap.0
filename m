From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: DSS2: How to test TV and LCD output simulatenously
Date: Tue, 02 Jun 2009 05:52:00 -0600
Message-ID: <4A251260.7070800@mlbassoc.com>
References: <5F744A5A3C131242B81CE5874BD2CFFB34E35EAC@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:1373 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760207AbZFBLwC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 07:52:02 -0400
In-Reply-To: <5F744A5A3C131242B81CE5874BD2CFFB34E35EAC@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Venkatesh, Subbu" <subbu.wrs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shah, Hardik" <hardik.shah@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>

Venkatesh, Subbu wrote:
> Hi,
> I have DSS2 ported on LDP board, I could manage to get output display on TV and LCD interface individually, also tested some of the features like Rotation and Mirroring, they worked with out any problem.

What does "DSS2 ported on LDP board" mean?  What source tree/branch did you use?

> Now I am trying to get output both on TV and LCD simultaneously, 
> 
> I was not successful with my approach that I tried, like
> 
> 1. Boot the kernel with the default LCD display
> 2. Then I enabled ntsc timings for TV, as PAL do not work on it. 
>     #echo ntsc > /sys/devices/platform/omapdss/display1/timings
> 3. Enabled TV
>   # echo 1 > /sys/devices/platform/omapdss/display1/enable
> and did the common fb test....
> But it did not seem to work.
> Its nice if someone has different working approach or can suggest me where I am going wrong in the above steps.

Is this stuff documented somewhere?  Like the difference
between DSS1 and DSS2?  How the various layers and overlays
are supposed to work?  What about the camera interface?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
