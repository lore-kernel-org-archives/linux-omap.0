From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Fri, 19 Mar 2010 21:35:52 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DE0E3DE@dbde02.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
	 <94a0d4531003190451h23ad1a16x994973cdfeb3c83f@mail.gmail.com>
 <94a0d4531003190853y7b6bda0dg6db8ab263bbb8532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50838 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab0CSQGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 12:06:04 -0400
In-Reply-To: <94a0d4531003190853y7b6bda0dg6db8ab263bbb8532@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe 
> Contreras
> Sent: Friday, March 19, 2010 10:54 AM
> To: Guzman Lugo, Fernando
> Cc: linux-omap@vger.kernel.org; Hiroshi DOYU; Ameya Palande; 
> felipe.contreras@nokia.com
> Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
> 
> On Fri, Mar 19, 2010 at 1:51 PM, Felipe Contreras 
> <felipe.contreras@gmail.com> wrote:
> > I tried to rebase this patch on top of the latest head and the 
> > user-space client never gets notified of the MMUFAULT. 
> After manually 
> > killing the process, the DSP is restarted correctly though.
> 
> Strike that. MMUFAULTS are not notified even before this 
> patch... great.
Client app must register for MMUFault/DSPSysError events. Then only
You will receive notifications.

--Shivananda


> 
> --
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 