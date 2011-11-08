From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] arm: cpuidle34xx.c: Fix compile error
Date: Tue, 08 Nov 2011 09:36:48 -0800
Message-ID: <87hb2eqzwv.fsf@ti.com>
References: <1320768665-9759-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320768665-9759-1-git-send-email-joerg.roedel@amd.com> (Joerg
	Roedel's message of "Tue, 8 Nov 2011 17:11:05 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Joerg Roedel <joerg.roedel@amd.com> writes:

> Add missing module.h include to provide THIS_MODULE.
>
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

FYI...

Tony has already queued fix for this in his fixes branch.

     http://marc.info/?l=linux-arm-kernel&m=132071036621713&w=2

Kevin
