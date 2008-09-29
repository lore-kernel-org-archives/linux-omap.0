From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: i2c errors on omap3430sdp
Date: Mon, 29 Sep 2008 17:12:11 +0300
Message-ID: <20080929141211.GK13245@gandalf.research.nokia.com>
References: <A24693684029E5489D1D202277BE89441207F124@dlee02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35199 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYI2OMq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 10:12:46 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89441207F124@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Sep 29, 2008 at 08:59:38AM -0500, ext Aguirre Rodriguez, Sergio Alberto wrote:
> Hi all,
> 
> I'm currently testing the OV3640 CSI2 camera implementation for 3430SDP, and I had it working some weeks ago.
> 
> Today I did a git pull from the master branch.
> 
> Without changing anything i2c related, I now sometimes get a message that I wasn't getting before:
> 
> i2c_omap i2c_omap.2: controller timed out waiting for start condition to finish
> i2c_omap i2c_omap.2: controller timed out waiting for start condition to finish
> 
> Anyone is seeing this?
> 
> Any omap i2c registration changes that I could be missing?

Is you driver new style i2c driver ???

Can you put some printks in your driver and try to narrow down which
transfer is triggering this timeout ??

-- 
balbi
