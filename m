From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Tue, 25 Nov 2008 02:01:09 -0800
Message-ID: <200811250201.09214.david-b@pacbell.net>
References: <12275961701188-git-send-email-ext-eero.nurkkala@nokia.com> <200811242327.12026.david-b@pacbell.net> <1227604759.27458.16.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27706 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752519AbYKYKBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 05:01:11 -0500
In-Reply-To: <1227604759.27458.16.camel@eenurkka-desktop>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

On Tuesday 25 November 2008, Eero Nurkkala wrote:
> Shortly: Restate the introductory header and resend the patches?

Restate, and update the patch to address the issues noted inline.
You had added the

	if (34xx) {
		...
	} else /* must be 2430 */ {
		...
	}

branches, but since 34xx and 2430 act the same there (per Tony's
check of the 2430 manual) ... neither the check, nor the "else"
branch, is needed.



