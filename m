From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: Implemented support for VFP PM context saving
Date: Tue, 24 Nov 2009 11:48:36 +0000
Message-ID: <20091124114836.GA10510@n2100.arm.linux.org.uk>
References: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com> <1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57470 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572AbZKXLsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 06:48:45 -0500
Content-Disposition: inline
In-Reply-To: <1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Nov 24, 2009 at 12:37:03PM +0200, Tero Kristo wrote:
> In some ARM architectures, like OMAP3, the VFP context can be lost during
> dynamic sleep cycle. For this purpose, there is now a function
> vfp_pm_save_context() that should be called before the VFP is assumed to
> lose context. Next VFP trap will then restore context automatically.
> 
> We need to have the last_VFP_context[cpu] cleared after the save in idle,
> else the restore would fail to restore when it sees that the last_VFP_context
> is same as the current threads vfp_state. This happens when the same
> process/thread traps an exception post idle.
> 
> Main work for this patch was done by Peter and Rajendra. Some cleanup and
> optimization by Tero.

Why not re-use vfp_pm_suspend() ?  Haven't you shown that vfp_pm_suspend
may be buggy since it doesn't save in the VFP-disabled case?
