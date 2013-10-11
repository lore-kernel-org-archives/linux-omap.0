From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFCv3 0/7] OMAP SSI driver
Date: Fri, 11 Oct 2013 10:06:07 +0200
Message-ID: <CACRpkdbGtMbuQe9mXrGWCMOvZNZxdRo=xt2bPVxpEK-xphsywQ@mail.gmail.com>
References: <1381091235-18293-1-git-send-email-sre@debian.org>
 <20131008172815.GA8313@atomide.com>
 <20131010172128.GF28657@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131010172128.GF28657@earth.universe>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>Linu
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 10, 2013 at 7:21 PM, Sebastian Reichel <sre@debian.org> wrote:

> 1. I create another patch, which adds entries for hsi subsystem and
>    ssi driver to MAINTAINERS.
>
>    It would be nice to have some co-maintainers for the subsystem.
>    Linus Walleij maybe? I think you created the launchpad blueprint [1]?

Well yeah I did... but I do not think this is big enough a subsystem to
require two maintainers right now, also I have no easily available HSI
hardware that I can use to test things. (I think.)

Yours,
Linus Walleij
