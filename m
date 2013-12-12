From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCHv2 09/10] arm: dts: dra7: Add qspi device.
Date: Thu, 12 Dec 2013 09:50:44 +0530
Message-ID: <52A9399C.80006@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
 <1386339891-32717-10-git-send-email-sourav.poddar@ti.com>
 <20131209174203.GB12527@atomide.com> <52A697AB.1060404@ti.com>
 <20131210103108.GA29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131210103108.GA29268@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: marex@denx.de, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, balbi@ti.com, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, bcousson@baylibre.com, computersforpeace@gmail.com, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,
On Tuesday 10 December 2013 04:01 PM, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 09:55:15AM +0530, Sourav Poddar wrote:
>
>> I posted this for review along with other code changes.
>> I will post them seperately to Benoit.
> Please wait until the driver updates have been reviewed.
I was thinking of sending this dts patches seperately to benoit, so that we
can enable atleast 1/4 bit mode for our controller. Anyways, there is no
memory mapped specific binding used. Once, we get our driver updates
reviewed and *if* there is anything memory mapped specific added, I can
send them as a seperate patch. Anyways with spi nor  framework in sight the
driver uodates can go anyewhere and might take some time.
.
Does this sound Ok to you?

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
