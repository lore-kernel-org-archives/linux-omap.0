From: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 14:16:16 +0100
Message-ID: <4D78CF20.8080203@stericsson.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110309174752.GC1225@sirena.org.uk>
	<4D78A0CC.1030705@stericsson.com>
	<20110310131828.GA7411@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110310131828.GA7411@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, "maxime_coquelin@yahoo.fr" <maxime_coquelin@yahoo.fr>, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kern>
List-Id: linux-omap@vger.kernel.org

On 03/10/2011 02:18 PM, Mark Brown wrote:
> On Thu, Mar 10, 2011 at 10:58:36AM +0100, Maxime Coquelin wrote:
>> On 03/09/2011 06:47 PM, Mark Brown wrote:
>>> Would it not be better for this to depend on a symbol that systems can
>>> select when they add useful output?  If there's nothing that generates
>>> information for it on a given platform there's no point in enabling it.
>> It is deactivated by default when "default" parameter is not mentioned.
> That's not the point - if the user sees the option and turns it on then
> there won't be anything they can actually do with it unless some other
> bit of software creates some data.  No sense in offering them an option
> they can't actually use.

I agree, I will remove the Kconfig option and let platform selects it.
