From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] OMAP: Resubmitting support for 2K page nand
Date: Wed, 28 Nov 2007 13:59:11 -0800
Message-ID: <20071128215910.GB11825@atomide.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6D0@ntxsjombx02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <809D758398CC1F49AA8E493528AD4A27014DF6D0@ntxsjombx02.micron.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sshahrom@micron.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* sshahrom@micron.com <sshahrom@micron.com> [070919 14:21]:
> 
> Hello,
> Following patches would add support for 2k Page nand with Enabled HW ECC on omap2430 v4.0. and v5. It has been Tested with Micron Nand. 
> The Patch is against 2.6.23 linux-omap.git tree. As Always all the comments are welcomed.

I've made some formatting changes and pushed this series
in two patches. I also moved some defines from the header
to the driver file. Can you please check?

Regards,

Tony
