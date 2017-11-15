From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 5/5] misc serdev: w2sg0004: add debugging code and
 Kconfig
Date: Wed, 15 Nov 2017 19:08:20 +0100
Message-ID: <99572C7F-9242-4D86-896A-9824DEE9EE8A@goldelico.com>
References: <cover.1510759152.git.hns@goldelico.com>
 <9b4969c858d4c3801bb796f92dad5c580799b768.1510759152.git.hns@goldelico.com>
 <28e16c7a-2688-a302-1548-1cdc2552f0ad@suse.de>
 <DC57A290-669C-4B3C-A4EE-2ABEA37F47CE@goldelico.com>
 <20171115164257.2mbbk7yqhq3puc5a@lenoch>
 <2CFA9F17-0E65-4804-9971-922500F5E919@goldelico.com>
 <1510768342.2006.54.camel@perches.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1510768342.2006.54.camel@perches.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joe Perches <joe@perches.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, letux-kernel@openphoenux.org, Thierry Reding <treding@nvidia.com>, =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org


> Am 15.11.2017 um 18:52 schrieb Joe Perches <joe@perches.com>:
> 
> On Wed, 2017-11-15 at 18:13 +0100, H. Nikolaus Schaller wrote:
>> We have automated things by calling checkpatch but it somwhow failed here.
> 
> what failed?

I don't know. It didn't tell us that the signature was missing. Maybe
a glitch in our post-processing script. I tried again and checkpatch.pl
did clearly report the ERROR this time.

So nothing you can fix.

BR and thanks,
Nikolaus Schaller
