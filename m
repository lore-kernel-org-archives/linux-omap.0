From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH] OMAP2: add USB platform data and initialization for Nokia N800 and N810
Date: Tue, 29 Dec 2009 14:28:08 -0600
Message-ID: <200912291428.30133.luke@dashjr.org>
References: <200912290152.16357.luke@dashjr.org> <20091229192407.GA3512@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752519AbZL2U3A@vger.kernel.org>
In-Reply-To: <20091229192407.GA3512@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>
List-Id: linux-omap@vger.kernel.org

Quick followup... I haven't had the chance to make those clock changes or move 
it into the main board file yet, but just discovered my recent boot problems 
were "fixed" by disabling USB support, so apparently there's something else 
broken with my patch. :(

Unfortunately, without a trackback, I'm totally lost:

Unable to handle kernel NULL pointer dereference at virtual address 00000031
pgd = c0004000
[00000031] *pgd=000000000
Internal error: Oops: 17 [#1] PREEMPT
