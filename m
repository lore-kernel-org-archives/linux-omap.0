From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] OMAP2/3 omapdev: add basic omapdev structure
Date: Thu, 23 Oct 2008 00:26:27 -0700
Message-ID: <200810230026.27666.david-b@pacbell.net>
References: <20081018215247.9699.35039.stgit@localhost.localdomain> <20081018215908.9699.79756.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:26036 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751275AbYJWJEs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 05:04:48 -0400
In-Reply-To: <20081018215908.9699.79756.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Saturday 18 October 2008, Paul Walmsley wrote:
> In the medium- to long-term, it may be best
> to use a generic device pointer so system devices can be linked also;

Best IMO to start phasing out system devices; they're
superfluous, given some power management changes from
late last year.

