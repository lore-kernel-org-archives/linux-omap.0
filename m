From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 23/35] drivers/mfd: Convert remaining uses of pr_warning
 to pr_warn
Date: Wed, 15 Mar 2017 07:17:24 -0700
Message-ID: <1489587444.2582.6.camel@perches.com>
References: <cover.1487314666.git.joe@perches.com>
 <a6c827c14d0b9f4be42e549ec4c629245516e979.1487314667.git.joe@perches.com>
 <20170314140455.umlhdbuj3grqtu6i@dell>
 <1489511868.2582.2.camel@perches.com>
 <20170315122300.jwuogngm6obgvz5z@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170315122300.jwuogngm6obgvz5z@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2017-03-15 at 12:23 +0000, Lee Jones wrote:
> On Tue, 14 Mar 2017, Joe Perches wrote:
[]
> > never break user-visible strings such as
> > printk messages, because that breaks the ability to grep for them.
> 
> Right, I'm aware of this.  I'm also aware of the other rule we have
> where lines are not to exceed 80 chars.  Hence my question; "is the 80
> chars rule the lessor sin of the two".
> 
> Rock <=> hard place
> 
> Actually I would say that the error message sub-optimal and could, in
> fact be edited to be more succinct, thus not breaking any rules. 

It's not a 'sin' at all.

The rule is to exceed 80 columns when the logging
message format is long.

I didn't even look at the format content.
Change it if you wish.
