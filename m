From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 27/30] ARM: omap: select L2X0 cache on omap4
Date: Mon, 03 Oct 2011 10:59:00 +0530
Message-ID: <4E89481C.4070405@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-28-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317566760-25681-28-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> The cache controller needs to be enabled for the
> cortex-a9 specific errata that are also selected
> to work.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	
