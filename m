From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: U-boot 1.1.4 compilation problem
Date: Mon, 27 Mar 2006 15:48:18 +0900 (JST)
Message-ID: <20060327.154818.59488842.kaminaga@sm.sony.co.jp>
References: <C4DF42131A1F374CA3675F7B2EF03ECB0223925E@ES22SNLNT.srn.sandia.gov>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <C4DF42131A1F374CA3675F7B2EF03ECB0223925E@ES22SNLNT.srn.sandia.gov>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: jwgiron@sandia.gov
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

sorry for late reply,

> It is also necessary to change CFG_MAX_FLASH_BANKS to 2 (from 1).
> Otherwise the CFI driver will only detect a single 16MB bank, rather
> than the full 16MBx2 = 32MB.

Umm, that's right. Also if you change to 2, you also need to set
CFG_FLASH_BANKS_LIST too?


Best Regards,

(Hiroki Kaminaga)
t
--
