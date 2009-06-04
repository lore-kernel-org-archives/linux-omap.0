From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2: Compilation Error on Git tree
 http://www.bat.org/~tomba/git/linux-omap-dss.git
Date: Thu, 04 Jun 2009 09:59:13 +0300
Message-ID: <1244098753.4004.1.camel@tubuntu>
References: <5F744A5A3C131242B81CE5874BD2CFFB34E35EBA@dlee01.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60371 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbZFDG7U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 02:59:20 -0400
In-Reply-To: <5F744A5A3C131242B81CE5874BD2CFFB34E35EBA@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Venkatesh, Subbu" <subbu.wrs@ti.com>
Cc: "Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mande, Nikhil" <nikhil@ti.com>, "Castaneda Gonzalez, Axel" <x0055901@ti.com>, "Miesen, Sharon" <s-miesen@ti.com>

On Wed, 2009-06-03 at 16:07 +0200, ext Venkatesh, Subbu wrote:
> Hi Tomi,
> I did git pull to update my tree, later compiling code for LDP, I am getting compilation error as show below. I see that I am missing declaration of  
>  struct omap_dss_display_config in display.h file, could you please comment on it...

You need to port your LDP changes to newer DSS2 device model. Check how
it's done with OMAP SDP or Beagleboard.

 Tomi


