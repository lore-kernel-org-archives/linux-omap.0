From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Wed, 11 Mar 2009 17:28:03 -0800
Message-ID: <200903111828.04188.david-b@pacbell.net>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com> <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com> <20090311235908.GC19038@gandalf>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:43782 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750765AbZCLB2I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 21:28:08 -0400
In-Reply-To: <20090311235908.GC19038@gandalf>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Paul Walmsley <paul@pwsan.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Ben Dooks <ben@fluff.org.uk>, ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

On Wednesday 11 March 2009, Felipe Balbi wrote:
> According to Thomas (and Ingo, I'd say) all drivers should call
> request_irq() with IRQF_DISABLED and that's gonna be true as soon as the
> threaded irq handler support gets merged, if I'm not wrong.

Well, they're wrong.

Folk like Dave Miller, Andrew Morton, Benjamin Herrenschmdit,
and Alan Cox have come out on the saner side of that.


