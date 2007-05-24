From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH] OMAP: MUSB HOST support on 2430SDP
Date: Thu, 24 May 2007 12:02:23 -0700
Message-ID: <4655E13F.5080108@mvista.com>
References: <5DF83221BE20114E9C331F665ACBC08002FF6A9A@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08002FF6A9A@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Pandita, Vikram wrote:
> Fix Mentor controller DMA for OMAP2430/3430
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Signed-off-by: Nishant Kamat <nskamat@ti.com>
> 

With this patch, plus the plat_uds.c patch, I confirm that MUSB host is working on the 2430SDP.

Acked-by: Kevin Hilman <khilman@mvista.com>
