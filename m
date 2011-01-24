From: zzz <cooper.zp@gmail.com>
Subject: Re: Enabling TPS65950 / TWL4030 Real-time clock functions
Date: Mon, 24 Jan 2011 02:30:29 +0000 (UTC)
Message-ID: <loom.20110124T032239-959@post.gmane.org>
References: <4C8A2DCE-F2C2-419C-AD4A-E78BB796BCB8@mac.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF2375@dbde02.ent.ti.com> <B78DF7E1-501F-43A5-AF3F-91E7E9AED466@mac.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF260A@dbde02.ent.ti.com> <DF380C12-AA52-49AB-ACE6-EE084FAFFEB4@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46383 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab1AXDPF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Jan 2011 22:15:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1PhCtT-00022w-Um
	for linux-omap@vger.kernel.org; Mon, 24 Jan 2011 04:15:04 +0100
Received: from smtp.tnl-group.co.nz ([210.55.22.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 04:15:03 +0100
Received: from cooper.zp by smtp.tnl-group.co.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 04:15:03 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Elvis Dowson <elvis.dowson <at> mac.com> writes:

> 
> Hi Santosh,
> 
> On Aug 3, 2009, at 9:46 AM, Shilimkar, Santosh wrote:
> 
> >>
> > Not sure whether I got your question correctly. The software driver  
> > you already know. Are you asking where to plug the backup battery on  
> > hardware pins?
> > I don't have Gumstix Overo hardware but if above is your question  
> > and schematics are available then it can be traced.
> 
> The TPS65950 is on the gumstix overo motherboard, and no schematics  
> are available for that part. I'll take a look at the TPS65950  
> datasheet and see if any of the pins are available on the gumstix  
> Palo43 expansion board, for the battery. I do recall them saying that  
> battery functions were disabled for safety reasons.
> 
> In any case, thanks for your help in pointing me to the correct rtc  
> driver!
> 
> Best regards,
> 
> Elvis
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


hi there,

if you measure the pin 'Vbackup' after power on the overo, you will see the
voltage is 3.1V. That means battery backup pin has been enabled in the new
kernel. here is the link which shows how to use coin cell battery to support the
internal real time clock.

http://studyard.blogspot.com/2010/12/battery-backup-for-on-overo-board-rtc.html

cheers

