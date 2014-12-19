From: Paul Walmsley <paul@pwsan.com>
Subject: linux-next: add the omap-pending tree
Date: Fri, 19 Dec 2014 19:28:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412191715230.3102@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sfr@canb.auug.org.au
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi Stephen,

Might you be willing to include this branch in your linux-next builds?

git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git#for-next

It will include OMAP clock, bus architecture, and low-level power 
management patches that are planned to be included in pull requests to the 
OMAP upstream maintainer, Tony Lindgren.  He in turn will submit pull 
requests to the arm-soc tree.  The objective in including this branch is 
to get these patches integration-tested earlier than they would be 
otherwise.


regards,

- Paul
