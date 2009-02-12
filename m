From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP I2C question
Date: Thu, 12 Feb 2009 12:52:55 -0800
Message-ID: <200902121252.55277.david-b@pacbell.net>
References: <499303C3.3030101@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:45608 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754719AbZBLUw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Feb 2009 15:52:57 -0500
In-Reply-To: <499303C3.3030101@mlbassoc.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Linux OMAP <linux-omap@vger.kernel.org>

On Wednesday 11 February 2009, Gary Thomas wrote:
> Why is I2C_FUNC_SMBUS_QUICK functionality missing in i2c-omap.c?

The I2C controllers are not documented as supporting it.

