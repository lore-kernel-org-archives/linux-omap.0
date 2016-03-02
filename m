From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: Use srst_udelay for USB on dm814x
Date: Wed, 2 Mar 2016 03:30:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603020329440.8658@utopia.booyaka.com>
References: <1456883702-32377-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456883702-32377-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Nicolas Chauvet <kwizart@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Philipp Rosenberger <ilu@linutronix.de>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 1 Mar 2016, Tony Lindgren wrote:

> Without this booting t410 can fail randomly with no output
> depending on the .config options chosen. Enabling debug_ll
> causes the problem to go away. I narrowed this down to USB
> by disabling one module at a time.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Wow, nice.  Bet that was a pain!

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
