From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: OMAP 3430SDP i2c boot crash
Date: Fri, 16 Apr 2010 11:58:32 +0300
Message-ID: <20100416085832.GB6718@gw.healthdatacare.com>
References: <1271406087.2690.286.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:33985 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341Ab0DPI6h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 04:58:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so196165fgg.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 01:58:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271406087.2690.286.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Apr 16, 2010 at 11:21:27AM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> I haven't been able to boot my OMAP 3430SDP board with mainstream kernel
> for a while, with the omap_3430sdp_defconfig. Anyone else having
> problems? I don't get anything on the console after "Uncompressing
> Linux... done, booting the kernel.", and Trace32 shows the log below.

This is fixed with following patches (pick one):

http://marc.info/?l=linux-omap&m=126826012627677&w=2
https://patchwork.kernel.org/patch/87590/

MW
