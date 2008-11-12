From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] [OMAPZOOM] Lower i2c speed on bus 1 for LDP.
Date: Wed, 12 Nov 2008 11:59:41 -0800
Message-ID: <200811121159.41804.david-b@pacbell.net>
References: <200811121307.35591.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:33088 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752636AbYKLT7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 14:59:44 -0500
In-Reply-To: <200811121307.35591.dcurran@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dominic Curran <dcurran@ti.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 12 November 2008, Dominic Curran wrote:
> Lower i2c bus 1 speed to 400KHz for LDP.

Does something go wrong if it's faster, then?

If so, the failure needs to be in the patch comment.
If not ...

