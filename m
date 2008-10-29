From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.28-rc2, old sound and v4l drivers removed
Date: Wed, 29 Oct 2008 12:30:31 -0700
Message-ID: <200810291230.31271.david-b@pacbell.net>
References: <20081027204323.GA7539@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:27954 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754815AbYJ2Tad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 15:30:33 -0400
In-Reply-To: <20081027204323.GA7539@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Monday 27 October 2008, Tony Lindgren wrote:
> I've updated our git tree to 2.6.28-rc2

FYI the cpufreq stuff seemed to be causing memory
corruption (on H4) till I took it out of the build.
