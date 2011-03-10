From: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
Subject: Re: [RFC PATCHv1 0/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 14:36:27 +0100
Message-ID: <4D78D3DB.90708@stericsson.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110310130527.GA2154@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110310130527.GA2154@besouro.research.nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "maxime_coquelin@yahoo.fr" <maxime_coquelin@yahoo.fr>, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Walker <dwalker@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Hi Eduardo,

On 03/10/2011 02:05 PM, Eduardo Valentin wrote:
>
>> The first patch introduces the common part, which provides an interface to the platform to register its name, and exports platform-defined IDs to user-space.
>> The IDs strings can be provided in two ways: either with a pointer to the string, or by a callback returning the string.
> Do you mind refreshing my memory why we need two ways of providing data to these attributes?
> I mean, I think if we provide the attribute value during registration time should be enough
> and simpler.
>
> Unless you guys are talking about attributes with changes over the time, I don't really see
> the need for the callback there. At least from the original scope, I don't see any attributes
> which would be exported under soc info which would change over the time.
>
> Or am I missing something?


It would be simpler indeed. But I don't know what are other SoC vendors 
needs, does someone need to export a piece of information which may 
change at runtime? If we all agree that providing a string at 
registration is enough, I'll remove it.
