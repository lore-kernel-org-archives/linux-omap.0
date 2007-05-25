From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Re-add a lost TSC2102 touchscreen Kconfig entry
Date: Thu, 24 May 2007 17:31:57 -0700
Message-ID: <20070525003157.GD19506@atomide.com>
References: <fb249edb0705221022s5bec31d4r77bfc16373262b4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0705221022s5bec31d4r77bfc16373262b4e@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [070522 10:23]:
> The TSC2102 option in drivers/input/touchscreen/Kconfig got lost
> somewhere in January (although the commit is not visible in git-web),
> so adding it back.  Also remove the input_dev.dev assignment due to an
> upstream change.

Pushing today.

Tony
