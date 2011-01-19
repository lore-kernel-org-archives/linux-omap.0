From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [HELP-OMAP-SERAIL] beagleboard-xM can't boot up after update
 to kernel-2.6.37
Date: Wed, 19 Jan 2011 17:17:54 +0530
Message-ID: <20110119114754.GB17681@m-desktop>
References: <AANLkTikFb7WTfCOD_GUnA=RZ22Q5_5QSDRTbcoLMtdYM@mail.gmail.com>
 <20110119110607.GA30211@legolas.emea.dhcp.ti.com>
 <4D36C5F7.4030605@embtoolkit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46809 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753636Ab1ASLso (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 06:48:44 -0500
Received: by gwaa18 with SMTP id a18so238873gwa.24
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 03:48:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D36C5F7.4030605@embtoolkit.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abdoulaye Walsimou GAYE <awg@embtoolkit.org>
Cc: balbi@ti.com, Bob Liu <lliubbo@gmail.com>, linux-omap@vger.kernel.org

On Wed, Jan 19, 2011 at 12:07:35PM +0100, Abdoulaye Walsimou GAYE wrote:
> On 01/19/2011 12:06 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Wed, Jan 19, 2011 at 06:57:33PM +0800, Bob Liu wrote:
> >   
> >> Any ideas?
> >>     
> > s/console=ttyS2,115200n8/console=ttyO2,115200n8/
> >
> > on your CMDLINE.
> >
> >   
> 
> Hi,
> BTW what is major and minor number of ttyO devices?
> This is not documented in devices.txt

There is no need to create this device file manually. It creates
automatically during bootup in tty_io.c

-Manjunath
