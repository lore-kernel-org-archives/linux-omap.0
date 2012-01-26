From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 09/21] OMAP3+: Smartreflex: Fix status masking in ERRCONFIG
 register
Date: Thu, 26 Jan 2012 15:28:04 +0400
Message-ID: <4F2138C4.1070506@ru.mvista.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com> <1327504583-13408-10-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47741 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752697Ab2AZL3M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 06:29:12 -0500
In-Reply-To: <1327504583-13408-10-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Hello.

On 25-01-2012 19:16, Jean Pihet wrote:

> From: Nishanth Menon<nm@ti.com>

> ERRCONFIG register has status bits that were intended not to
> be destroyed by bad modification. We cleanup and simplify the
> handling the status in the modify path.

> Change-Id: I5a7e19fe924a05ffe38c8e31ae8acc48aee8c3f6

    Please remove this line.

> Reported-by: Vincent Bour<v-bour@ti.com>
> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>

WBR, Sergei
