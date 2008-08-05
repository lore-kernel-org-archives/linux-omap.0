From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Tue, 5 Aug 2008 07:15:46 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361EE1A9C@dlee02.ent.ti.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	<20080805114920.GC27299@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20080805114920.GC27299@trinity.fluff.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Ben Dooks <ben-linux@fluff.org>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

> Is the controller allowed to write dirty cache lines out at any time
> it
> likes? Surely a better fix is to drain the cache of the changes before
> changing the clock for the SDRAM?

- Previously the SRAM was marked as cached.  _Execution_ using that attribute will generate line fetches to SRAM.  This will cause displacement write-outs of resident DDR lines.  Similarly, _load/store_ sequences in that code have the same effect.  This cast outs dead lock the CPU and it can't fetch to progress.

- In addition to the DVFS path there is a context-restore path which also needs to live in non-cached SRAM.  It will reset and reprogram the registers.  You can't completely re-program the DDR controller from the same memory it is executing from.

* You can go through all the trouble of pre-loading and locking to cache for the same code then unlocking but it adds unnecessary complexity.  It also exposes you to lots of early processor errata.

* Flushing the entire L1 & L2 cache frequently is very expensive and better not done if you don't have.  Also, it is not sufficient for the context-restore path which needs to NOT live in DDR.

The code need to execute in a non-cached region.

Regards,
Richard W.



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
