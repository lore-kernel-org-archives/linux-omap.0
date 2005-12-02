From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]OSS AUDIO: Use struct platform driver and compilation fix
Date: Thu, 1 Dec 2005 16:42:32 -0800
Message-ID: <20051202004232.GE7718@atomide.com>
References: <20051201104956.74752.qmail@web32904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051201104956.74752.qmail@web32904.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [051201 02:52]:
> Tony,
> 
> Attached patch uses struct platform_driver and 
> used __SEMAPHORE_INIT(name,count) instead of DECLARE_MUTEX(), which is
> a non standard way.

Pushing today.

Tony
