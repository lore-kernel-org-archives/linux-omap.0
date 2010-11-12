From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCHv3 2/4] OMAP1: Serial: remobe magic from MDR1 register
Date: Fri, 12 Nov 2010 18:02:40 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC24F026@dbde02.ent.ti.com>
References: <1289553702-28041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1289553702-28041-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50013 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625Ab0KLMcq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Nov 2010 07:32:46 -0500
In-Reply-To: <1289553702-28041-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Emeltchenko Andrei
> Sent: Friday, November 12, 2010 2:52 PM
> To: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCHv3 2/4] OMAP1: Serial: remobe magic from MDR1 register

1. s/remobe/remove 
2. s/remove magic/remove magic number 

After this also, patch title does not match with code. You are not modifying 
anything to MDR1 register. You are replacing hardcoded values in serial
API's with macros defined in serial header.

Pls fix patch title accordingly.                                            

-Manjunath

[...]