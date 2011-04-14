From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] Fixed gpio polarity of gpio USB-phy reset.
Date: Thu, 14 Apr 2011 15:02:01 +0400
Message-ID: <4DA6D429.3000801@ru.mvista.com>
References: <1302766303-1157-1-git-send-email-J.Kilb@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1302766303-1157-1-git-send-email-J.Kilb@phytec.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Kilb <J.Kilb@phytec.de>
Cc: linux-arm-kernel@lists.infradead.org, dbrownell@users.sourceforge.net, balbi@ti.com, gregkh@suse.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

Hello.

On 14-04-2011 11:31, Juergen Kilb wrote:

> With commit 19403165 a main part of ehci-omap.c moved to
> drivers/mfd/omap-usb-host.c created by commit 17cdd29d.

    Pelase also specify the summaries of those commits -- for the human readers.

> Due to this reorganisation the polarity used to reset the
> external USB phy changed and USB host doesn't recognize
> any devices.

> Signed-off-by: Juergen Kilb <J.Kilb@phytec.de>

WBR, Sergei
