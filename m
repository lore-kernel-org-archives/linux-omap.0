From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] ARM: OMAP: Use the correct CONFIG_ARCH_OMAP24XX
Date: Wed, 5 Dec 2007 19:12:22 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0712051909430.16173@utopia.booyaka.com>
References: <20071206014651.GA15983@party>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071206014651.GA15983@party>
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
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, 6 Dec 2007, Kyungmin Park wrote:

> Use the correct CONFIG_ARCH_OMAP24XX.
> It boots on locked SRAM board.

Acked-by: Paul Walmsley <paul@pwsan.com>

since CONFIG_ARCH_OMAP242X does not exist.


- Paul
