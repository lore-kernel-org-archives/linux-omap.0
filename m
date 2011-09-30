From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 1/3] AM35x: Using OMAP3 generic hwmods
Date: Fri, 30 Sep 2011 02:17:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109300217260.12185@utopia.booyaka.com>
References: <1317363153-10259-1-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-2-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317363153-10259-2-git-send-email-abhilash.kv@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: khilman@ti.com, linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, christian.gmeiner@gmail.com, aneesh@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Abhilash,

On Fri, 30 Sep 2011, Abhilash K V wrote:

> From: Abhilash K V <abhilash.kv@ti.com>
> 
> Removing modules iva, sr1_hwmod, sr2_hwmod, mailbox from
> the base omap3xxx_hwmods list, so that they can be excluded
> for am35x.
> 
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>

Looks good to me, provisionally queued for 3.2 fixes.


- Paul
