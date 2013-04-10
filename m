From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: Kexec couldn't reboot capture kernel on pandaboard ES with OMAP4460
Date: Wed, 10 Apr 2013 09:54:02 -0600
Message-ID: <51658B1A.6090706@wwwdotorg.org>
References: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59283 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934856Ab3DJPyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 11:54:07 -0400
In-Reply-To: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Li Haifeng <omycle@gmail.com>
Cc: pandaboard@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org

On 04/10/2013 03:35 AM, Li Haifeng wrote:
> Hi, everyone.
> 
> Recently, I try to run kdump on pandaboard ES with omap4460. After
> load capture kernel by "kexec -l" and execute "kexec -e", the serial
> port output "Starting new kernel" and "Bye", then the system hangs up.
> 
> I have tried the upstream Linux Kernel v3.4 and v3.8. All are with this issue.

This is a shot in the dark. I assume you have SMP enabled. Can you use
hotplug to remove all CPUs other than CPU0, so that the kexec happens on
the boot CPU? That is certainly necessary for kexec to work correctly on
Tegra.
