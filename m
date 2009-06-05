From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS porting problems
Date: Fri, 05 Jun 2009 11:24:15 +0300
Message-ID: <1244190255.3940.14.camel@tubuntu>
References: <4A283AF8.5010301@mlbassoc.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19657 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758409AbZFEIYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 04:24:32 -0400
In-Reply-To: <4A283AF8.5010301@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2009-06-04 at 23:22 +0200, ext Gary Thomas wrote:
> I'm porting my platform (3530, very similar to LDP) to your tree.
>   http://www.bat.org/~tomba/git/linux-omap-dss.git
> Since you have complete support for the 3430SDP, I started with
> that board file.  I've added my own display (larger Hitachi
> screen that is 800x600).  I've run into a few problems:
> 
> * All output to the main frame buffer (/dev/fb0) seems to go to
> the very last line of the display.

Difficult to say anything about this. The problem could be in the board
file configuration, or in the panel driver. 

> 
> * The documentation (Documentation/arm/OMAP/DSS) does not seem
> to match what's in sysfs.  In particular, there are no "horizontal"
> or "vertical" fields in the displayN tree.  This makes the examples
> of how to clone, etc, not work.

Thanks, I pushed a fix for the documentation.

 Tomi


