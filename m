From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: Pending March patches
Date: Mon, 02 Apr 2007 09:21:48 +0300 (EEST)
Message-ID: <20070402.092148.06273156.Hiroshi.DOYU@nokia.com>
References: <460FD29D.7070707@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <460FD29D.7070707@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: dirk.behme@googlemail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: "ext Dirk Behme" <dirk.behme@googlemail.com>
Subject: Pending March patches
Date: Sun, 01 Apr 2007 17:41:17 +0200

> 
> Please find below my list of pending OMAP patches for March 
> 2007. As ususal, if you think anything is wrong, missing or 
> already applied, please correct.
> 
> 
> Pending OMAP patches March 2007
> -------------------------------
> 
> 3. [PATCH 1/1] OMAP: Add TWL support for omap mmu framework
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009313.html

This is being rewritten to use ARM MMU mechanism because their logic
is almost same as ARM MMU and "mm_struct" and "vm_area_struct" can be
used to manage virtual address for omap mmu framework. This would be
much simpler and better. I will re-send the patch later.

  Hiroshi DOYU
