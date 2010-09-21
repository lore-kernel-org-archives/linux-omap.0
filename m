From: Luciano Coelho <luciano.coelho@nokia.com>
Subject: Re: [PATCH v6 4/7] wl1271: take irq info from private board data
Date: Tue, 21 Sep 2010 08:38:57 +0300
Message-ID: <1285047537.17849.12.camel@powerslave>
References: <1284593495-30012-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1284593495-30012-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ext Ohad Ben-Cohen <ohad@wizery.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "John W. Linville" <linville@tuxdriver.com>, San Mehat <san@google.com>, Vitaly Wool <vitalywool@gmail.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ido Yariv <ido@wizery.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-09-16 at 01:31 +0200, ext Ohad Ben-Cohen wrote:
> Remove the hard coded irq information, and instead take
> the irq information from the board's platform data.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---

Acked-by: Luciano Coelho <luciano.coelho@nokia.com>

-- 
Cheers,
Luca.
