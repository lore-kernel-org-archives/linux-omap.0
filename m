From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: Issues with ADATA SD cards on OMAP?
Date: Wed, 12 Jan 2011 11:47:01 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A6F2808@dbde02.ent.ti.com>
References: <AANLkTinw=ZjiOr1KHNxu1Npq5iLucOPyw0Gumdyq1jjS@mail.gmail.com>
	<AANLkTi=SKb9wCUMyvvT59qYCMm8wViZRAYgtDOJXiLKy@mail.gmail.com>
	<B00BD5DB-31BB-42C8-B360-241173342F86@mac.com>
 <AANLkTik8wTknohEDfNnoYsZt8xuQRb48gUC7T_Xg+afz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53986 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832Ab1ALGRI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 01:17:08 -0500
In-Reply-To: <AANLkTik8wTknohEDfNnoYsZt8xuQRb48gUC7T_Xg+afz@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Steve Sakoman
> Sent: Sunday, January 09, 2011 10:45 PM
> To: Elvis Dowson
> Cc: linux-omap Mailing List
> Subject: Re: Issues with ADATA SD cards on OMAP?
> 
> On Sun, Jan 9, 2011 at 9:07 AM, Elvis Dowson <elvis.dowson@mac.com> wrote:
> > Hi Steve,
> >
> > On Jan 9, 2011, at 9:00 PM, Steve Sakoman wrote:
> >
> >>> mmcblk0: error -110 sending read/write command, response 0x900, card
> >>> status 0xe00
> >
> > Error -110 is ETIMEOUT.
> >
> > The card might be getting detected but not powering up, perhaps?
> something to do with
> > voltage regulator setup or probably a bad mmc hardware port?
> 
> Not likely to be bad hardware since it fails the same way on multiple
> Overo and Beagle boards.
> 
> And not likely to be a bad SD card, since the cards work perfectly on
> my desktop and laptop.
> 
> I suspect something marginal in the mmc interface hw/config.  If you
> look at the schematics for most boards the mmc card is directly
> connected to the OMAP for signal lines, and the twl4030 for power.
> 
> As such, I'm not surprised that these cards fail with every OMAP3
> board I've tried.
> 
> > I'm using a 2GB class 4 SanDisk microSD card with a custom beagle board,
> and tried it with
> > android-2.6.32 kernel as well as mainline 2.6.37-rc7 kernel, it worked
> fine.
> 
> Sure, I have tons of SanDisk cards that work perfectly (and always
> have).  It is the brand new, just out of the box Sandisk that fails.
> 
[Ghorai] 
We also experienced the same issue using 32GB SD card for omap3 and omap4.
And the problem is seen is that DTO value (in SYSCTL) is not current
in following function. 

So add the following modification and please update the status.
And we will submit proper patch towards the same.

static void set_data_timeout(..){
...
      cycle_ns = 1000000000 / (clk_get_rate(host->fclk) / clkd);
	timeout = timeout_ns / cycle_ns;
	timeout += timeout_clks;
+ timeout *=2;
      if (timeout) {
...
}
