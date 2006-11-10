From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Resubmitting 2430 Support - 2430 /arm/mach-omap2
Date: Fri, 10 Nov 2006 22:37:13 +0200
Message-ID: <20061110203712.GG26185@atomide.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01D91948@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01D91948@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [061110 21:13]:
> Hi Tony,
> 
> The attached patch is for the arch/arm/mach-omap2 directory. The
> existing files were updated to add OMAP2430 functionality. A new file
> "board-2430sdp.c" is added to this directory.
> 
> I have removed the sync port that was in my previous patch. The new
> files are indented (Lindent). 

Thanks. I re-indented a bit more to remove spaces, and pushed this patch
and the include files as a single patch.

Regards,

Tony
