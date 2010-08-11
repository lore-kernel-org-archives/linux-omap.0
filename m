From: "Jacob Tanenbaum" <Jacob.Tanenbaum@logicpd.com>
Subject: RE: [PATCH 1/4] initial support for LogicPD's OMAP3 SOM and TORPEDO development kits
Date: Wed, 11 Aug 2010 13:51:22 -0500
Message-ID: <77A0A4DB5BF2A44283E5522C27234AC6021C82CB@EDPRSRV011.logicpd.com>
References: <20100811184922.GB21778@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20100811184922.GB21778@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Valid point we will remove the ifdefs

-----Original Message-----
From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
Sent: Wednesday, August 11, 2010 2:49 PM
To: Jacob Tanenbaum
Cc: Balbi Felipe (Nokia-MS/Helsinki); linux@arm.linux.org.uk;
linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
rmk@arm.linux.org.uk; tony@atomide.com
Subject: Re: [PATCH 1/4] initial support for LogicPD's OMAP3 SOM and
TORPEDO development kits

Hi,

On Wed, Aug 11, 2010 at 08:45:22PM +0200, ext Jacob Tanenbaum wrote:
>No one else uses the ifdef but we were told from an earlier submission
>we should because if both boards are disabled in the .config it would
>inform the user on bootup

What do you mean ? If these boards are't enabled on .config then this 
board-file won't even get added to the binary so those machine ids won't

be available, right ?

-- 
balbi

DefectiveByDesign.org
