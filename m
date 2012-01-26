From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/21] OMAP3+: SR: introduce class init,deinit and priv
 data
Date: Thu, 26 Jan 2012 15:31:14 +0400
Message-ID: <4F213982.9020601@ru.mvista.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com> <1327504583-13408-13-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47786 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751506Ab2AZLcW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 06:32:22 -0500
In-Reply-To: <1327504583-13408-13-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Hello.

On 25-01-2012 19:16, Jean Pihet wrote:

> From: Nishanth Menon<nm@ti.com>

> Certain class drivers such as class 1.5 drivers, will need specific
> notification that they have to be inited up or deinited independent
> of smart reflex operation. They also may need private data to be
> used for operations of their own, provide the same.
> This allows the class driver to initialize it's internal data structures
> on a need basis in preparation for the specific domain's autocomp usage.
> The resultant operation is as follows:
> when autocomp is set to 1 ->  class drivers' init is called
> The existing enable/disable is still used as before by the SmartReflex
> core driver to enable disable the class operation.
> When autocomp is set to 0 ->  class drivers' deinit is called, signaling
> the end of usage for that domain.

> Change-Id: Ie6a4b163d52af4931a4506ed7a3a6b752173a674

    Please remove this line.

> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>

WBR, Sergei
