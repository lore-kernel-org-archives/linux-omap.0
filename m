From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/8] musb: set 'extvbus = 0' for OMAP3 boards
Date: Tue, 17 Nov 2009 19:01:05 +0300
Message-ID: <4B02C8C1.4040209@ru.mvista.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-2-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-3-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-4-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-5-git-send-email-ajay.gupta@ti.com>	<1258470596-24321-6-git-send-email-ajay.gupta@ti.com> <1258470596-24321-7-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:57753 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751986AbZKQQA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 11:00:27 -0500
In-Reply-To: <1258470596-24321-7-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, cooloney@kernel.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, gadiyar@ti.com

Ajay Kumar Gupta wrote:

> Default value of 'extvbus' is being set as '0' to maintain the
> current programming state of all OMAP3 musb boards.

> This flag should be set to '1' for boards using external vbus
> supply such as, OMAP3EVM Rev >=E.

   This patch is rather pointless as the struct fieds not explictily 
initialized will be default to 0 anyway. You should only need to explicitly 
init to 1.

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

WBR, Sergei
