From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Problem with configuring the LCD in VGA mode
Date: Mon, 10 Mar 2008 20:46:27 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0017B162D@dbde01.ent.ti.com>
References: <1204973168.4869.23.camel@localhost.localdomain> <7EAD1AEEA7621C45899FE99123E124A0017572F9@dbde01.ent.ti.com> <1205145765.3632.23.camel@localhost.localdomain> <7EAD1AEEA7621C45899FE99123E124A0017B15EC@dbde01.ent.ti.com> <1205155210.3632.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56181 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbYCJPRi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2008 11:17:38 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1205155210.3632.29.camel@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arunedarath@mistralsolutions.com, linux-omap@vger.kernel.org



> > Which processor are you using? For 2430 case it can be 0xFF and 0xC0,
> for 3430 the FIFO size extends to 0x3FF and 0x3C0 (default values).
> >
> > What is the make of LCD? Have we used this before on any OMAP boards?
> >
> > What is the DDR frequency?
> >
> > Regards,
> > Khasim
> >
> 
> I am using 2430 custom board.
> 
> Yes my lcd works fine in QVGA resolution
> 
> DDR is at 110Mhz(L3 clock)
> 
> The interesting thing is that  IRQ error messages increases with the
> pixel clock ie, only lower pixel clocks( 5Mhz ,6 Mhz etc) are seems to
> be stable on my board.
> 
> 
> 
I have seen issues in using 640x480 resolution for TVOUT on 2430 processor, Generally it is adviced to use VRFB in rotation 0 mode to get good DDR bandwidth. This helps in overcoming the flicker due to bandwidth issues.

You can refer to TI's code for DDR usage. But the issue is it uses consistent memory of size (2048 * bpp * height).

Regards,
Khasim
