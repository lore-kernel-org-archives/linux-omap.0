From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.29-rc1, omap-2.6.28 branch added
Date: Sat, 17 Jan 2009 19:46:41 -0800
Message-ID: <200901171946.41218.david-b@pacbell.net>
References: <20090115154327.GF4128@atomide.com> <20090116081245.GS4128@atomide.com> <20090116085118.GT4128@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.gq1.yahoo.com ([67.195.14.95]:22371 "HELO
	smtp110.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751404AbZARDxY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 17 Jan 2009 22:53:24 -0500
In-Reply-To: <20090116085118.GT4128@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

> Then when it tries to boot, (a) the HSMMC driver reports
> "error -110" then chokes, so no root FS; and then (b) MUSB
> misdetects the high speed hub as full speed then chokes,
> so no network links either. ....

Found it.  A Kconfig option I thought was "off" got turned "on".

Even though the VMMC1, VDAC, VUSB1V5, VUSB1V8, and VUSB3V1
rails aren't yet enabled by the drivers using them ... they
sort of need to be left on (except for VDAC).  ;)

- Dave

