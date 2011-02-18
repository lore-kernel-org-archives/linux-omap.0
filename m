From: Felipe Balbi <balbi@ti.com>
Subject: Re: watchdog pdev id set to -1
Date: Fri, 18 Feb 2011 13:12:37 +0200
Message-ID: <20110218111237.GE10489@legolas.emea.dhcp.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870370061699@dbde02.ent.ti.com>
 <20110218105635.GB10489@legolas.emea.dhcp.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608703700616CE@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41903 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754171Ab1BRLMm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 06:12:42 -0500
Received: by mail-bw0-f48.google.com with SMTP id 8so3986332bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 03:12:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703700616CE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

(don't top-post)

On Fri, Feb 18, 2011 at 04:39:48PM +0530, Koyamangalath, Abhilash wrote:
> I understand, but is there a subtle reason why are starting from
> an erroneous-looking -1 rather than a more natural 0 (or 1 ?).

-1 means no ID. The IDs are zero-based, so we can't use zero. Just
change that value and see how things change on sysfs and dmesg then you
will know what I'm talking about. That's just an implementation decision
of using -1 to signify "no ID needed".

-- 
balbi
