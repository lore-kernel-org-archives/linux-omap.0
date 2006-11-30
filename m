From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: mailbox module stability fix
Date: Thu, 30 Nov 2006 15:28:19 -0800
Message-ID: <20061130232818.GJ9605@atomide.com>
References: <7AF192DA69C59243838FF62851F64F55033BEEBF@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <7AF192DA69C59243838FF62851F64F55033BEEBF@toebe101.NOE.Nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Toshihiro.Kobayashi@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Toshihiro.Kobayashi@nokia.com <Toshihiro.Kobayashi@nokia.com> [061130 03:12]:
> mbox objects must be initialized before request_irq().

Pushing today.

Tony
