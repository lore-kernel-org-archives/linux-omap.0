From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS porting problems
Date: Fri, 05 Jun 2009 14:51:25 +0300
Message-ID: <1244202685.6502.39.camel@tubuntu>
References: <4A283AF8.5010301@mlbassoc.com>
	 <1244190255.3940.14.camel@tubuntu>  <4A2903E8.7090406@mlbassoc.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53678 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbZFELv3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 07:51:29 -0400
In-Reply-To: <4A2903E8.7090406@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, 2009-06-05 at 13:39 +0200, ext Gary Thomas wrote:
> Tomi Valkeinen wrote:
> > On Thu, 2009-06-04 at 23:22 +0200, ext Gary Thomas wrote:
> >> I'm porting my platform (3530, very similar to LDP) to your tree.
> >>   http://www.bat.org/~tomba/git/linux-omap-dss.git
> >> Since you have complete support for the 3430SDP, I started with
> >> that board file.  I've added my own display (larger Hitachi
> >> screen that is 800x600).  I've run into a few problems:
> >>
> >> * All output to the main frame buffer (/dev/fb0) seems to go to
> >> the very last line of the display.
> > 
> > Difficult to say anything about this. The problem could be in the board
> > file configuration, or in the panel driver. 
> > 
> 
> So the question remains - how do I debug this?  I have a straight
> forward LCD panel, much like what's on LDP or Beagle (the two I
> know about), just a different model with larger size.  I cloned
> the panel description from the sharp_ls and changed the dimensions.

You need to change the panel timings and polarizations etc. also, in the
panel driver. Changing just x and y res does not work.

 Tomi

