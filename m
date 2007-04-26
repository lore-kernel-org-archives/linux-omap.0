From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM:OMAP: Add initial TWL support for non-MPU MMU
	framework
Date: Thu, 26 Apr 2007 18:08:38 +0000
Message-ID: <20070426180838.GF9764@atomide.com>
References: <11757665933290-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11757665933290-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroshi.DOYU@nokia.com <Hiroshi.DOYU@nokia.com> [070405 09:47]:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> This enables non-MPU MMU(camere,iva,dsp) to use H/W page table
> walk. It will be free from the limitation of TLB entries in order to
> manage device's vm area.

Pushing today.

Tony
