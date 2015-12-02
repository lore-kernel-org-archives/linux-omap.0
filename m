From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH 10/10] ARM: dts: Fix dm814x pinctrl address and mask
Date: Wed, 2 Dec 2015 01:25:39 +0100
Message-ID: <CAALWOA9LtWxFmKB_My7cv4KODBEmyPm=dUb=tPuap79fm7FkxA@mail.gmail.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-11-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449013103-23238-11-git-send-email-tony@atomide.com>
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
Cc: Neil Armstrong <narmstrong@baylibre.com>, Delio Brignoli <dbrignoli@audioscience.com>, lkml <linux-kernel@vger.kernel.org>, Philipp Rosenberger <ilu@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 2 December 2015 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
> -                                       pinctrl-single,function-mask = <0x300ff>;
> +                                       pinctrl-single,function-mask = <0x707ff>;

Reminder that silicon revision 2.1 and older require input enabled
(bit 18 set) for all 3.3V I/Os to avoid cumulative hardware damage.
(Errata advisory 2.1.87)
