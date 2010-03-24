From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] musb: fix power field to hold all possible values
Date: Wed, 24 Mar 2010 10:11:09 +0200
Message-ID: <20100324081109.GB29419@nokia.com>
References: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32487 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab0CXIMw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 04:12:52 -0400
Content-Disposition: inline
In-Reply-To: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Feb 23, 2010 at 10:46:44AM +0100, ext Ajay Kumar Gupta wrote:
>MUSB can supply upto 500mA such as, AM3517 and OMAP3EVM Rev >=E and thus
>the 'power' field has to hold values above 255.
>
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

applied, thanks

-- 
balbi
