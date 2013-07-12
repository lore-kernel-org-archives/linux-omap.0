From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] arm: omap2plus: unidle devices which are about to probe
Date: Fri, 12 Jul 2013 17:57:51 +0530
Message-ID: <51DFF647.6030709@ti.com>
References: <20130711092612.GG23892@arwen.pp.htv.fi>
 <1373537788-30413-1-git-send-email-balbi@ti.com> <51DFEF59.1010509@ti.com>
 <20130712121031.GB17053@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130712121031.GB17053@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: paul@pwsan.com, Grygorii Strashko <grygorii.strashko@ti.com>, mpfj-list@newflow.co.uk, Tony Lindgren <tony@atomide.com>, vaibhav.bedia@ti.com, Kevin Hilman <khilman@linaro.org>, Sourav Poddar <sourav.poddar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 12 July 2013 05:40 PM, Felipe Balbi wrote:
>> 3) I've checked most of OMAP drivers and all of them solve such kind
>> > of problem internally (SPI, MMC, I2C, etc.)
> and you see no problem with that ? Repeating the same thing over and
> over again ?
> 

I agree with Felipe that this is best handled at the bus/omap-device level
to avoid all drivers having to repeat the same thing over.
Having said that I dont know whats the best way to do this for OMAP and the
patch we have currently does seem to have atleast issues handling processor
IPs as Suman mentioned.

regards,
Rajendra
