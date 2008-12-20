From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: I2C1 controller timed out issue
Date: Sat, 20 Dec 2008 16:09:29 +0200
Message-ID: <20081220131321.GB10866@frodo>
References: <f502236f0812200204h1ef1df01sf79243e6e276074d@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60279 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbYLTOJk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Dec 2008 09:09:40 -0500
Content-Disposition: inline
In-Reply-To: <f502236f0812200204h1ef1df01sf79243e6e276074d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pramod gurav <pramodforum@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

On Sat, Dec 20, 2008 at 03:34:00PM +0530, pramod gurav wrote:
> Hi,
> I am working on OMAP3430 board. The kernel is linux-omap-2.6.
> The twl5030 module is sitting on i2c1.
> I often come across a error saying
> 
> i2c_omap i2c_omap.1: controller timed out
> i2c_omap i2c_omap.1: controller timed out
> 
> This is all what appears in logs when i2c1 times out and all the
> other slave devices on i2c1 stop responding. Other i2c busses(2)
> work properly. if try to reboot the I2C fails to respnd in u-boot also
> saying
> 
> timed out in wait_for_pin: I2C_STAT=0
> I2C read failed
> timed out in wait_for_pin: I2C_STAT=0
> I2C read failed
> timed out in wait_for_pin: I2C_STAT=0
> I2C read failed
> 
> I have to to do hard reset to progress with the boot.
> 
> I gone through the changes happened to i2-omap driver in between
> and tried applying the patches manually.
> The problem still persists.
> May be I am missing some more changes.
> 
> The i2-omap.c source is attached herewith this mail.
> Somebody please suggest me on this issue if this has been seen as
> a issue and if fixed.

Are you using current linux-omap from git ? This problem is long gone.

-- 
balbi
