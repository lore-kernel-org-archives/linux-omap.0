From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/4] initial support for LogicPD's OMAP3 SOM and
 TORPEDO development kits
Date: Wed, 11 Aug 2010 21:49:22 +0300
Message-ID: <20100811184922.GB21778@nokia.com>
References: <20100811172232.GA21391@nokia.com>
 <77A0A4DB5BF2A44283E5522C27234AC6021C82B4@EDPRSRV011.logicpd.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <77A0A4DB5BF2A44283E5522C27234AC6021C82B4@EDPRSRV011.logicpd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>
Cc: "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

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
