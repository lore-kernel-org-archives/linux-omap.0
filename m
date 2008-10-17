From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch FYI] twl4030 dumps revision info
Date: Thu, 16 Oct 2008 17:16:58 -0700
Message-ID: <200810161716.58536.david-b@pacbell.net>
References: <200810152123.42459.david-b@pacbell.net> <FCCFB4CDC6E5564B9182F639FC35608702396893F7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:28550 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752142AbYJQARB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2008 20:17:01 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702396893F7@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 16 October 2008, Pandita, Vikram wrote:
> >The main curiousity we've uncovered is that TWL5030 ES1.0
> >mis-identifies itself as TWL4030 ES1.0 ... unclear just now
> >whether that's also true of ES1.1 and later parts.
> 
> As per TRM, 
> the idcode for TWL5030 should be: 0x0009802F
> 
> is it not what you are observing? Or was it the , bug !!

On one part labeled tps65950, it was 00009002F.
On one labeled as a twl5030, ditto.

On one labeled as a twl4030, it was 5009002f.

Ergo the observation that the TWL5030 ES1.0
parts seem to mis-identify themselves.

- Dave

