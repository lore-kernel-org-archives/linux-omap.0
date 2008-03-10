From: Arun C <arunedarath@mistralsolutions.com>
Subject: RE: Problem with configuring the LCD in VGA mode
Date: Mon, 10 Mar 2008 18:50:10 +0530
Message-ID: <1205155210.3632.29.camel@localhost.localdomain>
References: <1204973168.4869.23.camel@localhost.localdomain>
	 <7EAD1AEEA7621C45899FE99123E124A0017572F9@dbde01.ent.ti.com>
	 <1205145765.3632.23.camel@localhost.localdomain>
	 <7EAD1AEEA7621C45899FE99123E124A0017B15EC@dbde01.ent.ti.com>
Reply-To: arunedarath@mistralsolutions.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway.mistralsoftware.com ([220.227.112.130]:4228 "EHLO
	Mistralsoftware.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750850AbYCJNZG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2008 09:25:06 -0400
Received: from [192.168.13.42] by mistralsolutions.com (MDaemon PRO v9.6.4)
	with ESMTP id 45-md50000008129.msg
	for <linux-omap@vger.kernel.org>; Mon, 10 Mar 2008 18:56:37 +0530
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0017B15EC@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap@vger.kernel.org

On Mon, 2008-03-10 at 18:13 +0530, Syed Mohammed, Khasim wrote:
> > > The FIFO settings needs to be adjusted as well, the difference between
> > upper and lower threshold can be made equal to burst size. And keep the
> > high threshold to 0xff.
> > >
> > This is matching in my case( burst = 16 X 32 , high= 0xFF ,low =0xC0)
> > 
> 
> Which processor are you using? For 2430 case it can be 0xFF and 0xC0, for 3430 the FIFO size extends to 0x3FF and 0x3C0 (default values).
> 
> What is the make of LCD? Have we used this before on any OMAP boards?
> 
> What is the DDR frequency?
> 
> Regards,
> Khasim
> 

I am using 2430 custom board. 

Yes my lcd works fine in QVGA resolution

DDR is at 110Mhz(L3 clock)

The interesting thing is that  IRQ error messages increases with the
pixel clock ie, only lower pixel clocks( 5Mhz ,6 Mhz etc) are seems to
be stable on my board.



Regards,
Arun c 



-------------------------------------------------------DISCLAIMER------------------------------------------------------
The information transmitted herewith is confidential and proprietary information intended only for use by the individual or entity to which it is addressed. If the reader of this message is not the intended recipient, you are hereby notified that any review, retransmission, dissemination, distribution, copying or other use of, or taking of any action in reliance upon this information is strictly prohibited. If you have received this communication in error, please contact the sender and delete the material from your computer.
--------------------------------------------------------------------------------------------------------------------------------

Please do not print this email unless it is absolutely necessary. Spread environmental awareness.


