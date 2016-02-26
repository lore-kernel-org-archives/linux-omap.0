From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: Fix hwmod clock for l4_ls
Date: Fri, 26 Feb 2016 11:04:08 -0800
Message-ID: <20160226190407.GC13417@atomide.com>
References: <1456182245-1843-1-git-send-email-tony@atomide.com>
 <1456182245-1843-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1456182245-1843-2-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160222 15:04]:
> Looks like we have few cases with wrong clock, and some
> entries with missing clock. It should always be sysclk6
> for the l4_ls instance.

FYI, applying this into omap-for-v4.6/fixes-not-urgent, and
the rest of the series into omap-for-v4.6/soc and dt
branches.

Regards,

Tony
