From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/17] omap2 patches for post 2.6.25, take #2
Date: Tue, 18 Mar 2008 16:01:58 +0200
Message-ID: <1205848935-12078-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: omap2-upstream-2008-03-18-160209
References: omap2-upstream-2008-03-18-160209
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

I've split out some of the big patches for the 80K limit for the mailing
list, and added one new patch. Also fixed few typos. So here's the resent
series:

Attached patch series starts syncing up arch/arm/mach-omap2 directory with
linux-omap tree. The patchset updates pin multiplexing, register access
and clock framework in order to add support for 34xx later on.

The register access and clock framework changes are quite large, but they
allow us to share clock and PM code with 24xx and 34xx.

I've combined Paul's register access and clock framework changes into
larger patches, as in the linux-omap tree they have been done in many 
add-replace-fix cycles.

Regards,

Tony


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
