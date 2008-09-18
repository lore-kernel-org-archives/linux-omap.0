From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: getting 2.6.25 from git to run on omap35x evm
Date: Thu, 18 Sep 2008 12:00:33 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087022A2BAB54@dbde02.ent.ti.com>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
	 <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
	 <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
	 <1f11a5490809171236k52fcc05q74ce5dfe1882d5cb@mail.gmail.com>
 <dbdb2ea60809171311g13631826m4b46a881ebbb1ae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38393 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbYIRGat convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 02:30:49 -0400
In-Reply-To: <dbdb2ea60809171311g13631826m4b46a881ebbb1ae5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Ashwin Bihari <abihari@gmail.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of twebb
> Sent: Thursday, September 18, 2008 1:41 AM
> To: Ashwin Bihari
> Cc: Koen Kooi; linux-omap@vger.kernel.org Mailing List
> Subject: Re: getting 2.6.25 from git to run on omap35x evm
> 
> On Wed, Sep 17, 2008 at 3:36 PM, Ashwin Bihari <abihari@gmail.com> wrote:
> >
> 
> Great, that's helpful.  Do you know omapzoom linux-2.6.25 to be
> somewhat functional with OMAP 35x EVM, or would you suggest going with
> something newer like v2.6.26-ti-07252008?  Or must I go to 2.6.27-rc3?
>  I assume newer (to a point) would result in better stability on the
> 35x EVM?

On omapzoom.org, I try to test for functionality complete and working for primarily LDP board and also 3430SDP. I have not tested the EVM stuff.

I just completed up merging omapzoom tree to 2.6.27rc6 on branch: branch_2.6.27rc6_migration
You could have a look at it if that helps.


> 
> Thanks,
> twebb
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

