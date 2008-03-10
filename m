From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: Problem with configuring the LCD in VGA mode
Date: Mon, 10 Mar 2008 18:13:28 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0017B15EC@dbde01.ent.ti.com>
References: <1204973168.4869.23.camel@localhost.localdomain> <7EAD1AEEA7621C45899FE99123E124A0017572F9@dbde01.ent.ti.com> <1205145765.3632.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:35076 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbYCJMoi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2008 08:44:38 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1205145765.3632.23.camel@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arunedarath@mistralsolutions.com, linux-omap@vger.kernel.org


> > The FIFO settings needs to be adjusted as well, the difference between
> upper and lower threshold can be made equal to burst size. And keep the
> high threshold to 0xff.
> >
> This is matching in my case( burst = 16 X 32 , high= 0xFF ,low =0xC0)
> 

Which processor are you using? For 2430 case it can be 0xFF and 0xC0, for 3430 the FIFO size extends to 0x3FF and 0x3C0 (default values).

What is the make of LCD? Have we used this before on any OMAP boards?

What is the DDR frequency?

Regards,
Khasim
