From: tony@atomide.com
Subject: Re: [PATCH] Remove deprecated field and wrong commited file on
	apollon
Date: Thu, 26 Jan 2006 09:31:55 -0800
Message-ID: <20060126173155.GA10951@atomide.com>
References: <0ITO009TKG7TVJ@mmp1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <0ITO009TKG7TVJ@mmp1.samsung.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [060125 18:04]:
> Hi
> 
> As Komal shah's mentioned, phys_ram is deprecated. so remove it.
> And in previous patch, there's wrong commited file '
> include/asm/arch/board-apollon.h'. It must be deleted.

Just pushed it. As include/asm/arch got temorarily created as a
directory instead of symlink, making make mrproper is recommended :)

Tony
